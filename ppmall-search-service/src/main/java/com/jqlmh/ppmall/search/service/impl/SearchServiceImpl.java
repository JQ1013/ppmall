package com.jqlmh.ppmall.search.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.jqlmh.ppmall.bean.PmsSearchParam;
import com.jqlmh.ppmall.bean.PmsSearchSkuInfo;
import com.jqlmh.ppmall.service.SearchService;
import io.searchbox.client.JestClient;
import io.searchbox.core.Search;
import io.searchbox.core.SearchResult;
import org.apache.commons.lang3.StringUtils;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.MatchQueryBuilder;
import org.elasticsearch.index.query.TermQueryBuilder;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.highlight.HighlightBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author LMH
 * @create 2020-04-21 19:53
 */
@Service
public class SearchServiceImpl implements SearchService {


	@Autowired
	private JestClient jestClient;

	/**
	 * 根据搜索条件+三级id+平台属性值返回信息集合
	 *
	 * @param pmsSearchParam
	 * @return List<PmsSearchSkuInfo>
	 */
	@Override
	public List<PmsSearchSkuInfo> list(PmsSearchParam pmsSearchParam) {

		//平台属性值Id集合
		String[] valueIds = pmsSearchParam.getValueId();
		//搜索词
		String keyword = pmsSearchParam.getKeyword();
		//三级id
		String catalog3Id = pmsSearchParam.getCatalog3Id();

		//jest的dsl工具
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();  //封装了query的字符串
		//bool
		BoolQueryBuilder boolQueryBuilder = new BoolQueryBuilder();

		//filter
		if (StringUtils.isNotBlank(catalog3Id)) {
			boolQueryBuilder.filter(new TermQueryBuilder("catalog3Id", catalog3Id));
		}

		if (valueIds != null) {
			for (String valueId : valueIds) {
				boolQueryBuilder.filter(new TermQueryBuilder("skuAttrValueList.valueId", valueId));
			}
		}

		//must
		if (StringUtils.isNotBlank(keyword)) {
			boolQueryBuilder.must(new MatchQueryBuilder("skuName", keyword));
		}

		//query
		searchSourceBuilder.query(boolQueryBuilder);

		//分页显示:from和size
		searchSourceBuilder.from(0);
		searchSourceBuilder.size(20);

		//高亮显示
		HighlightBuilder highlightBuilder = new HighlightBuilder();
		highlightBuilder.field("skuName");
		highlightBuilder.preTags("<span style='color:red'>");
		highlightBuilder.postTags("</span>");
		searchSourceBuilder.highlight(highlightBuilder);

		//排序
		searchSourceBuilder.sort("id", SortOrder.DESC);
		String query = searchSourceBuilder.toString();
		System.out.println(query);

		// aggs:聚合:相当于统计,这里我们不用,用java代码去做
		// TermsBuilder groupby_attr = AggregationBuilders.terms("groupby_attr").field("skuAttrValueList.valueId");
		// searchSourceBuilder.aggregation(groupby_attr);

		//通过jest的API操作ES查询信息
		List<PmsSearchSkuInfo> pmsSearchSkuInfos = new ArrayList<>();

		Search search = new Search.Builder(query).addIndex("ppmall").addType("PmsSkuInfo").build();
		SearchResult result = null;
		try {
			result = jestClient.execute(search);
		} catch (IOException e) {
			e.printStackTrace();
		}
		List<SearchResult.Hit<PmsSearchSkuInfo, Void>> hits = result.getHits(PmsSearchSkuInfo.class);
		for (SearchResult.Hit<PmsSearchSkuInfo, Void> hit : hits) {
			PmsSearchSkuInfo pmsSearchSkuInfo = hit.source;

			//获取highlight的第一个字符串
			Map<String, List<String>> highlight = hit.highlight;
			if (highlight != null) {
				String skuName = highlight.get("skuName").get(0);
				//把skuDesc中的SkuName的替换为高亮的字符串
				pmsSearchSkuInfo.setSkuName(skuName);
			}

			//将每一个查询的sku加入到list中
			pmsSearchSkuInfos.add(pmsSearchSkuInfo);
			System.out.println(pmsSearchSkuInfo);
		}
		return pmsSearchSkuInfos;
	}
}
