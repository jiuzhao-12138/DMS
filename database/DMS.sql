drop database if exists DMS;
create database DMS;
use DMS;
create table `Building`(
	bid int primary key auto_increment,
    phone char(11) not null,
    `name` nvarchar(10) not null unique,
    location nvarchar(10) not null
)engine=INNODB default charset=utf8 auto_increment=0;
create table `Dormitory`(
	did int not null,
    bid int not null,
    occupancy int not null,
    bedNum int not null,
    waterAndElectricity double null,
    isPay boolean not null,
    health int not null,
    primary key(did,bid),
    constraint bdid_fk foreign key(bid) references `Building`(bid)
)engine=INNODB default charset=utf8;
#规定学号前6位为专业
create table `Student`(
	sid char(10) primary key,
    pwd varchar(10) not null,
    `name` nvarchar(10) not null,
    sex nchar(1) not null,
    bid int not null,
    did int not null,
    bedid int not null,
    state nvarchar(10) not null,
    phone char(11) not null,
    constraint dsid_fk foreign key(bid,did) references `Dormitory`(bid,did)
)engine=INNODB default charset=utf8;
create table `Visitor`(
	vid char(18) primary key,
    `name` varchar(10) not null,
    phone char(11) not null
)engine=INNODB default charset=utf8;
create table `Visit`(
	sid char(10) not null,
    vid char(18) not null,
	visitTime datetime not null,
    visitedTime datetime not null,
    relationship nchar(10),
    primary key(sid,vid),
    constraint svid_fk foreign key(sid) references `Student`(sid),
    constraint vvid_fk foreign key(vid) references `Visitor`(vid)
)engine=INNODB default charset=utf8 auto_increment=0;
create table `Wealth`(
	wid int primary key auto_increment,
    `value` double not null,
    `name` nvarchar(10) not null,
	bid int not null,
    did int not null,
    constraint dwid_fk foreign key(bid,did) references `Dormitory`(bid,did)
)engine=INNODB default charset=utf8 auto_increment=0;
create table `Maintainer`(
	mid int primary key auto_increment,
	pwd varchar(10) not null,
    `name` nvarchar(10) not null,
    phone char(11) not null
)engine=INNODB default charset=utf8 auto_increment=0;
create table `Maintained`(
	mid int not null,
    wid int not null,
    maintainTime datetime not null,
    primary key(mid,wid,maintainTime),
	constraint mmid_fk foreign key(mid) references `Maintainer`(mid),
    constraint wmid_fk foreign key(wid) references `Wealth`(wid)
)engine=INNODB default charset=utf8;
create table `RepairList`(
	rid int primary key auto_increment,
    repairTime datetime not null
)engine=INNODB default charset=utf8 auto_increment=0;
create table `Repair`(
	rid int not null,
    wid int not null,
    question varchar(10),
    primary key(rid,wid),
    constraint wrid_fk foreign key(wid) references `Wealth`(wid),
    constraint rrid_fk foreign key(rid) references `RepairList`(rid)
)engine=INNODB default charset=utf8;
create table `Administrator`(
	aid char(11) primary key,
	pwd varchar(10) not null,
    `name` nvarchar(10) not null,
    phone char(11) not null
)engine=INNODB default charset=utf8;
create table `Administration`(
	aid char(11) not null,
    bid int not null,
    workTime datetime not null,
    primary key(aid,bid),
	constraint waid_fk foreign key(aid) references `Administrator`(aid),
    constraint baid_fk foreign key(bid) references `Building`(bid)
)engine=INNODB default charset=utf8;
#s剩余房间表
create table `floor`(
	bid int not null,
	begindid int not null,
    enddid int not null,
	sex nchar(1) not null,
    bedNum int not null,
    primary key(bid,begindid),
    constraint beginfid_fk foreign key(begindid) references `Dormitory`(did),
    constraint endfid_fk foreign key(enddid) references `Dormitory`(did),
    constraint bfid_fk foreign key(bid) references `Building`(bid)
)engine=INNODB default charset=utf8;


insert into Building(phone,`name`,location) values
("18350976666","致高楼","西1"),
("18350976667","致远楼","西2"),
("18350976668","致强楼","西3"),
("18350976669","新知楼","东1"),
("18350976670","至诚楼","东2"),
("18350976665","荟萃楼","东3"),
("18350976664","聚兴楼","北1"),
("18350976663","广智楼","北2"),
("18350976662","执行楼","南1"),
("18350976661","学海楼","南2");

insert into Administrator(aid,pwd,`name`,phone) values
('100001','123456','root','15200000001'),
('100002','123425','顾老师','15200000002'),
('100003','123445','陆老师','15200000003'),
('100004','123456','朱老师','15200000004'),
('100005','123434','张老师','15200000005'),
('100006','12132','季老师','15200000006');

insert into Administration(aid,bid,workTime) values
('100001',1,'2000-08-09'),
('100001',2,'2008-09-08'),
('100002',2,'2020-11-09'),
('100002',3,now()),
('100003',3,now()),
('100003',4,now()),
('100004',4,now()),
('100004',5,now()),
('100005',5,now()),
('100005',6,now()),
('100006',6,now()),
('100006',7,now()),
('100004',8,now()),
('100001',9,now()),
('100002',10,now());
 
