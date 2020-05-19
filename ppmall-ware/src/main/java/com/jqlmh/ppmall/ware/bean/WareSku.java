package com.jqlmh.ppmall.ware.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @param
 * @return
 */
@Setter
@Getter
@ToString
@Accessors(chain = true)
public class WareSku implements Serializable {

	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	@Id
	private String id;

	@Column
	private String skuId;

	@Column
	private String warehouseId;

	@Column
	private Integer stock = 0;

	@Column
	private String stockName;

	@Column
	private Integer stockLocked;

	@Transient
	private String warehouseName;


}
