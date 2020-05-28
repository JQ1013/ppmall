package com.jqlmh.ppmall.bean;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * 销售基本属性实体类
 *
 * @author LMH
 * @date 2020/5/26
 */
public class PmsBaseSaleAttr implements Serializable {

	@Id
	@Column
	private String id;

	@Column
	private String name;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "PmsBaseSaleAttr{" +
				"id='" + id + '\'' +
				", name='" + name + '\'' +
				'}';
	}
}