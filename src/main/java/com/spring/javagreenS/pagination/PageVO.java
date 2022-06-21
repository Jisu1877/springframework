package com.spring.javagreenS.pagination;

import lombok.Data;

public @Data class PageVO {
	int pageSize;
	int totRecCnt;
	int totPage;
	int startIndexNo;
	int curScrStartNo;
	int blockSize;
	int curBlock;
	int lastBlock;
	int pag;
}
