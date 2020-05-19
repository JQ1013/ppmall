package com.jqlmh.ppmall.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * @author LMH
 * @create 2020-04-07 21:35
 */

@Accessors(chain = true)
@Setter
@Getter
@ToString
@Table(name = "ums_member")
public class UmsMember implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;
	private Integer memberLevelId;
	private String username;
	private String password;
	private String nickname; //昵称
	private String phone;
	private Integer status;
	private Date createTime;
	private String icon;
	private String gender;
	private Date birthday;
	private String city;
	private String job;
	private String personalizedSignature;
	private Integer sourceType;  //社交登录的来源网站
	private String sourceUid;  //社交登录的Uid
	private String accessCode;  //社交登录的授权码
	private String accessToken; //社交登录令牌
	private Integer integration;
	private Integer growth;
	private Integer luckyCount;
	private Integer historyIntegration;
}
