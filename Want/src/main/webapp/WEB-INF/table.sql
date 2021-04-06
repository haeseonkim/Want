#######유저관련 DDL#########
#유저 테이블(user)
create table user (
id varchar(100) primary key,
pwd varchar(100) not null,
name varchar(20) not null,
birth varchar(20) not null,
mail varchar(100) not null,
phone varchar(20) not null,
nick varchar(50) unique key not null,
rdate datetime not null,
profile varchar(100) default 'default_profile.png' ,
greet varchar(1000) default '안녕하세요'
);

#######랜선여행관련 DDL#########
#랜선여행테이블(l_board)
create table l_board(
no int auto_increment primary key,
subject varchar(100) not null,
content varchar(2000) not null,
writer varchar(100) not null,
wdate datetime not null,
hit int not null,
location varchar(20) not null,
video varchar(200),
reply int not null,
heart int not null,
constraint l_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade
);

#랜선여행 댓글 테이블(l_reply)
create table l_reply(
no int auto_increment primary key,
bno int not null,
writer varchar(100) not null,
content varchar(1000),
wdate datetime not null,
grp int not null,
grps int not null,
grpl int not null,
constraint l_r_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade,
constraint l_r_bno_fk foreign key(bno) references l_board(no) 
on delete cascade
);

#랜선여행 게시판 좋아요 테이블(l_heart)
create table l_heart(
hno int auto_increment primary key,
bno int not null,
userid varchar(100) not null,
constraint l_heart_bno_fk foreign key(bno) references l_board(no)
on delete cascade,
constraint l_heart_userid_fk foreign key(userid) references user(nick)
on delete cascade on update cascade
);

#랜선여행 게시판 즐겨찾기 테이블 (l_favorite)
create table l_favorite(
fno int auto_increment primary key,
bno int not null,
userid varchar(100) not null,
constraint l_favorite_bno_fk foreign key(bno) references l_board(no)
on delete cascade,
constraint l_favorite_userid_fk foreign key(userid) references user(nick)
on delete cascade on update cascade
);


#######랜선여행신청 관련 DDL#########
#랜선여행 신청 테이블(la_board)
create table la_board(
no int auto_increment primary key,
subject varchar(100) not null,
content varchar(2000) not null,
writer varchar(100) not null,
wdate datetime not null,
hit int not null,
location varchar(20) not null,
picture varchar(200),
reply int not null,
constraint la_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade
);

#랜선여행 신청 댓글 테이블(la_reply)
create table la_reply(
no int auto_increment primary key,
bno int not null,
grp int not null,
grps int not null,
grpl int not null,
writer varchar(100) not null,
content varchar(1000),
wdate datetime not null,
constraint la_r_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade,
constraint la_r_bno_fk foreign key(bno) references la_board(no) 
on delete cascade
);

#######사진자랑하기 관련 DDL#########
#사진자랑 테이블(p_board)
create table p_board(
no int auto_increment primary key,
subject varchar(100) not null,
content varchar(2000) not null,
writer varchar(100) not null,
wdate datetime not null,
hit int not null,
location varchar(20) not null,
media varchar(200),
reply int not null,
heart int not null,
constraint p_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade
);

#사진자랑 게시판 좋아요 테이블(p_heart)
create table p_heart(
hno int auto_increment primary key,
bno int not null,
userid varchar(100) not null,
constraint p_heart_bno_fk foreign key(bno) references p_board(no)
on delete cascade,
constraint p_haert_userid_fk foreign key(userid) references user(nick)
on delete cascade on update cascade
);

#사진자랑 게시판 댓글 테이블(p_reply)
create table p_reply(
no int auto_increment primary key,
bno int not null,
grp int not null,
grps int not null,
grpl int not null,
writer varchar(100) not null,
content varchar(1000),
wdate datetime not null,
constraint p_r_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade,
constraint p_r_bno_fk foreign key(bno) references p_board(no) 
on delete cascade
);

#사진자랑 게시판 즐겨찾기 테이블 (p_favorite)
create table p_favorite(
fno int auto_increment primary key,
bno int not null,
userid varchar(100) not null,
constraint p_favorite_bno_fk foreign key(bno) references p_board(no)
on delete cascade,
constraint p_favorite_userid_fk foreign key(userid) references user(nick)
on delete cascade on update cascade
);


