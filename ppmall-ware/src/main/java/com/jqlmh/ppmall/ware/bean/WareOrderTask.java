package com.jqlmh.ppmall.ware.bean;


import com.jqlmh.ppmall.ware.enums.TaskStatus;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;
import org.apache.ibatis.type.JdbcType;
import tk.mybatis.mapper.annotation.ColumnType;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @param
 * @return
 */
@Setter
@Getter
@ToString
@Accessors(chain = true)
public class WareOrderTask implements Serializable {

	@Id
	@Column
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;

	@Column
	private String orderId;

	@Column
	private String consignee;

	@Column
	private String consigneeTel;

	@Column
	private String deliveryAddress;

	@Column
	private String orderComment;

	@Column
	private String paymentWay;

	@Column
	@ColumnType(jdbcType = JdbcType.VARCHAR)
	private TaskStatus taskStatus;

	@Column
	private String orderBody;

	@Column
	private String trackingNo;

	@Column
	private Date createTime;

	@Column
	private String wareId;

	@Column
	private String taskComment;

	@Transient
	private List<WareOrderTaskDetail> details;


}
