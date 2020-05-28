package com.jqlmh.ppmall.member.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.alibaba.fastjson.JSON;
import com.jqlmh.ppmall.bean.UmsMember;
import com.jqlmh.ppmall.bean.UmsMemberReceiveAddress;
import com.jqlmh.ppmall.member.mapper.MemberMapper;
import com.jqlmh.ppmall.member.mapper.MemberReceiveAddressMapper;
import com.jqlmh.ppmall.service.MemberService;
import com.jqlmh.ppmall.util.RedisConst;
import com.jqlmh.ppmall.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import redis.clients.jedis.Jedis;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-07 20:42
 */
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private MemberReceiveAddressMapper memberReceiveAddressMapper;

	@Autowired
	private RedisUtil redisUtil;


	/**
	 * 获得所有的会员列表
	 *
	 * @return 所有会员
	 */
	@Override
	public List<UmsMember> listMember() {
		return memberMapper.selectAll();
	}

	/**
	 * 获取所有会员的收货地址
	 *
	 * @param memberId
	 * @return 会员收货地址
	 */
	@Override
	public List<UmsMemberReceiveAddress> listMemberReceiveAddress(String memberId) {
		Example example = new Example(UmsMemberReceiveAddress.class);
		example.createCriteria().andEqualTo("memberId", memberId);
		return memberReceiveAddressMapper.selectByExample(example);
	}


	/**
	 * 根据传来的会员信息,查询出数据库中是否有该会员,验证用户名密码
	 *
	 * @param umsMember
	 * @return
	 */
	@Override
	public UmsMember checkLoginInfo(UmsMember umsMember) {

		try (Jedis jedis = redisUtil.getJedis()) {
			//能连接redis
			String memberKey = RedisConst.OMS_CART_ITEM_PREFIX + umsMember.getUsername()+umsMember.getPassword() + RedisConst.UMS_MEMBER_INFO_SUFFIX; //member:密码:info

			if (jedis != null) {

				String memberJson = jedis.get(memberKey);
				//缓存中有数据,密码正确
				if (StringUtils.isNotBlank(memberJson)) {
					return JSON.parseObject(memberJson, UmsMember.class);
				} else {
					//密码不正确
					//缓存中没有
					//开启db查询
					UmsMember umsMemberFromDB = checkLoginInfoFromDB(umsMember);
					if (umsMemberFromDB != null) {
						//有该用户,存入缓存
						jedis.setex(memberKey, 60 * 60 * 24, JSON.toJSONString(umsMemberFromDB));
					}
					return umsMemberFromDB;
				}
			} else {
				//无法连接redis,开启db查询
				UmsMember umsMemberFromDB = checkLoginInfoFromDB(umsMember);
				if (umsMemberFromDB != null) {
					//有该用户,直接返回,redis已经挂了无法存入缓存
					return umsMemberFromDB;
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}


	/**
	 * 将jwt生成的用户token信息存入redis
	 *
	 * @param token
	 * @param memberId
	 */
	@Override
	public void saveMemberTokenInCache(String token, String memberId) {

		try (Jedis jedis = redisUtil.getJedis()) {
			if (jedis != null) {
				String memberTokenKey = RedisConst.OMS_CART_ITEM_PREFIX + memberId + RedisConst.UMS_MEMBER_TOKEN_SUFFIX; //member:用户id:token
				jedis.setex(memberTokenKey, 60 * 60 * 2, token);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}


	/**
	 * 将社交登录的用户信息保存到数据库
	 *
	 * @param umsMember
	 */
	@Override
	public String saveSocialLoginMember(UmsMember umsMember) {
		memberMapper.insertSelective(umsMember);
		return umsMember.getId();
	}


	/**
	 * 检查是否数据库已经有该条记录
	 * @param sourceUid
	 * @return
	 */
	@Override
	public UmsMember checkSocialLoginMember(String sourceUid) {
		Example example = new Example(UmsMember.class);
		example.createCriteria().andEqualTo("sourceUid", sourceUid);
		return memberMapper.selectOneByExample(example);
	}

	/**
	 * 通过收货人信息主键获取收货人信息
	 * @param memberReceiveAddressId
	 * @return
	 */
	@Override
	public UmsMemberReceiveAddress getReceiveAddressById(String memberReceiveAddressId) {
		return memberReceiveAddressMapper.selectByPrimaryKey(memberReceiveAddressId);
	}


	/**
	 * 从数据库查询用户信息
	 *
	 * @param umsMember
	 * @return
	 */
	private UmsMember checkLoginInfoFromDB(UmsMember umsMember) {
		List<UmsMember> umsMemberList = memberMapper.select(umsMember);

		if (umsMemberList != null && umsMemberList.size() > 0) {
			return umsMemberList.get(0);
		}
		return null;
	}
}
