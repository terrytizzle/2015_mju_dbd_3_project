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
worker_terminate DATETIME,
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
total_evaluation INTEGER NOT NULL,
count_project INTEGER NOT NULL,
period INTEGER NOT NULL,
incentive INTEGER NULL,
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

INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`, `project_describe`) VALUES ('00000001', '프로젝트1', '2015.10.30', '2016.04.30', '명지대학교', 'Test');
INSERT INTO project (`project_id`, `project_name`, `project_start`, `project_finish`, `project_owner`) VALUES ('00000002', '프로젝트2', '2015.11.02', '2015.12.03.', '컴퓨터공학');

INSERT INTO evaluation (`eval_work`, `eval_communication`, `eval_score`) VALUES ('4', '5', '9');
INSERT INTO evaluation (`eval_work`, `eval_communication`, `eval_score`) VALUES ('5', '5', '10');


INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('10000000', '홍길동', '10000000', '1960.01.01', '경영', '1000', '1988.01.01', 'aaa@aa.aa', '고등학교 졸업', '사장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('20000000', '최이사', '20000000', '1992-12-31', '경영', '900', '2015-03-02', 'bbb@bb.bb', '대학교 졸업', '이사');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('30000000', '이부장', '30000000', '1992-12-31', '인사', '650', '2015-03-02', 'ccc@cc.cc', '대학교 졸업', '부장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('40000000', '김차장', '40000000', '1992-12-31', 'PM', '550', '2015-03-02', 'ddd@dd.dd', '대학교 졸업', '차장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('50000000', '박과장', '50000000', '1992-12-31', 'PM', '450', '2015-03-02', 'eee@ee.ee', '대학교 졸업', '과장');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60000000', '조대리', '60000000', '1992-12-31', '개발', '350', '2015-03-02', 'fff@ff.ff', '대학교 졸업', '대리');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('70000000', '윤사원', '70000000', '1992-12-31', '개발', '250', '2015-03-02', 'ggg@gg.gg', '대학교 졸업', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60112319', '김도형', '60112319', '1993.01.10', '개발', '250', '2015.03.02', 'kdh7785@naver.com', '대학교 재학', '사원');
INSERT INTO worker (`worker_id`, `worker_name`, `worker_pswd`, `worker_birth`, `worker_dept`, `worker_salary`, `worker_entrance`, `worker_email`, `worker_final_edu`, `pos_name`) VALUES ('60112380', '우희태', '60112380', '1992-12-31', '개발', '250', '2015-03-02', 'bbb@bb.bb', '대학교 재학', '사원');

INSERT INTO works_for (`works_name`, `works_start`, `works_finish`, `works_duty`, `project_id`, `worker_id`) VALUES ('개발자', '2016-01-07', '2016-03-31', '인터페이스 구현', '1', '60112319');
INSERT INTO works_for (`works_name`, `works_start`, `works_finish`, `works_duty`, `project_id`, `worker_id`) VALUES ('분석자', '2015-11-04', '2015-11-11', '디자인 분', '2', '60112319');


INSERT INTO project_eval (`project_id`, `eval_id`) VALUES ('1', '2');
INSERT INTO project_eval (`project_id`, `eval_id`) VALUES ('2', '1');


INSERT INTO worker_eval (`evaluator_id`, `worker_id`, `eval_id`, `classify`) VALUES ('60112319', '60112380', '1', '1');
INSERT INTO worker_eval (`evaluator_id`, `worker_id`, `eval_id`, `classify`) VALUES ('60112319', '60112380', '2', '2');


INSERT INTO personal_management (`total_evaluation`, `count_project`, `period`, `incentive`, `worker_id`) VALUES ('9', '2', '290', '50', '60112319');
INSERT INTO personal_management (`total_evaluation`, `count_project`, `period`, `incentive`, `worker_id`) VALUES ('9', '3', '290', '60', '60112380');

