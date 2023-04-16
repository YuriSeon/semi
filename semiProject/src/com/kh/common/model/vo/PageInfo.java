package com.kh.common.model.vo;

public class PageInfo {
	
	private int listCount;
	private int currentPage;
	private int startPage;
	private int endPage;
	private int boardLimit;
	private int pageLimit;
	private int maxPage;
	
	
	public PageInfo() {
		super();
	}
	
	public PageInfo(int listCount, int currentPage, int startPage, int endPage, int boardLimit, int pageLimit,
			int maxPage) {
		super();
		this.listCount = listCount;
		this.currentPage = currentPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.boardLimit = boardLimit;
		this.pageLimit = pageLimit;
		this.maxPage = maxPage;
	}
	
	
	public int getListCount() {
		return listCount;
	}
	
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	public int getBoardLimit() {
		return boardLimit;
	}
	
	public void setBoardLimit(int boardLimit) {
		this.boardLimit = boardLimit;
	}
	
	public int getPageLimit() {
		return pageLimit;
	}
	
	public void setPageLimit(int pageLimit) {
		this.pageLimit = pageLimit;
	}
	
	public int getMaxPage() {
		return maxPage;
	}
	
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	
	
	@Override
	public String toString() {
		return "PageInfo [listCount=" + listCount + ", currentPage=" + currentPage + ", startPage=" + startPage
				+ ", endPage=" + endPage + ", boardLimit=" + boardLimit + ", pageLimit=" + pageLimit + ", maxPage="
				+ maxPage + "]";
	}
	
	
	
	

}