#方便插入数据做如下规定
#宿舍都是4人宿舍
#
delimiter $$
SET AUTOCOMMIT = 0$$
DROP PROCEDURE IF EXISTS addDormitory$$
create  procedure addDormitory(in num int)
begin
	#创建宿舍的属性
	DECLARE bid INT DEFAULT 1;
    DECLARE did INT DEFAULT 0;
	DECLARE occupancy int default 0;
    DECLARE bedNum int;
    DECLARE waterAndElectricity double;
    DECLARE isPay boolean;
    DECLARE health int;
    #创建学生
    DECLARE sid int default 1000000000;
    DECLARE pwd varchar(10) default '123456';
    DECLARE sname nvarchar(10) default '久曌';
    DECLARE sex nchar(1) default '男';
    DECLARE state nvarchar(10) default '住宿';
	#创建访客
	declare vid int8 default 350722200000000000;
	declare vname char(10) default '久曌';
    
    declare peopleNum int default 0;
    declare i int default 1;
    declare cnt int default 0;
    
    insert into maintainer(pwd,`name`,phone) values('123456','久曌','18295000000'),('123456','root','13295000000'),('123456','jiuzhao','19218600000'),('123456','jack','17216812345');
	
    while bid <= num DO
		set did = 101;
        IF bid>5 THEN
			set sex='男';
		ELSE
			set sex='女';
		END IF;
        #begin 创建一栋楼成员
		while did < 513  do
            # 获取宿舍人数
            set peopleNum = floor(rand()*4);
            #begin 创建宿舍入住序列
            if peopleNum = 0 then
				set occupancy=0;
            elseif  peopleNum = 1 then
				set occupancy=1;
            elseif  peopleNum = 2 then
				set occupancy=3;
			elseif  peopleNum = 3 then
				set occupancy=7;
			else
                set occupancy=15;
            end if;
			while peopleNum>cnt do
				set occupancy=occupancy+i<<cnt;
				set cnt=cnt+1;
            end while;
            #end 创建宿舍状态序列
			insert into Dormitory (did ,bid ,occupancy,bedNum,waterAndElectricity,isPay,health) values (did ,bid,occupancy,4,rand()*100,true,floor(rand()*100));
            #begin 创建财产
            insert into wealth(`value`,`name`,bid,did) values
            (99.9,'电灯',bid,did),
            (88.8,'风扇',bid,did),
            (77.7,'门把手',bid,did),
            (2000.2,'空调',bid,did),
            (222,'衣柜',bid,did),
            (500,'床',bid,did),
            (600,'插座',bid,did),
            (666,'水龙头',bid,did),
            (777,'下水道',bid,did),
            (888,'厕所',bid,did);
            
            #end 创建财产
			#begin 创建宿舍成员
            while peopleNum>0 do
				set sname=concat(SUBSTRING('赵钱孙李周吴郑王林杨柳刘孙陈江阮侯邹高彭徐',FLOOR(1+21*RAND()),1),SUBSTRING('一二三四五六七八九十甲乙丙丁静景京晶名明铭敏闵民军君俊骏天田甜兲恬益依成城诚立莉力黎励',ROUND(1+43*RAND()),1),SUBSTRING('一二三四五六七八九十甲乙丙丁静景京晶名明铭敏闵民军君俊骏天田甜兲恬益依成城诚立莉力黎励',ROUND(1+43*RAND()),1));
				insert into student(sid,pwd,`name`,sex,bid,did,bedid,state,phone) values(cast(sid as char(10)),pwd,sname,sex,bid,did,peopleNum,"住宿",'18350970000'); 
                set sid=sid+1;
                set peopleNum = peopleNum-1;
            end while;
            #end 创建宿舍成员
            set did = did+1;
		end while;
        #end 创建一栋楼成员
        SET bid = bid+ 1;
	END WHILE;
    #begin 创建修理记录
    set cnt=1;
    while cnt<5000 do
		insert into Maintained(mid,wid,maintainTime) values(floor(1+rand()*4),cnt,now());
		set cnt=cnt+1;
    end while;
    #end 创建修理记录
    #begin 创建订单
    insert into `repairList`(repairTime) values(now()),(now()),(now());
    set cnt=1;
    while cnt<20 do
		insert into `repair`(rid,wid,question) values(floor(1+rand()*3),cnt,'坏了');
		set cnt=cnt+1;
    end while;
    #end 创建订单
    #begin 创建参观者
    set cnt=1000000000;
    while cnt<sid  do
        set vname=concat(SUBSTRING('赵钱孙李周吴郑王林杨柳刘孙陈江阮侯邹高彭徐',FLOOR(1+21*RAND()),1),SUBSTRING('一二三四五六七八九十甲乙丙丁静景京晶名明铭敏闵民军君俊骏天田甜兲恬益依成城诚立莉力黎励',ROUND(1+43*RAND()),1),SUBSTRING('一二三四五六七八九十甲乙丙丁静景京晶名明铭敏闵民军君俊骏天田甜兲恬益依成城诚立莉力黎励',ROUND(1+43*RAND()),1));
		insert into Visitor(vid,`name`,phone) values(cast(vid as char(18)),vname,concat('1900000000',substring('1234567890',floor(1+10*rand()),1)));
        insert into visit(sid,vid,visitTime,visitedTime,relationship) values(cnt,cast(vid as char(18)),now(),now(),'亲属') ;
        set vid = vid+1;
		set cnt = cnt+1;
    end while;
    #end 创建参观者
end;$$
commit;$$
delimiter ;
call addDormitory(10);

select * from Building;
select * from Dormitory;
select * from student;
select * from visitor;
select * from Administrator;
select * from Administration;
select * from wealth;
select * from maintainer;
select * from `repair`;
select * from floor;