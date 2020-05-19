package com.jqlmh.ppmall.ware.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * @param
 * @return
 */
@Setter
@Getter
@ToString
@Accessors(chain = true)
public class WareOrderTaskDetail implements Serializable {

	@Column
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;

	@Column
	private String skuId;

	@Column
	private String skuName;

	@Column
	private Integer skuNum;

	@Column
	private String taskId;


}
