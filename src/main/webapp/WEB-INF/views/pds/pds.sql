/*pds2.sql*/

show tables;

create table pds2 (
	idx  		int not null auto_increment, 	/* 자료실 고유번호 */
	mid 		varchar(20) not null,		  	/* 올린이 아이디 */
	nickName 	varchar(20) not null,	  		/* 올린이 닉네임 */
	fName 		varchar(255) not null,	  		/* 업로드할때의 원본파일명 */
	fSName 		varchar(255) not null,	  		/* 파일 서버에 저장되는 실제파일명 */
	fSize 		int,							/* 총 파일 사이즈 */
	title		varchar(100) not null,			/* 파일 제목 */
	part		varchar(20) not null,			/* 파일 분류 */
	pwd			varchar(100) not null,			/* 비밀번호 암호화 : SHA-256암호화 처리) */
	fDate		datetime default now(),			/* 파일 업로드한 날짜 */
	downNum		int default 0,					/* 파일 다운로드 횟수 */
	openSw		char(6) default '공개',			/* 파일 공개(비공개)여부 */ 
	content		text,							/* 파일 상세설명 */
	primary key (idx)							/* 기본키 : 자료파일의 고유번호 */
);

desc pds2;

select * from pds2 order by idx desc;

update pds2 set downNum = downNum + 1 where idx = 1;