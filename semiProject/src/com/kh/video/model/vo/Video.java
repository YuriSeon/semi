package com.kh.video.model.vo;

public class Video {

//  VIDEO_NO NUMBER PRIMARY KEY,
//  BOARD_NO NUMBER,
//  VIDEO_VIEW_COUNT NUMBER DEFAULT 0,
//  THUMBNAIL VARCHAR2(1000) NOT NULL,
//  VIDEO_PATH VARCHAR2(1000) NOT NULL,
//  VIDEO_ORIGNIN_NAME VARCHAR2(1000) NOT NULL,
//  VIDEO_CHANGE_NAME VARCHAR2(1000) NOT NULL,
//  FOREIGN KEY(BOARD_NO) REFERENCES BOARD(BOARD_NO)
	private int videoNo;
	private int boardNo;
	private int videoViewCount;
	private String thumbnail;
	private String videoPath;
	private String videoOrigninName;
	private String videoChangeName;
	public Video() {
		super();
	}
	public Video(int videoNo, int boardNo, int videoViewCount, String thumbnail, String videoPath,
			String videoOrigninName, String videoChangeName) {
		super();
		this.videoNo = videoNo;
		this.boardNo = boardNo;
		this.videoViewCount = videoViewCount;
		this.thumbnail = thumbnail;
		this.videoPath = videoPath;
		this.videoOrigninName = videoOrigninName;
		this.videoChangeName = videoChangeName;
	}
	public int getVideoNo() {
		return videoNo;
	}
	public void setVideoNo(int videoNo) {
		this.videoNo = videoNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getVideoViewCount() {
		return videoViewCount;
	}
	public void setVideoViewCount(int videoViewCount) {
		this.videoViewCount = videoViewCount;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getVideoPath() {
		return videoPath;
	}
	public void setVideoPath(String videoPath) {
		this.videoPath = videoPath;
	}
	public String getVideoOrigninName() {
		return videoOrigninName;
	}
	public void setVideoOrigninName(String videoOrigninName) {
		this.videoOrigninName = videoOrigninName;
	}
	public String getVideoChangeName() {
		return videoChangeName;
	}
	public void setVideoChangeName(String videoChangeName) {
		this.videoChangeName = videoChangeName;
	}
	@Override
	public String toString() {
		return "Video [videoNo=" + videoNo + ", boardNo=" + boardNo + ", videoViewCount=" + videoViewCount
				+ ", thumbnail=" + thumbnail + ", videoPath=" + videoPath + ", videoOrigninName=" + videoOrigninName
				+ ", videoChangeName=" + videoChangeName + "]";
	}
	
}