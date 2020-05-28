package com.jqlmh.ppmall.bean;


import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * 一级分类实体类
 *
 * @author LMH
 * @date 2020/5/26
 */
public class PmsBaseCatalog1 implements Serializable {
	@Id
	@Column
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;

	@Column
	private String name;

	@Transient
	private List<PmsBaseCatalog2> catalog2List;

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

	public List<PmsBaseCatalog2> getCatalog2List() {
		return catalog2List;
	}

	public void setCatalog2List(List<PmsBaseCatalog2> catalog2List) {
		this.catalog2List = catalog2List;
	}

	@Override
	public String toString() {
		return "PmsBaseCatalog1{" +
				"id=" + id +
				", name='" + name + '\'' +
				", catalog2List=" + catalog2List +
				'}';
	}
}

