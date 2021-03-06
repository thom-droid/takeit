package com.summer.cabbage.vo;

public class PageVO {

	private int start,end;
	
	// 필드 추가 ///////////////////////////
	private int giverNo, tempNo, memberNo, priorNo, categoryNo;
	private String sort, location;
	
	private String searchType;
	
	private String searchValue;
	

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public int getTempNo() {
		return tempNo;
	}

	public void setTempNo(int tempNo) {
		this.tempNo = tempNo;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getPriorNo() {
		return priorNo;
	}

	public void setPriorNo(int priorNo) {
		this.priorNo = priorNo;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	// 필드 메서드 추가 ///////////////////
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public int getGiverNo() {
		return giverNo;
	}

	public void setGiverNo(int giverNo) {
		this.giverNo = giverNo;
	}
	

	///////////////////////////////////////
	
	
	

	public PageVO() {
	}
	
	public PageVO(int page,int numPage) {
		this.end=page*numPage;
		this.start=end-numPage+1;
	}

	
	// 생성자 추가 ////////////////////////////////////////////
	public PageVO(int page,int numPage,int giverNo) {
		this.end=page*numPage;
		this.start=end-numPage+1;
		this.giverNo=giverNo;
	}
	
	public PageVO(int page,int numPage,int giverNo,String sort) {
		this.end=page*numPage;
		this.start=end-numPage+1;
		this.giverNo=giverNo;
		this.sort=sort;
	}
	/////////////////////////////////////////////////////////////
	

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}
	
}
