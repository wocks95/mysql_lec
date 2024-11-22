/*
    다대다 관계
    두 엔티티 사이에 다대다 관계가 존재할 수 있다.
    예시 : 학생과 과목, 고객과 상품 등
    다대다 관계는 두 엔티티의 직접 연결이 불가능하므로, 새로운 엔티티를 추가하여 2개의 1:M 관계로 구성한다.
    예시 : 학생과 과목(학생 - 수강신청 - 과목), 고객과 상품(고객 - 구매내역 - 상품)
*/

-- 학생 - 수강신청 - 과목
DROP TABLE IF EXISTS tbl_course;
DROP TABLE IF EXISTS tbl_student;
DROP TABLE IF EXISTS tbl_subject;

CREATE TABLE IF NOT EXISTS tbl_student 
(
    student_id CHAR(5) NOT NULL COMMENT '학번',
    student_name CHAR(5) COMMENT '성명',
    student_age SMALLINT COMMENT '나이',
    CONSTRAINT pk_student PRIMARY KEY (student_id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tbl_subject
(
    subject_id CHAR(2) NOT NULL COMMENT '과목코드',
    subject_name CHAR(5) COMMENT '과목명',
    subject_professor CHAR(5) COMMENT '교수명',
    CONSTRAINT pk_subject PRIMARY KEY (subject_id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tbl_course
(
    student_id CHAR(5) NOT NULL COMMENT '학번',
    subject_id CHAR(2) NOT NULL COMMENT '과목코드',
    CONSTRAINT pk_course PRIMARY KEY (student_id, subject_id),
    CONSTRAINT fk_student_course FOREIGN KEY(student_id) REFERENCES tbl_student(student_id),
    CONSTRAINT fk_subject_course FOREIGN KEY(subject_id) REFERENCES tbl_subject(subject_id)
)ENGINE=INNODB;

