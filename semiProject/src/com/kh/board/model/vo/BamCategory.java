package com.kh.board.model.vo;

public class BamCategory {
//	  BAM_CATEGORY_NO NUMBER PRIMARY KEY
//	  CATEGORY_NO NUMBER FOREIGN KEY CATEGORY(CATEGORY_NO)
//	  BAM_CATEGORY_NAME VARCHAR2(30) NOT NULL
	private int bamCategoryNo;
	private int categoryNo;
	private String bamCategoryName;
	public BamCategory() {
		super();
	}
	public BamCategory(int bamCategoryNo, int categoryNo, String bamCategoryName) {
		super();
		this.bamCategoryNo = bamCategoryNo;
		this.categoryNo = categoryNo;
		this.bamCategoryName = bamCategoryName;
	}
	public int getBamCategoryNo() {
		return bamCategoryNo;
	}
	public void setBamCategoryNo(int bamCategoryNo) {
		this.bamCategoryNo = bamCategoryNo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getBamCategoryName() {
		return bamCategoryName;
	}
	public void setBamCategoryName(String bamCategoryName) {
		this.bamCategoryName = bamCategoryName;
	}
	@Override
	public String toString() {
		return "BamCategory [bamCategoryNo=" + bamCategoryNo + ", categoryNo=" + categoryNo + ", bamCategoryName="
				+ bamCategoryName + "]";
	}
	
}
