use sample

/* 회원테이블 */
create table usertbl(
userid char(15) not null primary key,
name varchar(20) not null,
birthyear int not null, 
addr char(100),
mobile char(11),
mdate date)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/* 구매테이블 */
create table buytbl(
num int auto_increment primary key,
userid char(8) not null,
productname char(10),
groupname char(10),
price int not null,
amount int not null,
foreign key (userid) references usertbl(userid) on delete cascade)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/* 데이터 삽입 */
insert into usertbl values('kty', '김태연',1989,'전주','01011111111', '1989-3-9');
insert into usertbl values('bsj', '배수지',1994,'광주','01022222222', '1994-10-10');
insert into usertbl values('ksh', '김설현',1995,'부천','01033333333', '1995-1-3');
insert into usertbl values('bjh', '배주현',1991,'대구','01044444444', '1991-3-29');
insert into usertbl values('ghr', '구하라',1991,'광주','01055555555', '1991-1-13');
insert into usertbl values('san', '산다라박',1984,'부산','01066666666', '1984-11-12');
insert into usertbl values('jsm', '전소미',2001,'캐나다','01077777777', '2001-3-9');
insert into usertbl values('lhl', '이효리',1979,'서울','01088888888', '1979-5-10');
insert into usertbl values('iyou', '아이유',1993,'서울','01099999999', '1993-5-19');
insert into usertbl values('ailee', '에일리',1989,'미국','01000000000', '1989-5-30');

commit;

insert into buytbl values(null, 'kty', '운동화', '잡화', 30, 2);
insert into buytbl values(null, 'kty', '노트북', '전자', 1000, 1);
insert into buytbl values(null, 'jsm', '운동화', '잡화', 30, 1);
insert into buytbl values(null, 'lhl', '모니터', '전자', 200, 1);
insert into buytbl values(null, 'bsj', '모니터', '전자', 200, 1);
insert into buytbl values(null, 'kty', '청바지', '잡화', 100, 1);
insert into buytbl values(null, 'lhl', '책', '서적', 15, 2);
insert into buytbl values(null, 'iyou', '책', '서적', 15, 7);
insert into buytbl values(null, 'iyou', '컴퓨터', '전자', 500, 1);
insert into buytbl values(null, 'bsj', '노트북', '전자', 1000, 1);
insert into buytbl values(null, 'bjh', '메모리', '전자', 50, 4);
insert into buytbl values(null, 'ailee', '운동화', '잡화', 30, 2);
insert into buytbl values(null, 'ghr', '운동화', '잡화', 30, 1);

commit;

SELECT * from usertbl;
SELECT * from buytbl;

/* usertbl 테이블에서 name이 '김태연'인 데이터 조회 */ 
SELECT * from usertbl where name = '김태연';

/* usertbl 테이블에서 birthyear가 1990년 이후이고 addr이 '서울'인 데이터의 모든 컬럼을 조회 */
SELECT * 
from usertbl 
where birthyear > 1990 and addr = '서울';

/* usertbl 테이블에서 birthyear가 1990년 이후이거나 addr이 '서울'인 데이터의 userid와 name을 조회 */
SELECT userid, name
from usertbl 
where birthyear > 1990 or addr = '서울';

/* usertbl 테이블에서 birthyear가 1990년부터 1993년 사이인 데이터의 모든 컬럼 조회 */
SELECT * from usertbl 
where birthyear BETWEEN 1990 and 1993;

select * from usertbl 
where birthyear >= 1990 and birthyear <= 1993;  

/* usertbl 테이블에서 name에 '라'가 포함된 데이터의 모든 컬럼 조회 */
SELECT * 
from usertbl 
where name like '%라%';

/* usertbl 테이블에서 name에 '배'로 시작하는 데이터의 모든 컬럼 조회 */ 
SELECT * 
from usertbl 
where name like '배%'

/* buytbl 테이블에서 중복되지 않도록 userid를 조회 */ 
SELECT DISTINCT userid
from buytbl;

SELECT userid 
from buytbl
group by userid; 

/* buytbl 테이블에서 userid 별로 데이터 개수와 price의 합계를 조회 */ 
SELECT count(userid), sum(price)
from buytbl; /* 틀렸음 */ 

SELECT userid, count(*), sum(price)
from buytbl 
group by userid; 

/* buytbl 테이블에서 userid 별로 데이터 개수와 price의 합계를 조회하는데 
 * 데이터가 2개 이상인 데이터만 조회  */
SELECT userid, count(*), sum(price)
from buytbl 
group by userid
having count(*) >= 2;

