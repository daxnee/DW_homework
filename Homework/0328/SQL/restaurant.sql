-- Mysql DDL
CREATE TABLE food(
    foodNo INTEGER(4) AUTO_INCREMENT PRIMARY KEY COMMENT '음식 번호', 
    foodName VARCHAR(20) NOT NULL COMMENT '음식 이름',
    foodPrice INTEGER(4) NOT NULL COMMENT '음식 가격',
);
    
CREATE TABLE restaurant(
    restaurantNo INTEGER(4) AUTO_INCREMENT PRIMARY KEY COMMENT '레스토랑 번호',
    restaurantName VARCHAR(20) NOT NULL COMMENT '레스토랑 이름',
    foodNo INTEGER(4) NOT NULL COMMENT '음식 번호',
    FOREIGN KEY(foodNo) REFERENCES food(foodNo)
);

SELECT * FROM restaurant WHERE foodNo = 30 AND restaurantName= '빠스타스';
/* 문제 1.
레스토랑 테이블에 데이터가 일일 1000만건 저장된다. 
레스토랑 테이블에서 위에 작성한 select쿼리 호출 시간이 오래 걸리기 시작했다.
가장 먼저해야하는 바람직한 행동은?
답안 작성 => foodNo에 인덱스 설정 
*/
ALTER TABLE 테이블명 ADD INDEX 인덱스명 (칼럼명1, 칼럼명2)
ALTER TABLE restaurant ADD INDEX restaurant_test (foodNo, restaurantName)

DELETE FROM food
WHERE foodNo = 30;


참조키(FK)는 INDEX를 해줘야 한다. 
PK는 자동으로 생성됨.




/* 문제 2.
음식 테이블에 30번 음식 데이터를 지우려고 한다.
하지만 레스토랑 테이블에 30번 데이터가 있어서 지울 수가 없다. 
음식 테이블에 30번 데이터를 지울 방법은 무엇일까?
답안 작성 => 참조키 설정시 on delete cascade 설정
*/  
ALTER TABLE restaurant DROP FOREIGN KEY foodNo;
--  기존 fk 삭제
ALTER TABLE restaurant ADD CONSTRAINT foodNo FOREIGN KEY(foodNo) REFERENCES food(foodNo) ON DELETE CASCADE;
-- 제약 사항 추가
--  