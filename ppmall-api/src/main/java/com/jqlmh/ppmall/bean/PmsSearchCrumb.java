package com.jqlmh.ppmall.bean;

import java.io.Serializable;

/**
 * @author LMH
 * @create 2020-04-22 15:34
 */
public class PmsSearchCrumb implements Serializable {

	private String attrName;
	private String valueId;
	private String valueName;
	private String urlParam;

	public String getAttrName() {
		return attrName;
	}

	public void setAttrName(String attrName) {
		this.attrName = attrName;
	}

	public String getValueId() {
		return valueId;
	}

	public void setValueId(String valueId) {
		this.valueId = valueId;
	}

	public String getValueName() {
		return valueName;
	}

	public void setValueName(String valueName) {
		this.valueName = valueName;
	}

	public String getUrlParam() {
		return urlParam;
	}

	public void setUrlParam(String urlParam) {
		this.urlParam = urlParam;
	}

	@Override
	public String toString() {
		return "PmsSearchCrumb{" +
				"attrName='" + attrName + '\'' +
				", valueId='" + valueId + '\'' +
				", valueName='" + valueName + '\'' +
				", urlParam='" + urlParam + '\'' +
				'}';
	}
}
