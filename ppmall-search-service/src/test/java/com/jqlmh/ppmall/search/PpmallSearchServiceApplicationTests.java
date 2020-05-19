package com.jqlmh.ppmall.search;

import com.alibaba.dubbo.config.annotation.Reference;
import com.jqlmh.ppmall.bean.PmsSearchSkuInfo;
import com.jqlmh.ppmall.bean.PmsSkuInfo;
import com.jqlmh.ppmall.service.SkuService;
import io.searchbox.client.JestClient;
import io.searchbox.core.Index;
import io.searchbox.core.Search;
import io.searchbox.core.SearchResult;
import org.apache.commons.beanutils.BeanUtils;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.MatchQueryBuilder;
import org.elasticsearch.index.query.TermQueryBuilder;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class PpmallSearchServiceApplicationTests {


	@Reference
	private SkuService skuService;

	@Autowired
	private JestClient jestClient;

	/**
	 * 将数据导入es
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 * @throws IOException
	 */
	@Test
	public void putToES() throws InvocationTargetException, IllegalAccessException, IOException {

		//查询mysql数据
		List<PmsSkuInfo> pmsSkuInfoList = skuService.getPmsSkuInfos();

		//转换为es数据结构
		List<PmsSearchSkuInfo> pmsSearchSkuInfos = new ArrayList<>();

		for (PmsSkuInfo pmsSkuInfo : pmsSkuInfoList) {
			PmsSearchSkuInfo pmsSearchSkuInfo = new PmsSearchSkuInfo();
			BeanUtils.copyProperties(pmsSearchSkuInfo,pmsSkuInfo);
			//id类型转换
			pmsSearchSkuInfo.setId(Long.parseLong(pmsSkuInfo.getId()));
			pmsSearchSkuInfos.add(pmsSearchSkuInfo);
		}

		//导入es
		for (PmsSearchSkuInfo pmsSearchSkuInfo : pmsSearchSkuInfos) {
			Index index = new Index.Builder(pmsSearchSkuInfo).index("ppmall").type("PmsSkuInfo").id(pmsSearchSkuInfo.getId()+"").build();
			jestClient.execute(index);
		}
	}

	/**
	 * 使用字符串查询
	 * @throws IOException
	 */
	@Test
	public void searchFromES() throws IOException {
		//用api执行复杂查询
		String query="{\"query\":{\"bool\":{\"filter\":[{\"term\":{\"skuAttrValueList.valueId\":42}}," +
				"{\"term\":{\"skuAttrValueList.valueId\":45}}],\"must\":[{\"match\":{\"skuName\":\"A2223\"}}]}}}";

		Search search = new Search.Builder(query).addIndex("ppmall").addType("PmsSkuInfo").build();
		SearchResult result = jestClient.execute(search);
		List<SearchResult.Hit<PmsSearchSkuInfo, Void>> hits = result.getHits(PmsSearchSkuInfo.class);
		for (SearchResult.Hit<PmsSearchSkuInfo, Void> hit : hits) {
			PmsSearchSkuInfo pmsSearchSkuInfo = hit.source;
			System.out.println(pmsSearchSkuInfo);
		}
	}


	/**
	 * jest的dsl工具,不用写查询dsl语句,全部封装在工具类中:SearchSourceBuilder
	 */
	@Test
	public void searchWithUtil() throws IOException {

		//jest的dsl工具
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();  //封装了query的字符串

		//bool
		BoolQueryBuilder boolQueryBuilder = new BoolQueryBuilder();
			//filter
			//多个term
			boolQueryBuilder.filter(new TermQueryBuilder("skuAttrValueList.valueId","42"));
			boolQueryBuilder.filter(new TermQueryBuilder("skuAttrValueList.valueId","45"));

			//在一个过滤条件中加入并集
			//boolQueryBuilder.filter(new TermsQueryBuilder("skuAttrValueList.valueId","42","45","39"));
			//must
			boolQueryBuilder.must(new MatchQueryBuilder("skuName","A2223"));

		//query
		searchSourceBuilder.query(boolQueryBuilder);

		//分页显示:from和size
		searchSourceBuilder.from(0);
		searchSourceBuilder.size(20);

		//高亮显示
		searchSourceBuilder.highlight(null);

		String query = searchSourceBuilder.toString();
		System.out.println(query);


		Search search = new Search.Builder(query).addIndex("ppmall").addType("PmsSkuInfo").build();
		SearchResult result = jestClient.execute(search);
		List<SearchResult.Hit<PmsSearchSkuInfo, Void>> hits = result.getHits(PmsSearchSkuInfo.class);
		for (SearchResult.Hit<PmsSearchSkuInfo, Void> hit : hits) {
			PmsSearchSkuInfo pmsSearchSkuInfo = hit.source;
			System.out.println(pmsSearchSkuInfo);
		}

	}

}
