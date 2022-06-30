package com.spring.javagreenS.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javagreenS.dao.BoardDAO;
import com.spring.javagreenS.vo.BoardReplyVO;
import com.spring.javagreenS.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		return boardDAO.getBoardList(startIndexNo, pageSize);
	}
	
	// 게시판의 글을 등록 / 수정 할때 사용하는 메소드.
	@Override
	public void imgCheck(String content) {
		//                1         2         3         4         5             
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		// <img src="/javagreenS/data/ckeditor/220622152317_na3.png" style="height:1217px; width:972px" />
		
		//이 작업은 content안에 그림파일(img src="/)가 있을때만 수행한다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		int position = 31;  //src="/javagreenS/data/ckeditor/ 이 해당 경로가 어떻게 될지 모르기에 실제 파일명이 시작되는 index번호를 세서 작성한다.
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		
		boolean sw = true;
		while(sw) {
			String imgFileName = nextImg.substring(0,nextImg.indexOf("\""));
			
			//원본 사진 경로
			String oFilePath = uploadPath + imgFileName;
			//복사한 사진 저장할 경로
			String copyFilePath = uploadPath + "board/" + imgFileName;
			
			fileCopy(oFilePath,copyFilePath); //board폴더에 파일을 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	//실제 서버에(ckeditor) 저장되어 있는 파일을 board폴더로 복사처리한다.
	public void fileCopy(String oFilePath, String copyFilePath) {
		File oFile = new File(oFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oFile); //꺼내기
			FileOutputStream fos = new FileOutputStream(copyFile); //저장할 껍데기 만들기
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count); 
			}
			
			fos.flush();
			fos.close();
			fis.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void setBoardInput(BoardVO vo) {
		boardDAO.setBoardInput(vo);
	}

	@Override
	public void setReadNum(int idx) {
		boardDAO.setReadNum(idx);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public List<BoardVO> getBoardSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return boardDAO.getBoardSearch(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public ArrayList<BoardVO> getPreNext(int idx) {
		return boardDAO.getPreNext(idx);
	}

	@Override
	public int getMinIdx() {
		return boardDAO.getMinIdx();
	}
	
	// 게시판의 ckeditor에서 올린 이미지 파일을 삭제처리한다.
	@Override
	public void imgDelete(String content) {
		//      		  1         2         3         4         5             
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		// <img src="/javagreenS/data/ckeditor/board/220622152317_na3.png" style="height:1217px; width:972px" />
	
		//이 작업은 content안에 그림파일(img src="/)가 있을때만 수행한다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/board/");
		
		int position = 37; 
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		
		boolean sw = true;
		while(sw) {
			String imgFileName = nextImg.substring(0,nextImg.indexOf("\""));
			
			//원본 사진 경로
			String oFilePath = uploadPath + imgFileName;
			fileDelete(oFilePath); //board폴더에 존재하는 파일을 삭제처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	//원본 이미지를 삭제처리한다.(board폴더에서 삭제처리)
	private void fileDelete(String oFilePath) {
		File delFile = new File(oFilePath);
		if(delFile.exists() && delFile != null) { //이 객체가 정말 존재한다면
			delFile.delete(); //삭제해라.
		}
	}

	@Override
	public void setBoardDelete(int idx) {
		boardDAO.setBoardDelete(idx);
	}

	//수정창들어올 때 이미지 복사처리
	@Override
	public void imgCheckUpdate(String content) {
		//                1         2         3         4         5             
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		// <img src="/javagreenS/data/ckeditor/220622152317_na3.png" style="height:1217px; width:972px" />
		// <img src="/javagreenS/data/ckeditor/board/220622152317_na3.png" style="height:1217px; width:972px" />
		
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/board/");
		
		int position = 37;  
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		
		boolean sw = true;
		while(sw) {
			String imgFileName = nextImg.substring(0,nextImg.indexOf("\""));
			
			//원본 사진 경로
			String oFilePath = uploadPath + imgFileName;
			//복사한 사진 저장할 경로
			String copyFilePath = request.getRealPath("/resources/data/ckeditor/" + imgFileName);
			
			fileCopy(oFilePath,copyFilePath); //board폴더에 파일을 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		
	}

	@Override
	public void setBoardUpdate(BoardVO vo) {
		boardDAO.setBoardUpdate(vo);
	}

	@Override
	public String maxLevelOrder(int boardIdx) {
		return boardDAO.maxLevelOrder(boardIdx);
	}

	@Override
	public void setboardReplyInput(BoardReplyVO replyVo) {
		boardDAO.setboardReplyInput(replyVo);
	}

	@Override
	public ArrayList<BoardReplyVO> getBoardReply(int idx) {
		return boardDAO.getBoardReply(idx);
	}

	@Override
	public void levelOrderPlusUpdate(BoardReplyVO replyVo) {
		boardDAO.levelOrderPlusUpdate(replyVo);
	}

	@Override
	public void setBoardReplyInput2(BoardReplyVO replyVo) {
		boardDAO.setBoardReplyInput2(replyVo);
	}

	@Override
	public void setBoardReplyDeleteOk(int idx) {
		boardDAO.setBoardReplyDeleteOk(idx);
	}
}
