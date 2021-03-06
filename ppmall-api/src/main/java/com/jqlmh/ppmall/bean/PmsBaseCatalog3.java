package com.jqlmh.ppmall.bean;


import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * 三级分类实体类
 *
 * @author LMH
 * @date 2020/5/26
 */
public class PmsBaseCatalog3 implements Serializable {
	@Id
	@Column
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;

	@Column
	private String name;

	@Column
	private String catalog2Id;

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

	public String getCatalog2Id() {
		return catalog2Id;
	}

	public void setCatalog2Id(String catalog2Id) {
		this.catalog2Id = catalog2Id;
	}

	@Override
	public String toString() {
		return "PmsBaseCatalog3{" +
				"id=" + id +
				", name='" + name + '\'' +
				", catalog2Id=" + catalog2Id +
				'}';
	}
}

