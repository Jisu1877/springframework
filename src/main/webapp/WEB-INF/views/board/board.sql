show tables;

create table board2 (
	idx 		int not null auto_increment, /* 게시글의 고유번호 */
	nickName 	varchar(20) not null,   	 /* 게시글을 올린사람의 닉네임 */
	title 		varchar(100) not null,		 /* 게시글의 글 제목 */
	email		varchar(100),				 /* 글쓴이의 메일주소 */
	homePage	varchar(100),				 /* 글쓴이의 홈페이지(블로그) 주소 */
	content		text not null,				 /* 글 내용 */
	wDate		datetime default now(),		 /* 글 올린 날짜 */
	readNum		int default 0,				 /* 글 조회수 */
	hostIp		varchar(50) not null,		 /* 접속 IP 주소 */
	good		int default 0,				 /* '좋아요' 횟수 누적처리 */
	mid 		varchar(20) not null,		 /* 회원 아이디(게시글 조회시 사용) */
	primary key(idx)				/* 게시판의 기본키 : 고유번호(idx)*/
);

desc board2;

insert into board2 values (default, '관리투', '게시판 서비스를 시작합니다.', 'ljs1877@gmail.com', 'http://blog.daum.net/cjsk1126', '이곳은 게시판입니다.', default, default, '192.168.50.103', default, 'admin');

select * from board2;

select * from board2 where idx = 5 - 1; /*현재글이 5번글일 경우 */
select * from board2 where idx = 20 + 1;

select * from board2 where idx > 5 limit 1; /* 다음글 */
select * from board2 where idx < 5 order by idx desc limit 1; /* 이전글 */


/* 최근글 출력연습 */
select * from board2 where date_sub(now(), interval 1 month) < wDate order by idx desc;
select count(*) from board2 where date_sub(now(), interval 1 day) < wDate;
select * from board2 where 1 > 2; /*where절 이하가 false가 되어서 데이터가 select되지 않는다.*/


/* 
 외래키(foreign key) : 서로다른 테이블간의 연관관계를 맺어주기위한 키
 		: 외래키를 설정하려면, 설정하려는 외래키는 다른테이블의 주키(Primary key)이어야 한다.
 		  즉, 외래키로 지정하는 필드는, 해당테이블의 속성과 똑 같아야 한다.(필드명은 달라도 된다.)
*/

/* 댓글 테이블(boardReply2) */
create table boardReply2 (
	idx   		int not null auto_increment,  	/* 댓글의 고유번호 */
	boardIdx 	int not null,					/* 원본글의 고유번호(외래키로 지정함) */
	mid 		varchar(20) not null,			/* 댓글 올린이의 아이디 */
	nickName 	varchar(20) not null,      		/* 댓글 올린이의 닉네임 */
	wDate		datetime default now(),			/* 댓글쓴 날짜 */
	hostIp 		varchar(50) not null,			/* 댓글쓴 PC의 IP */
	content 	text not null,					/* 댓글 내용 */
	primary key(idx),				   			/* 주키(기본키)는 idx */
	foreign key(boardIdx) references board(idx) /*board테블의 idx를 boardReply2테이블의 외래키(boardIdx)로 설정 */
	on update cascade 				   /* 원본테이블에서의 주키의 변경의 영향을 받는다. */
	on delete restrict				   /* 원본테이블에서의 주키를 삭제시키지 못하게 한다.(삭제시는 에러발생하고 원본키를 삭제하지 못함)  게시글에 댓글이 달려있으면 게시글을 못지움. 해당 댓글을 먼저 지우고 게시글을 지워야한다.*/
);


drop table boardReply2;


/* 
 - 테이블 설계시 제약조건(필드에 대한 제한) - constraint
   : 생성시에 설정(creat), 생성 후 변경(alter table)
 1. 필드의 값 허용유무? not null
 2. 필드의 값을 중복허용하지 않겠다? primary key, unique
 3. 필드의 참조유무(다른테이블에서)? foreign key
 4. 필드의 값에 기본값을 지정? default
  
 */
show tables;
/* unique : 필드가 서로다른 값을 갖도록 함.(중복할 수 없도록 제약조건 설정시 사용) */ 

create table testStudent (
	idx int not null auto_increment,
	hakbun int not null unique,
	mid varchar(20) not null unique,
	name varchar(20) not null,
	age int default 20,
	primary key(idx,hakbun)
);

desc testStudent;

drop table testStudent;


insert into testStudent values (default, 1111, 'hkd1234', '홍길동', default);
insert into testStudent values (default, 2222, 'kms1234', '김말숙', default);
insert into testStudent values (default, 4444, 'ohl1234', '오하늘', default);
insert into testStudent values (default, 3333, 'ohl1234', '오하늘', default);

select * from testStudent;



/*
	sub query
	: 쿼리안에 쿼리를 삽입하는 방법(위치는 상황에 따라서 사용자가 지정해준다.) - select 문과 함께 사용...
	예) select 필드명, (서브쿼리) from 테이블명 ~ where 조건절 ~~~ ...
		select 필드리스트 from (서브쿼리) ~~~ where 조건절 ~~~ ...
		select 필드리스트 from 테이블명 where (서브쿼리) ~~ ....
*/


-- board 테이블의 목록 모두 보여주기(idx 역순으로, 출력자료의 개수는 5개)
select * from board order by idx desc limit 5;
-- boardReply2 테이블의 구조?
desc boardReply2;
-- board 테이블의 idx 29번글에 적혀있는 댓글(boardReply2테이블)의 개수는?
select count(*) from boardReply2 where boardIdx = 29;
-- board 테이블의 idx 29번글에 적혀있는 댓글(boardReply2테이블)의 개수는?(단, 출력은 부모글의 고유번호와 댓글개수를 출력)
select boardIdx as '부모고유번호', count(*) as '댓글개수' from boardReply2 where boardIdx = 29;
-- board 테이블의 idx 29번글에 적혀있는 댓글(boardReply2테이블)의 개수는?(단, 출력은 부모글의 고유번호와 댓글개수, 게시글을 쓴 사람의 nickName 까지)
select (select nickName from board where idx = 29) as 닉네임, boardIdx as 부모고유번호, count(*) as 댓글개수 from boardReply2 where boardIdx = 29;
-- board 테이블의 29번의 작성자의 아이디와 현재글(부모글 29번)에 달려있는 댓글 사용자의 닉네임을 출력하시오.
select (select mid from board where idx = 29) as 작성자아이디, nickName from boardReply2 where boardIdx = 29;

-- 부모관점에서 자료를 select 해오면.. 1:多 관계라서, 댓글이 2개 이상이면..에러가 난다.(아이디는 1개가 출력.댓글은 2개 출력이기 때문에..) 
select mid, (select nickName from boardReply2 where boardIdx = 29) as 작성자닉네임 from board where idx = 29;

-- board 테이블의 29번의 작성자의 아이디와 현재글(부모글 29번)에 달려있는 댓글의 갯수를 출력하시오.
select mid, (select count(*) from boardReply2 where boardIdx = 29) as 댓글개수 from board where idx = 29;

-- 부모테이블(board)에 있는 자료 중 뒤에서 5개를 출력하되(아이디,닉네임), 부모테이블에 달려있는 댓글(boardReply2)의 수와 함께 출력하시오.
select idx,mid,nickName,(select count(*) from boardReply2 where boardIdx = board.idx) as replyCount from board order by idx desc limit 5;


