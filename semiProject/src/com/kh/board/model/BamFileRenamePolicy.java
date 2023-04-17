package com.kh.board.model;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class BamFileRenamePolicy implements FileRenamePolicy {
	
	public File rename (File originFile) {
		
		//원본 파일명 
		String originName = originFile.getName();
		
		//수정파일명 : 파일업로드된 시간(년월일시분초)+5자리 랜덤값
		
		//파일 업로드 시간 
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		//랜덤 숫자 5자리
		int ranNum =(int)(Math.random()*90000)+10000;
		
		//원본파일 확장자 변수
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime+ranNum+ext;
		
		return new File(originFile.getParent(),changeName);
	}
}
