-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
create user 'young'@'%' identified by '1234';

-- 사용자에게 권한 부여
grant select on board.author to 'young'@'%';
grant select, insert on board.* to 'young'@'%';
grant all privileges on board.* to 'young'@'%';

-- 사용자 권한 회수
revoke select on board.author from 'young'@'%';
-- 사용자 권한 조회
show grants for 'young'@'%';
-- 사용자 계정 삭제
drop user 'young'@'%';