/* usertbl 테이블의 데이터를 userid 데이터의 내림차순으로 정렬해서 출력 */
SELECT *
from usertbl
order by userid desc;

/* usertbl 테이블의 데이터를 birthyear의 오름차순으로 정렬해서 출력하는데
 * birthyear이 동일하면 name의 내림차순으로 정렬 */ 
SELECT *
from usertbl 
order by birthyear asc, name desc;

/* limit */
SELECT *
from usertbl 
order by birthyear asc, name desc
limit 1, 5; /* 0부터 시작, 2번째부터 5개 출력 */ 

/* usertbl 테이블의 name과 buytbl 테이블의 productname을 함께 조회 */
SELECT name, productname 
from usertbl, buytbl 
where usertbl.userid = buytbl.userid; 

/* usertbl 테이블에서 userid와 mobile 그리고 buytbl에서 groupname 조회 
 * birthyear이 1993 이상인 데이터만 조회 */
SELECT usertbl.userid, mobile, groupname 
from usertbl, buytbl 
where usertbl.userid = buytbl.userid and birthyear >= 1993; 

/* usertbl 테이블의 name이 전소미인 데이터의 
 * buytbl 테이블의 useid와 productname 그리고 groupname을 조회 
 * => 테이블이 2개 있어야만 원하는 결과를 조회할 수 있는데 
 * 이전 상황과 다른 점은 조회할 열들이 buytbl에 모두 존재함 */
/* 1) join 이용 
 * => from 절 부터 수행되기 때문에 테이블의 모든 데이터를 조인한 후에 조건을 가져옴 */
SELECT buytbl.userid, productname, groupname 
from usertbl, buytbl 
where usertbl.userid = buytbl.userid and name = '전소미';

/* 2) subquery 이용 */
SELECT userid, productname, groupname
from buytbl 
where userid = (SELECT userid from usertbl where name = '전소미');
/* userid처럼 공통점을 먼저 찾고 비교
 * 다른 이름이지만 의미는 같을 때,  */

/* usertbl 테이블의 name이 전소미 또는 배수지인 데이터의 
 * buytbl 테이블의 useid와 productname 그리고 groupname을 조회 */
SELECT userid, productname, groupname 
from buytbl 
where userid in (SELECT userid from usertbl where name in ('전소미', '배수지'));

SELECT buytbl.userid, productname, groupname 
from usertbl, buytbl 
where usertbl.userid = buytbl.userid and (name = '전소미' or name = '배수지');

SELECT * from usertbl;
SELECT * from buytbl;

/* insert */ 
insert into usertbl(userid, name, birthyear, addr, mobile, mdate)
VALUES('kty', '김태연', 1989, '전주', '01012345678', '1988-01-01');
/* userid는 primary key로 설정돼서 추가 안 됨 */

insert into usertbl(userid, name, birthyear, addr, mobile, mdate)
VALUES('jennie', '김제니', 1996, '서울', '01012345678', '1996-01-16');

/* 외래키가 있을 때는 외래키를 확인하고 삽입해야 함 
 * 외래키의 값은 null이거나 참조하는 테이블의 있는 데이터만 가능
 * => userid는 있는 데이터여야 가능 (지금은 ISAM이라 가능..) */
insert into buytbl(userid, productname, groupname, price, amount)
VALUES('boxy', '박시밥', '고양이밥', 27000, 1);

/* buytbl 테이블에서 num이 9번인 데이터의 price를 700000으로 수정
 * 1) buytbl 테이블에 num이 9번인 데이터가 있는지 확인  */
SELECT * from buytbl where num = 9; 

/* 2) 수정하는 sql 구문 */
update buytbl set price = 70000000 where num = 9; 

SELECT * from buytbl;

/* 데이터 삭제 */
delete from buytbl where num = 9; 

/* usertbl 테이블에 데이터를 삽입하는 프로시저 */
create PROCEDURE insertuser(
	vuserid char(15), vname varchar(10) CHARACTER set utf8, 
	vbirthyear int, vaddr char(100), vmobile char(11), 
	vmdate date)
begin 
	insert into usertbl(userid, name, birthyear, addr, mobile, mdate)
	VALUES(vuserid, vname, vbirthyear, vaddr, vmobile, vmdate);
end;

drop PROCEDURE insertuser;

SELECT * from usertbl;

/* 프로시저 실행 */
call insertuser('joy', '조이', 1996, '제주', '01012345678', '1996-09-03');

UPDATE usertbl set mobile = '01012342131' where userid='haru1';
/* 조건에 맞지 않은 구문을 실행해도 실패되지 않음 - 수정할 데이터가 없는 것*/

