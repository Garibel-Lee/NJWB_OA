package com.lcqjoyce.entity;

import java.util.Date;

public class Payment {
	private Integer id;
	private String paymentNo;
	private String paymentName;
	private String paymentType;
	private String paymentIntro;
	private Double money;
	private Date applyTime;
	private String applyStatus;
	
	
	public Payment() {
	}
	public Payment(Integer id, String paymentNo, String paymentName, String paymentType, String paymentIntro, Double money, Date applyTime, String applyStatus) {
		this.id = id;
		this.paymentNo = paymentNo;
		this.paymentName = paymentName;
		this.paymentType = paymentType;
		this.paymentIntro = paymentIntro;
		this.money = money;
		this.applyTime = applyTime;
		this.applyStatus = applyStatus;
	}
	public String getPaymentNo() {
		return paymentNo;
	}
	public void setPaymentNo(String paymentNo) {
		this.paymentNo = paymentNo;
	}
	public String getPaymentName() {
		return paymentName;
	}
	public void setPaymentName(String paymentName) {
		this.paymentName = paymentName;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public String getPaymentIntro() {
		return paymentIntro;
	}
	public void setPaymentIntro(String paymentIntro) {
		this.paymentIntro = paymentIntro;
	}
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public Date getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}
	public String getApplyStatus() {
		return applyStatus;
	}
	public void setApplyStatus(String applyStatus) {
		this.applyStatus = applyStatus;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getId() {
		return id;
	}
	

}
