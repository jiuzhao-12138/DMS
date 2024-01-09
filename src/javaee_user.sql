create table if not exists user
(
	id int auto_increment
		primary key,
	user_name varchar(50) not null,
	password varchar(50) not null,
	gender int null,
	birthday date null,
	deptID int null,
	constraint FK_ID
		foreign key (deptID) references department (id)
);



INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (1, '孙悟空', 'sunwukong', 1, '1990-10-17', 1);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (2, '猪八戒', 'zhubajie', 1, '1990-10-16', 1);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (3, '唐僧', 'tangseng', 1, '1990-10-15', 1);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (4, '白骨精', 'baigujing', 0, '1990-10-10', 1);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (5, '林冲', 'linchong', 1, '1990-10-09', 2);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (6, '宋江', 'songjiang', 1, '1990-10-09', 2);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (7, '孙二娘', 'sunerniang', 0, '1990-10-09', 2);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (8, '武松', 'wusong', 1, '1990-10-09', 2);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (9, '林黛玉', 'lindaiyu', 0, '1990-10-09', 3);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (10, '贾宝玉', 'jiabaoyu', 1, '1990-10-09', 3);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (11, '孙权', 'sunquan', 1, '1990-10-09', 4);
INSERT INTO javaee.user (id, user_name, password, gender, birthday, deptID) VALUES (12, '诸葛亮', 'zhugeliang', 1, '1990-10-09', 4);