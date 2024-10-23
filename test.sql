-- 회원 테이블 
CREATE TABLE members (
     mem_id VARCHAR2(50) PRIMARY KEY
    ,mem_pw VARCHAR2(1000) NOT NULL
    ,mem_nm VARCHAR2(100)
    ,mem_addr VARCHAR2(1000)
    ,mem_phone VARCHAR2(15)
    ,use_yn VARCHAR2(1) DEFAULT 'Y'
);

INSERT INTO members(mem_id, mem_pw, mem_nm) 
VALUES ('admin', 'admin', '관리자');

SELECT * FROM members;

-- 수면정보 테이블
CREATE TABLE sleep (
     mem_id VARCHAR2(50) PRIMARY KEY
    ,sleep_date DATE DEFAULT SYSDATE NOT NULL
    ,sleep_time DATE
    ,awake_time DATE
    ,use_yn VARCHAR2(1) DEFAULT 'Y'
    ,CONSTRAINT fk_members FOREIGN KEY(mem_id) REFERENCES members(mem_id) ON DELETE CASCADE
);

SELECT * FROM sleep;

commit;

--

-- 계정 생성 (DBA 권한 있는 계정에서 실행)
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER october IDENTIFIED BY october;
GRANT CONNECT, RESOURCE TO october;
GRANT UNLIMITED TABLESPACE to october;

/*
    무게 정보 테이블 test1
*/
CREATE TABLE tb_data (
      data VARCHAR2(1000)
     ,time DATE DEFAULT SYSDATE
);
--DROP TABLE tb_data;
SELECT * FROM tb_data;

INSERT INTO tb_data(data)
VALUES('');


/*
    무게 정보 테이블 test2
*/
CREATE TABLE tb_data2 (
      sleep_g VARCHAR2(100)
     ,detailtime VARCHAR2(100)
     ,datatime DATE DEFAULT SYSDATE
);

SELECT * FROM tb_data2
ORDER BY detailtime;
--DROP TABLE tb_data2;

CREATE TABLE tb_data3 (
      sleep_g VARCHAR2(100)
     ,detailtime VARCHAR2(100)
     ,datatime DATE DEFAULT SYSDATE
);
SELECT * FROM tb_data3
ORDER BY detailtime;
--DROP TABLE tb_data3;

SELECT SUBSTR(detailtime, 12, 8) AS sec
      ,ROUND(AVG(REGEXP_REPLACE(sleep_g, '[^0-9.-]', ''))) as sleep
FROM tb_data3
GROUP BY SUBSTR(detailtime, 12, 8)
ORDER BY SUBSTR(detailtime, 12, 8) ASC;

