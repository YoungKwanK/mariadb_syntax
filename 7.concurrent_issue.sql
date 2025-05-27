-- read uncommited : 커밋되지 않은 데이터 read가능 -> dirty read
-- 실습 절차
-- 1) 워크벤치에서 auto_commit해제. update 후, commit하지 않음.(transaction1)
-- 2) 터미널을 열어 select했을 때 위 변경사항이 읽히는 확인(transaction2)
-- 결론 : mariaDB는 기본이 repeatable read이므로 dirty read 발생하지 않음

-- read committed : 커밋한 데이터만 read가능 -> phantom read 발생(또는 non-repeatable read)
-- 워크벤치에서 실행
start transaction;
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;
-- 터미널에서 실행
insert into author(email) values('xxxxxx@naver.com'); 

-- repeatable read : 읽기의 일관성 보장 -> lost update 문제 발생 -> 배타적 자금으로 해결.
-- lost update 문제 발생
-- 워크밴치
DELIMITER //
create procedure concurrent_test()
begin
  declare count int;
  start transaction;
  insert into post(title, author_id) values('hello world', 1);
  select post_count into count from author where id=1;
  do sleep(15);
  update author set post_count=count+1 where id=1;
  commit; 
END //
DELIMITER ;
-- 터미널 실행
select post_count from author where id=1;

-- lost update 문제 해결 : select for update시에 트랜잭션이 종료 후에 특정 행에 대한 lock 풀림
-- 워크밴치
DELIMITER //
create procedure concurrent_test2()
begin
  declare count int;
  start transaction;
  insert into post(title, author_id) values('hello world', 1);
  select post_count into count from author where id=1 for update;
  do sleep(15);
  update author set post_count=count+1 where id=1;
  commit; 
END //
DELIMITER ;
--터미널
select post_count from author where id=1 for update;

-- seriallizable : 모든 트랜잭션 순차적 실행 -> 동시성 문제 없음(성능저하)