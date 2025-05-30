# 덤프파일 생성
mysqldump -u root -p 스키마명 > 덤프파일명
mysqldump -u root -p board > mydumpfile.sql
docker exec -it 컨테이너ID mariadb-dump -u root -p1234 board > mydumpfile.sql

# 덤프파일 적용(복원)
mysql -u root -p 스키마명 < 덤프파일명
mysql -u root -p board < mydumpfile.sql
docker exec -i 컨테이너ID mariadb -u root -p1234 board < mydumpfile.sql