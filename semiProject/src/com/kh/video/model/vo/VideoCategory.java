package com.kh.video.model.vo;

public class VideoCategory {

//    VIDEO_CATEGORY_NO NUMBER PRIMARY KEY ,
//    CATEGORY_NO NUMBER,
//    VIDEO_CATEGORY_NAME NUMBER NOT NULL, 
//   FOREIGN KEY(CATEGORY_NO)REFERENCES CATEGORY(CATEGORY_NO)
	
	private int videoCategoryNo;
	private int categoryNo;
	private String videoCategoryName;
	public VideoCategory() {
		super();
	}
	public VideoCategory(int videoCategoryNo, int categoryNo, String videoCategoryName) {
		super();
		this.videoCategoryNo = videoCategoryNo;
		this.categoryNo = categoryNo;
		this.videoCategoryName = videoCategoryName;
	}
	public int getVideoCategoryNo() {
		return videoCategoryNo;
	}
	public void setVideoCategoryNo(int videoCategoryNo) {
		this.videoCategoryNo = videoCategoryNo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getVideoCategoryName() {
		return videoCategoryName;
	}
	public void setVideoCategoryName(String videoCategoryName) {
		this.videoCategoryName = videoCategoryName;
	}
	@Override
	public String toString() {
		return "VideoCategory [videoCategoryNo=" + videoCategoryNo + ", categoryNo=" + categoryNo
				+ ", videoCategoryName=" + videoCategoryName + "]";
	}
	
	
	
}