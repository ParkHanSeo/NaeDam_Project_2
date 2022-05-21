package com.naedam.admin.order.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class OrderWithNames extends Order {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String productName;
	private String phone;
	private String payMethod;
	private Date paidAt;
	private String piStatus;
	private String status;
	private String lastName;
	private String firstName;
	private int amount;
	private String statusName;
	private long trackingNo;
	private int deliComNo;
	
	public OrderWithNames(long orderNo, int memberNo, int productNo, int orderStatusNo, Date orderDate,
			String productName, String phone, String payMethod, Date paidAt, String piStatus, String status,
			String lastName, String firstName, int amount, String statusName, long trackingNo, int deliComNo) {
		super(orderNo, memberNo, productNo, orderStatusNo, orderDate);
		this.productName = productName;
		this.phone = phone;
		this.payMethod = payMethod;
		this.paidAt = paidAt;
		this.piStatus = piStatus;
		this.status = status;
		this.lastName = lastName;
		this.firstName = firstName;
		this.amount = amount;
		this.statusName = statusName;
		this.trackingNo = trackingNo;
		this.deliComNo = deliComNo;
	}

	
	

	


	
	
	
	

}
