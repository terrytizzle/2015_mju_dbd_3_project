create database mjsolution default character set utf8 default collate utf8_general_ci;

grant all on mjsolution.* TO 'root'@'localhost' identified by 'admin';

use mjsolution;

CREATE TABLE POSITION (
pos_name VARCHAR(100) NOT NULL,
authorization INTEGER NOT NULL,
PRIMARY KEY (pos_name)
);

CREATE TABLE EVALUATION(
eval_id INTEGER NOT NULL AUTO_INCREMENT,
eval_work INTEGER NOT NULL,
eval_communication INTEGER NOT NULL,
eval_score INTEGER NOT NULL,
PRIMARY KEY (eval_id)
);

CREATE TABLE PROJECT(
project_id INTEGER NOT NULL,
project_name VARCHAR(100) NOT NULL,
project_start DATETIME NOT NULL,
project_finish DATETIME NOT NULL,
project_owner VARCHAR(100) NOT NULL,
project_describe TEXT NULL,
project_status VARCHAR(100) NOT NULL default 0,
PRIMARY KEY (project_id)
);

CREATE TABLE WORKER(
worker_id INTEGER NOT NULL,
worker_name VARCHAR(100) NOT NULL,
worker_pswd INTEGER NOT NULL,
worker_birth DATETIME NOT NULL,
worker_dept VARCHAR(100) NOT NULL,
worker_salary INTEGER NOT NULL,
worker_entrance DATETIME NOT NULL,
worker_terminate DATETIME NULL,
worker_email VARCHAR(100) NOT NULL,
worker_final_edu VARCHAR(100) NOT NULL,
pos_name VARCHAR(100) NOT NULL,
PRIMARY KEY (worker_id),
FOREIGN KEY R_1 (pos_name) REFERENCES POSITION (pos_name)
);

CREATE TABLE WORKS_FOR(
project_id INTEGER NOT NULL,
worker_id INTEGER NOT NULL,
works_name VARCHAR(100) NOT NULL,
works_start DATETIME NOT NULL,
works_finish DATETIME NOT NULL,
works_duty VARCHAR(100) NOT NULL,
PRIMARY KEY (project_id,worker_id),
FOREIGN KEY R_2 (project_id) REFERENCES PROJECT (project_id),
FOREIGN KEY R_3 (worker_id) REFERENCES WORKER (worker_id)
);

CREATE TABLE PROJECT_EVAL(
project_id INTEGER NOT NULL,
eval_id INTEGER NOT NULL,
PRIMARY KEY (project_id,eval_id),
FOREIGN KEY R_4 (project_id) REFERENCES PROJECT (project_id),
FOREIGN KEY R_5 (eval_id) REFERENCES EVALUATION (eval_id)
);

CREATE TABLE WORKER_EVAL(
worker_id INTEGER NOT NULL,
eval_id INTEGER NOT NULL,
evaluator_id INTEGER NOT NULL,
classify INTEGER NOT NULL,
PRIMARY KEY (worker_id,eval_id),
FOREIGN KEY R_6 (worker_id) REFERENCES WORKER (worker_id),
FOREIGN KEY R_8 (eval_id) REFERENCES EVALUATION (eval_id)
);


CREATE TABLE personal_management(
worker_id INTEGER NOT NULL,
period INTEGER NOT NULL,
incentive INTEGER DEFAULT '0' NULL,
PRIMARY KEY (worker_id),
FOREIGN KEY R_7 (worker_id) REFERENCES WORKER (worker_id)
);


INSERT INTO position (`pos_name`, `authorization`) VALUES ('사장', '1');
INSERT INTO position (`pos_name`, `authorization`) VALUES ('이사', '2');
INSERT INTO position (`pos_name`, `authorization`) VALUES ('부장', '3');
INSERT INTO position (`pos_name`, `authorization`) VALUES ('차장', '4');
INSERT INTO position (`pos_name`, `authorization`) VALUES ('과장', '5');
INSERT INTO position (`pos_name`, `authorization`) VALUES ('대리', '6');
INSERT INTO position (`pos_name`, `authorization`) VALUES ('사원', '7');

INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('1', '프로젝트1', '2015-11-03', '2016-12-03', '김도형', '프람트 솔루션');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('2', '프로젝트2', '2015-12-01', '2015-12-31', '김도형', '시험 프로젝');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('3', '프로젝트3', '2014-11-11', '2015-02-01', '우희태', '팀프로젝트');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('4', '프로젝트4', '2014-11-22', '2015-03-22', '김도형', '명지대학교 2학기');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('5', '프로젝트5', '2014-11-30', '2015-02-04', '김은영', '명지대학교 데이터베이스설계');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('6', '프로젝트6', '2015-01-01', '2015-05-01', '이성주', '데이터베이스설계 팀프로젝트');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('7', '프로젝트7', '2015-01-10', '2015-11-22', '윤혜성', '데이터베이스설계');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('8', '프로젝트8', '2015-02-01', '2015-03-11', '변지성', '명지대학교 팀프로젝트');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('9', '프로젝트9', '2015-03-14', '2015-05-14', '김도형', '명지대학교 2학기');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('10', '프로젝트10', '2015-05-12', '2015-06-01', '김은영', '명지대학교 2학기 팀프로젝트');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('11', '프로젝트11', '2015-05-14', '2015-08-19', '우희태', '명지대학교 컴퓨터공학과 데이터베이스설계');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('12', '프로젝트12', '2015-06-10', '2015-09-11', '이성주', '컴퓨터공학과 데이터베이스설계');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('13', '프로젝트13', '2015-07-01', '2015-11-11', '명지대', '컴퓨터공학과 팀프로젝트');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('14', '프로젝트14', '2015-07-11', '2015-10-30', '명지대', '컴퓨터공학과 데이터베이스설계');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('15', '프로젝트15', '2015-08-12', '2015-12-01', '변지성', '명지대학교 컴퓨터공학과');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('16', '프로젝트16', '2015-08-15', '2015-10-30', '윤혜성', '팀프로젝트');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('17', '프로젝트17', '2015-09-11', '2015-11-14', '이성주', '데이터베이스설계');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('18', '프로젝트18', '2015-10-05', '2015-12-12', '우희태', '안녕하세요');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('19', '프로젝트19', '2015-11-01', '2015-12-31', '김도형', '팀프로젝트');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('20', '프로젝트20', '2015-12-01', '2016-02-01', '김은영', '컴퓨터공학과 데이터 베이스 설계');

INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('1', 'MASTER', '1', '1970-01-01', '인사', '9999', '1995-03-01', 'admin@admin.com', '박사', '부장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('10000000', '나사장', '10000000', '1970-01-01', '경영', '1000', '1995-03-01', 'abc@naver.com', '대학교 졸업', '사장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('20000000', '나이사', '20000000', '1973-03-05', '경영', '800', '1997-01-05', 'aaa@naver.com', '대학교 졸업', '이사');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('20000001', '김이사', '20000001', '1973-08-21', '경영', '800', '1997-01-05', 'bbb@naver.com', '고등학교 졸업', '이사');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('20000002', '박이사', '20000002', '1974-02-03', '경영', '800', '1997-01-05', 'ccc@naver.com', '대학교 졸업', '이사');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('20000003', '강이사', '20000003', '1975-01-09', '경영', '800', '1997-07-07', 'ddd@naver.com', '대학교 졸업', '이사');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('20000004', '정이사', '20000004', '1975-10-27', '경영', '800', '1997-07-07', 'eee@naver.com', '대학교 졸업', '이사');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('30100001', '나부장', '30100001', '1974-05-20', '인사', '600', '1997-03-02', 'fff@naver.com', '대학교 졸업', '부장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('30110001', '김부장', '30110001', '1978-04-19', '회계', '600', '1998-03-02', 'ggg@naver.com', '고등학교 졸업', '부장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('30120001', '이부장', '30120001', '1976-08-06', '개발', '600', '1998-03-02', 'hhh@naver.com', '대학교 졸업', '부장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('30130001', '박부장', '30130001', '1978-11-11', '연구', '600', '1999-01-01', 'iii@naver.com', '대학교 졸업', '부장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('30140001', '강부장', '30140001', '1979-01-10', '영업', '600', '1997-03-01', 'jjj@naver.com', '대학교 졸업', '부장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('30160001', '유부장', '30160001', '1979-02-28', '법무', '600', '1997-03-01', 'kkk@naver.com', '고등학교 졸업', '부장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40100001', '김차장', '40100001', '1980-10-29', '인사', '450', '2003-03-02', 'lll@naver.com', '대학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40100002', '이차장', '40100002', '1981-05-07', '인사', '450', '2007-03-02', 'mmm@naver.com', '대학원 석사', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40110001', '박차장', '40110001', '1981-07-17', '회계', '450', '2004-03-02', 'nnn@naver.com', '대학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40110002', '우차장', '40110002', '1982-04-14', '회계', '450', '2001-03-02', 'ooo@naver.com', '고등학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40120001', '변차장', '40120001', '1981-12-10', '개발', '450', '2003-03-02', 'ppp@naver.com', '대학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40120002', '안차장', '40120002', '1982-01-29', '개발', '450', '2004-03-02', 'qqq@naver.com', '대학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40130001', '윤차장', '40130001', '1981-02-07', '연구', '450', '2000-03-02', 'rrr@naver.com', '고등학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40130002', '황차장', '40130001', '1982-03-16', '연구', '450', '2004-03-02', 'sss@naver.com', '대학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40140001', '정차장', '40140001', '1984-08-18', '영업', '450', '2006-03-02', 'ttt@naver.com', '대학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40140002', '양차장', '40140002', '1983-12-31', '영업', '450', '2002-03-02', 'uuu@naver.com', '고등학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40160001', '명차장', '40160001', '1983-12-25', '법무', '450', '2005-03-02', 'vvv@naver.com', '대학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40160002', '전차장', '40160002', '1983-08-15', '법무', '450', '2001-03-02', 'www@naver.com', '고등학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50100001', '김과장', '50100001', '1985-08-24', '인사', '400', '2008-03-02', 'xxx@naver.com', '대학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50100002', '박과장', '50100002', '1986-05-13', '인사', '400', '2005-03-02', 'yyy@naver.com', '고등학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50110001', '이과장', '50110001', '1986-07-18', '회계', '400', '2008-03-02', 'zzz@naver.com', '대학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50110002', '정과장', '50110002', '1986-05-31', '회계', '410', '2008-03-02', 'aa@naver.com', '대학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50120001', '전과장', '50120001', '1986-09-09', '개발', '390', '2008-03-02', 'bb@naver.com', '대학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50120002', '양과장', '50120002', '1984-11-30', '개발', '380', '2008-03-02', 'cc@naver.com', '대학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50130001', '진과장', '50130001', '1985-05-16', '연구', '370', '2008-03-02', 'dd@naver.com', '대학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50130002', '하과장', '50130002', '1987-01-03', '연구', '400', '2008-03-02', 'ee@naver.com', '대학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50140001', '유과장', '50140001', '1986-04-23', '영업', '400', '2008-03-02', 'ff@naver.com', '대학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50140002', '노과장', '50140002', '1985-03-26', '영업', '400', '2009-03-02', 'gg@naver.com', '대학원 석사', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50160001', '윤과장', '50160001', '1986-04-30', '법무', '390', '2006-03-02', 'hh@naver.com', '고등학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50160002', '안과장', '50160002', '1986-12-06', '법무', '380', '2006-03-02', 'ii@naver.com', '고등학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60100001', '김대리', '60100001', '1988-04-03', '인사', '350', '2009-03-02', 'jj@naver.com', '고등학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60100002', '박대리', '60100002', '1988-05-30', '인사', '350', '2009-03-02', 'kk@naver.com', '고등학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60110001', '이대리', '60110001', '1988-06-16', '회계', '350', '2009-03-02', 'll@naver.com', '고등학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60110002', '정대리', '60110002', '1988-07-01', '회계', '350', '2009-03-02', 'mm@naver.com', '고등학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60120001', '전대리', '60120001', '1988-07-25', '개발', '350', '2012-03-02', 'nn@naver.com', '대학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60120002', '양대리', '60120002', '1988-08-28', '개발', '350', '2012-03-02', 'll@naver.com', '대학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60120003', '진대리', '60120003', '1989-01-01', '개발', '330', '2012-03-02', 'oo@naver.com', '대학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60130001', '하대리', '60130001', '1988-11-12', '연구', '340', '2012-03-02', 'pp@naver.com', '대학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60130002', '유대리', '60130002', '1988-12-20', '연구', '370', '2012-03-02', 'qq@naver.com', '대학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60130003', '명대리', '60130003', '1988-11-19', '연구', '380', '2012-03-02', 'rr@naver.com', '대학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60130004', '배대리', '60130004', '1988-07-13', '연구', '330', '2012-03-02', 'ss@naver.com', '대학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60140001', '백대리', '60140001', '1988-04-02', '영업', '350', '2012-03-02', 'tt@naver.com', '대학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60140002', '황대리', '60140002', '1988-02-20', '영업', '320', '2012-03-02', 'uu@naver.com', '대학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60160001', '원대리', '60160001', '1990-03-02', '법무', '350', '2009-03-02', 'vv@naver.com', '고등학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000001', '김사원', '70000001', '1970-01-01', '인사', '200', '2000-01-01', 'a@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000002', '이사원', '70000002', '1971-01-11', '인사', '100', '2001-01-01', 'aa@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000003', '박사원', '70000003', '1972-11-23', '인사', '200', '2001-01-01', 'aaa@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000004', '최사원', '70000004', '1973-12-01', '인사', '300', '2001-01-01', 'aaaa@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000005', '정사원', '70000005', '1974-06-12', '인사', '230', '2000-01-01', 'aaaaa@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000006', '조사원', '70000006', '1975-11-23', '인사', '250', '2000-01-01', 'b@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000007', '장사원', '70000007', '1976-04-03', '인사', '190', '2001-01-01', 'bb@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000008', '주사원', '70000008', '1977-02-19', '인사', '200', '2001-01-01', 'bbb@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000009', '우사원', '70000009', '1978-04-15', '회계', '140', '2001-01-01', 'bbbb@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000010', '유사원', '70000010', '1979-03-18', '회계', '180', '2005-01-01', 'bbbbb@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000011', '윤사원', '70000011', '1980-11-03', '회계', '280', '2005-01-01', 'c@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000012', '가사원', '70000012', '1981-03-22', '회계', '180', '2005-01-01', 'cc@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000013', '나사원', '70000013', '1982-08-23', '회계', '290', '2001-01-01', 'ccc@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000014', '기사원', '70000014', '1983-11-29', '회계', '260', '2001-01-01', 'cccc@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000015', '남사원', '70000015', '1984-09-12', '회계', '230', '2000-01-01', 'ccccc@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000016', '라사원', '70000016', '1985-03-19', '회계', '220', '2000-01-01', 'd@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000017', '류사원', '70000017', '1986-11-23', '회계', '210', '2001-01-01', 'dd@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000018', '마사원', '70000018', '1987-05-11', '개발', '190', '2001-01-01', 'ddd@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000019', '명사원', '70000019', '1988-02-21', '개발', '180', '2001-01-01', 'dddd@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000020', '문사원', '70000020', '1989-04-28', '개발', '170', '2001-01-01', 'ddddd@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000021', '서사원', '70000021', '1990-11-23', '개발', '270', '2005-01-01', 'e@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000022', '손사원', '70000022', '1970-05-22', '개발', '280', '2000-01-01', 'ee@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000023', '송사원', '70000023', '1971-04-29', '개발', '190', '2000-01-01', 'eee@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000024', '연사원', '70000024', '1972-08-17', '개발', '230', '2000-01-01', 'eeee@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000025', '용사원', '70000025', '1973-09-11', '연구', '220', '2005-01-01', 'eeeee@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000026', '양사원', '70000026', '1974-08-14', '연구', '210', '2001-01-01', 'f@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000027', '전사원', '70000027', '1975-05-14', '연구', '100', '2005-01-01', 'ff@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000028', '차사원', '70000028', '1976-04-22', '연구', '200', '2005-01-01', 'fff@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000029', '추사원', '70000029', '1977-11-22', '연구', '100', '2000-01-01', 'ffff@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000030', '탁사원', '70000030', '1978-12-04', '연구', '150', '2000-01-01', 'fffff@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000031', '하사원', '70000031', '1980-11-05', '연구', '150', '2000-01-01', 'g@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000032', '남궁사원', '70000032', '1981-04-22', '연구', '120', '2001-01-01', 'gg@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000033', '황보사원', '70000033', '1982-11-29', '영업', '160', '2005-01-01', 'ggg@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000034', '선우사원', '70000034', '1983-08-08', '영업', '230', '2005-01-01', 'gggg@naver.com', '대학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000035', '제갈사원', '70000035', '1984-08-02', '영업', '230', '2005-01-01', 'ggggg@naver.com', '대학원졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000036', '피사원', '70000036', '1985-09-04', '영업', '250', '2001-01-01', 'h@naver.com', '대학원졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000037', '뇌사원', '70000037', '1986-09-09', '영업', '260', '2001-01-01', 'hh@naver.com', '대학원졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000038', '천사원', '70000038', '1987-02-11', '영업', '220', '2000-01-01', 'hhh@naver.com', '대학원졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000039', '선사원', '70000039', '1988-02-18', '영업', '230', '2000-01-01', 'hhhh@naver.com', '대학원졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000040', '현사원', '70000040', '1989-04-20', '영업', '240', '2007-01-01', 'hhhhh@naver.com', '대학원졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000041', '변사원', '70000041', '1990-03-29', '법무', '250', '2007-01-01', 'i@naver.com', '대학원졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000042', '홍사원', '70000042', '1990-11-29', '법무', '220', '2000-01-01', 'ii@naver.com', '대학원졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000043', '길사원', '70000043', '1989-10-10', '법무', '270', '2000-01-01', 'iii@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000044', '원사원', '70000044', '1992-11-28', '개발', '290', '2007-01-01', 'iiii@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000045', '안사원', '70000045', '1990-10-10', '개발', '100', '2007-01-01', 'iiiii@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000046', '진사원', '70000046', '1980-11-17', '개발', '300', '2007-01-01', 'j@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000047', '사사원', '70000047', '1987-12-19', '개발', '220', '2007-01-01', 'jj@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000048', '태사원', '70000048', '1988-02-03', '연구', '210', '2007-01-01', 'jjj@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000049', '배사원', '70000049', '1990-08-09', '연구', '200', '2000-01-01', 'jjjj@naver.com', '고등학교졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000050', '백사원', '70000050', '1990-04-04', '연구', '200', '2007-01-01', 'jjjjj@naver.com', '고등학교졸업', '사원');


INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '20', '0', '10000000');

INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '18', '0', '20000000');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '18', '0', '20000001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '18', '0', '20000002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '18', '0', '20000003');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '18', '0', '20000004');

INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '18', '0', '30100001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '17', '0', '30110001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '17', '0', '30120001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '16', '0', '30130001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '18', '0', '30140001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '18', '0', '30160001');

INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '12', '0', '40100001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '8', '0', '40100002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '11', '0', '40110001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '14', '0', '40110002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '12', '0', '40120001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '11', '0', '40120002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '15', '0', '40130001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '11', '0', '40130002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '9', '0', '40140001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '13', '0', '40140002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '10', '0', '40160001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '14', '0', '40160002');

INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '7', '0', '50100001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '10', '0', '50100002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '7', '0', '50110001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '7', '0', '50110002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '7', '0', '50120001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '7', '0', '50120002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '7', '0', '50130001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '7', '0', '50130002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '7', '0', '50140001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '6', '0', '50140002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '9', '0', '50160001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '9', '0', '50160002');

INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '6', '0', '60100001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '6', '0', '60100002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '6', '0', '60110001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '6', '0', '60110002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '60120001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '60120002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '60120003');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '60130001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '60130002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '60130003');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '60130004');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '60140001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '60140002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '60160001');

INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000001');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000002');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000003');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000004');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '70000005');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000006');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000007');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000008');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000009');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000010');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000011');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '70000012');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000013');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000014');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000015');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000016');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000017');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000018');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000019');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '4', '0', '70000020');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000021');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000022');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000023');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000024');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000025');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000026');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000027');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000028');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '70000029');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000030');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000031');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000032');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '5', '0', '70000033');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000034');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000035');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '4', '0', '70000036');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000037');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000038');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000039');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000040');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000041');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000042');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '70000043');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000044');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '2', '0', '70000045');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000046');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000047');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000048');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '3', '0', '70000049');
INSERT INTO personal_management ( `period`, `incentive`, `worker_id`) VALUES ( '1', '0', '70000050');