#######쇼핑정보 관련 DDL#########
#쇼핑정보 테이블(s_board)
create table s_board(
no int auto_increment primary key,
subject varchar(100) not null,
content varchar(2000) not null,
writer varchar(100) not null,
wdate datetime not null,
hit int not null,
location varchar(20) not null,
picture varchar(200),
reply int not null,
heart int not null,
constraint s_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade
);

#쇼핑정보 댓글 테이블(s_reply)
create table s_reply(
no int auto_increment primary key,
bno int not null,
writer varchar(100) not null,
content varchar(1000),
wdate datetime not null,
grp int not null,
grps int not null,
grpl int not null,
constraint s_r_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade,
constraint s_r_bno_fk foreign key(bno) references s_board(no) 
on delete cascade
);

#쇼핑 게시판 좋아요 테이블(s_heart)
create table s_heart(
hno int auto_increment primary key,
bno int not null,
userid varchar(100) not null,
constraint s_heart_bno_fk foreign key(bno) references s_board(no)
on delete cascade,
constraint s_haert_userid_fk foreign key(userid) references user(nick)
on delete cascade on update cascade
);

#쇼핑 게시판 즐겨찾기 테이블 (s_favorite)
create table s_favorite(
fno int auto_increment primary key,
bno int not null,
userid varchar(100) not null,
constraint s_favorite_bno_fk foreign key(bno) references s_board(no)
on delete cascade,
constraint s_favorite_userid_fk foreign key(userid) references user(nick)
on delete cascade on update cascade
);

#######숙소정보 관련 DDL#########
#숙소정보 테이블(a_board)
create table a_board(
no int auto_increment primary key,
subject varchar(100) not null,
content varchar(2000) not null,
writer varchar(100) not null,
wdate datetime not null,
hit int not null,
location varchar(20) not null,
picture varchar(200),
reply int not null,
heart int not null,
constraint a_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade
);

#숙소 정보 댓글 테이블(a_reply)
create table a_reply(
no int auto_increment primary key,
bno int not null,
writer varchar(100) not null,
content varchar(1000),
wdate datetime not null,
grp int not null,
grps int not null,
grpl int not null,
constraint a_r_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade,
constraint a_r_bno_fk foreign key(bno) references a_board(no) 
on delete cascade
);

#숙소 게시판 좋아요 테이블(a_heart)
create table a_heart(
hno int auto_increment primary key,
bno int not null,
userid varchar(100) not null,
constraint a_heart_bno_fk foreign key(bno) references a_board(no)
on delete cascade,
constraint a_haert_userid_fk foreign key(userid) references user(nick)
on delete cascade on update cascade
);

#숙소 게시판 즐겨찾기 테이블 (a_favorite)
create table a_favorite(
fno int auto_increment primary key,
bno int not null,
userid varchar(100) not null,
constraint a_favorite_bno_fk foreign key(bno) references a_board(no)
on delete cascade,
constraint a_favorite_userid_fk foreign key(userid) references user(nick)
on delete cascade on update cascade
);


#######동행구해요 관련 DDL#########
#동행 구해요 테이블 (w_board)
create table w_board(
no int auto_increment primary key,
subject varchar(100) not null,
content varchar(2000) not null,
writer varchar(100) not null,
wdate datetime not null,
hit int not null,
location varchar(20) not null,
picture varchar(200),
reply int not null,
constraint w_writer_fk foreign key(writer) references user(nick) 
on delete cascade on update cascade
);

#동행구해요 댓글 테이블 (w_reply)
create table w_reply(
no int auto_increment primary key,
bno int not null,
grp int not null,
grps int not null,
grpl int not null,
writer varchar(100) not null,
content varchar(1000),
wdate datetime not null,
constraint w_r_writer_fk foreign key(writer) references user(nick)
on delete cascade on update cascade,
constraint w_r_bno_fk foreign key(bno) references w_board(no)
on delete cascade
);


#######메세지 관련 DDL#########
create table message(
no int auto_increment primary key,
room int not null,
send_nick varchar(50) not null,
recv_nick varchar(50) not null,
send_time datetime not null,
read_time datetime not null,
content varchar(1000) not null,
read_chk int not null,
constraint m_send_nick_fk foreign key(send_nick) references user(nick)
on delete cascade on update cascade,
constraint m_recv_nick_fk foreign key(recv_nick) references user(nick)
on delete cascade on update cascade
);


