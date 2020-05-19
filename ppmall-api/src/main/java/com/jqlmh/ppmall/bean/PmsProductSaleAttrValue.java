package com.jqlmh.ppmall.bean;

import javax.persistence.*;
import java.io.Serializable;

public class PmsProductSaleAttrValue implements Serializable {
    @Id
    @Column
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id ;

    @Column
    private String productId;

    @Column
    private String saleAttrId;

    @Column
    private String saleAttrValueName;

    @Transient
    private String isChecked;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getSaleAttrId() {
        return saleAttrId;
    }

    public void setSaleAttrId(String saleAttrId) {
        this.saleAttrId = saleAttrId;
    }

    public String getSaleAttrValueName() {
        return saleAttrValueName;
    }

    public void setSaleAttrValueName(String saleAttrValueName) {
        this.saleAttrValueName = saleAttrValueName;
    }

    public String getIsChecked() {
        return isChecked;
    }

    public void setIsChecked(String isChecked) {
        this.isChecked = isChecked;
    }

    @Override
    public String toString() {
        return "PmsProductSaleAttrValue{" +
                "id=" + id +
                ", productId=" + productId +
                ", saleAttrId=" + saleAttrId +
                ", saleAttrValueName='" + saleAttrValueName + '\'' +
                ", isChecked='" + isChecked + '\'' +
                '}';
    }
}
