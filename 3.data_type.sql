-- typeint: -128~127까지 표현
-- author테이블에 age컬럼 변경
alter table author modify column age tinyint unsigned;

-- int : 4이트(대략, 40억 숫자범위)

-- bigint : 8바이트
-- author, post테이블의 id 값 bigint 변경
alter table author modify column id bigint;

-- decimal(총자리수, 소수부 자리수)
alter table post add column price decimal(10, 3);
-- decimal 소수점 추가 시 짤림 현상 발생
insert into post(id, title, price, author_id) values (7, 'hello python', 10.33412,3);

-- 문자 타입 : 고정 길이(char), 가변 길이(varchar, text)
alter table author add column gender char(10);
alter table author add column self_introduction text;

-- blob(바이너리데이터) 타입 실습
-- 일반적으로 blob으로 저장하기 보다, varchar로 설계하고 이미지 경로만을 저장함
alter table author add column profile_image longblob;
insert into author(id, email, profile_image) values (8, 'aaa@naver.com', LOAD_FILE('"C:\테스트.png"'));

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role 컬럼 추가
alter table author add column role enum('user', 'admin') not null default 'user';
-- enum에 지정 안한 경우
insert into author(id, email) values(11, 'ssf@naver.com');
-- enum에 지정된 값이 아닌 경우
insert into author(id, email, role) values(12, 'sss@naver.com', 'admin2');
-- enum에 지정된 값인 경우
insert into author (id, email, role) values(10, 'sss@naver.com', 'admin');

-- date와 datetime
-- 날짜 타입의 입력, 수정, 조회 시에 문자열 형식을 사용
alter table author add column birthday date;
alter table post add column created_time datetime;
insert into post(id, title, author_id, created_time) values (7, 'hello', 3, '2025-05-23 14:36:30');
alter table post modify column created_time datetime default current_timestamp();
insert into post(id, title, author_id) values(10, 'hello', 3);

-- 비교 연산자
select * from author where id >=2 and id<=4;
select * from author id where between 2 and 4; -- 위 구문과 같은 구문
select * from author where in(2, 3,5);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위한 키워드
select * from post where title like 'h%';
select * from post where title like '%h';
select * from post where title like '%h%';

-- regexp : 정규표현식을 활용한 조회
select * from post where title regexp '[a-z]' -- 하나라도 알파벳 소문자가 들어있으면
select * from post where title regexp '[가-힣]' -- 하나라도 한글이 있으면

-- 날짜 변환 : 숫자 -> 날짜
select cast(20250523 as date); -- 2025-05-23
select cast(num as date) from author;
-- 믄자 -> 날짜
select cast('20250523' as date); -- 2025-05-23
-- 문자 -> 숫자
select cast('12' as unsigned);

-- 날짜 조회 방법 : 2025-05-23 14:30:25
-- like 패턴, 부동호 활용, date_format
select * from post where created_time like '2025-05%'; -- 문자열처럼 조회
-- 5월 1일부터 5월 20일까지 날짜만 입력 시 시간 부분은 00:00:00이 자동으로 붙음
select * from post where created_time >= '2025-05-01' and created_time < '2025-05-21';

select date_format(created_time, '%Y-%m-%d') from post;
select date_format(created_time, '%H:%i:%s') from post;
select * from post where date_format(created_time, '%m') = '05';

select * from post where cast(date_format(created_time, '%m') as unsigned)=5;