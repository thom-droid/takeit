package com.summer.cabbage.vo;

import java.sql.Timestamp;

public class Category {
	private int no, priorNo;
	private String name;
	private Timestamp regdate;
	private String engName;
	
	public Category() {
		// TODO Auto-generated constructor stub
	}
	
	public String getEngName() {
		return engName;
	}

	public void setEngName(String engName) {
		this.engName = engName;
	}


	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getPriorNo() {
		return priorNo;
	}

	public void setPriorNo(int priorNo) {
		this.priorNo = priorNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Timestamp getRegdate() {
		return regdate;
	}

	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	
	
}
