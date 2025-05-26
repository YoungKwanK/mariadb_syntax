-- insert, into, values : 테이블에 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);
insert into author(id, name, email) values(3, 'hong3', 'hong3@naver.com'); -- 문자열은 일반적으로 작은 따옴표 사용
-- update, set : 테이블에 데이터 변경
update author set name="홍길동", email="hong100@naver.com" where id=3;
-- selete : 조회
select 컬럼1, 컬럼2 from author;
select name email from author;
select * from author;
-- delete : 삭제
delete from author where id='3';

-- select 조건절 활용 조회
-- 테스트 데이터 삽입
-- insert문을 활용해서 author데이터 3개, post데이터 5개
select * from author;
select * from author where id=1; --where 뒤에 조회조건을 통해 filtering
select * from author where name='hongildong';
select * from author where id>3;
select * from author where id>2 and name='hong4';
select * from author where id in (1, 3, 5);
select * from post where author_id in (select id from author where name='hong');

-- 중복 제거 조회 : distinct
select name from author;
select distinct name from author;

-- 정렬 : order by + 컬럼명
-- asc : 오름차순, desc : 내림차순, 안붙이면 오름차순(default)
-- 아무런 정렬조건 없이 조회할 경우에는 pk기준으로 오름차 순
select * from author order by name;

-- 멀티 컬럼 order by : 여러 컬럼으로 정렬시에, 먼저 쓴 컬럼 우선 정렬. 중복 시, 그 다음 정렬 옵션 적용
select * from author order by name desc, email asc; --name으로 먽 ㅓ정렬 후, name이 중복되면 email로 정렬.

-- 결과값 개수 제한
select * from author order by id desc limit 1;

-- 별칭(alias)를 이용한 select
select name as '이름', email as '이메일' from author;
select a.name, a.email from author as a;
select a.name, a.email from author a;

-- null을 조회 조건으로 활용
select * from author where password is null;
select * from author where password is not null;

-- 프로그래머스 sql문제풀이
-- 여러 기준으로 정렬하기
-- 상위 n개 레코드