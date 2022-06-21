package com.spring.javagreenS.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS.dao.GuestDAO;
import com.spring.javagreenS.dao.MemberDAO;

@Service
public class PagingProcess {
	@Autowired
	GuestDAO guestDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
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
}
