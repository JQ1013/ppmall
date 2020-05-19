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

@Setter
@Getter
@ToString
@Accessors(chain = true)
@Table(name = "ums_member_receive_address")
public class UmsMemberReceiveAddress implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;
	private String memberId;
	private String name;
	private String phoneNumber;
	private Integer defaultStatus;
	private String postCode;
	private String province;
	private String city;
	private String region;
	private String detailAddress;

}
