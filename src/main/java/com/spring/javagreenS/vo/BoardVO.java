package com.spring.javagreenS.vo;

import lombok.Data;

public @Data class BoardVO {
	private int idx;
	private String nickName;
	private String title;
	private String email;
	private String homePage;
	private String content;
	private String wDate;
	private int readNum;
	private String hostIp;
	private int good;
	private String mid;
	
	//날짜 차이를 저장해주는 변수
	private int diffTime;
	
	//기존 contentd의 내용을 담기 위한 변수
	private String oriContent;
	
	//댓글의 개수를 저장하기 위한 변수
	private int replyCount;
	
}
