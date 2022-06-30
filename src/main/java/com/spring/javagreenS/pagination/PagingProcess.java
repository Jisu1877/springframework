package com.spring.javagreenS.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS.dao.BoardDAO;
import com.spring.javagreenS.dao.GuestDAO;
import com.spring.javagreenS.dao.MemberDAO;
import com.spring.javagreenS.dao.PdsDAO;

@Service
public class PagingProcess {
	@Autowired
	GuestDAO guestDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	PdsDAO pdsDAO;
	
	public PageVO pageProcess(String flag, int pag) {
		PageVO pageVO = new PageVO();
		//페이징처리를 위한 준비...
		int totRecCnt = 0;
		if(flag.equals("member")) {
			totRecCnt = memberDAO.totRecCnt();
			pageVO.setTotRecCnt(totRecCnt);
		}
		else if(flag.equals("guest")) {
			totRecCnt = guestDAO.totRecCnt();
			pageVO.setTotRecCnt(totRecCnt);
		}
		
		pageVO.setPageSize(5);
		pageVO.setTotPage((totRecCnt % pageVO.getPageSize()) == 0 ? totRecCnt / pageVO.getPageSize() : (totRecCnt / pageVO.getPageSize()) + 1);
		int startIndexNo = (pag - 1) * pageVO.getPageSize();
		int curScrStartNo = pageVO.getTotRecCnt() - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (pageVO.getTotPage() % blockSize) == 0 ? (pageVO.getTotPage() / blockSize) - 1 : (pageVO.getTotPage() / blockSize);
		
		pageVO.setPag(pag);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		return pageVO;
	}
	
	
	//선생님 방법
	// 인자 : 1.pag 번호 2. page크기 3.소속(예:게시판-board) 4.분류 5.검색어
	public PageVO pageProcess2(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		int blockSize = 3;
		//section에 따른 레코드 갯수를 구해오기
		if(section.equals("member")) {
			totRecCnt = memberDAO.totRecCnt();
		}
		else if(section.equals("guest")) {
			totRecCnt = guestDAO.totRecCnt();
		}
		else if(section.equals("board")) {
			if(searchString.equals("")) {
				totRecCnt = boardDAO.totRecCnt();
			}else {
				String search = part;
				totRecCnt = boardDAO.totSearchRecCnt(search, searchString);
			}
		}
		else if(section.equals("pds")) {
			totRecCnt = pdsDAO.totRecCnt(part);
		}
		
		pageVO.setTotPage((totRecCnt % pageSize) == 0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1);
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (pageVO.getTotPage() % blockSize) == 0 ? (pageVO.getTotPage() / blockSize) - 1 : (pageVO.getTotPage() / blockSize);
		
		
		pageVO.setPageSize(pageSize);
		pageVO.setPag(pag);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setPart(part);
		
		return pageVO;
	}
}
