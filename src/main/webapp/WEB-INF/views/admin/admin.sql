show tables;

create table adminTest (
	mid varchar(30) not null,					 /* 관리자 아이디 */
	name varchar(20) not null,					 /* 관리자 성명 */
	pwd varchar(255),						 	/* 관리자 비번(암호화) */
	idxKey int not null				 			/* key 값 */
);

desc adminTest;

drop table adminTest;

select * from adminTest;

create table hashKey (
	keyIdx int not null auto_increment primary key,					 /* key 값 */
	keyValue varchar(50) not null				 					/* 암호 내용 */
);

desc hashKey;

drop table hashKey;   

select * from hashKey;

select keyValue from hashKey where keyIdx = 3;

--0x25FB

insert into hashKey values (default, '01FB');
insert into hashKey values (default, '02FB');
insert into hashKey values (default, '03FB');
insert into hashKey values (default, '04FB');
insert into hashKey values (default, '05FB');
insert into hashKey values (default, '06FB');
insert into hashKey values (default, '07FB');
insert into hashKey values (default, '08FB');
insert into hashKey values (default, '09FB');
insert into hashKey values (default, '10FB');


insert into hashKey values (default, '11FB');
insert into hashKey values (default, '12FB');
insert into hashKey values (default, '13FB');
insert into hashKey values (default, '14FB');
insert into hashKey values (default, '15FB');
insert into hashKey values (default, '16FB');
insert into hashKey values (default, '17FB');
insert into hashKey values (default, '18FB');
insert into hashKey values (default, '19FB');
insert into hashKey values (default, '20FB');
insert into hashKey values (default, '21FB');
insert into hashKey values (default, '23FB');
insert into hashKey values (default, '24FB');
insert into hashKey values (default, '25FB');
insert into hashKey values (default, '26FB');

insert into hashKey values (default, '27FB');
insert into hashKey values (default, '28FB');
insert into hashKey values (default, '29FB');
insert into hashKey values (default, '30FB');


insert into hashKey values (default, '01AB');
insert into hashKey values (default, '02AB');
insert into hashKey values (default, '03AB');
insert into hashKey values (default, '04AB');
insert into hashKey values (default, '05AB');
insert into hashKey values (default, '06AB');
insert into hashKey values (default, '07AB');
insert into hashKey values (default, '08AB');
insert into hashKey values (default, '09AB');
insert into hashKey values (default, '10AB');
insert into hashKey values (default, '11AB');


insert into hashKey values (default, '01DB');
insert into hashKey values (default, '02DB');
insert into hashKey values (default, '03DB');
insert into hashKey values (default, '04DB');
insert into hashKey values (default, '05DB');
insert into hashKey values (default, '06DB');
insert into hashKey values (default, '07DB');
insert into hashKey values (default, '08DB');
insert into hashKey values (default, '09DB');
insert into hashKey values (default, '10DB');