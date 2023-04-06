create database picture_net;
use picture_net;

create table user (
    user_id int primary key auto_increment,
    user_name nchar(20) not null,
    user_password char(32) not null check(length(user_password) between 8 and 32),
		user_intro nchar(50),
    user_email char(30) check(user_email like '%@%.%'),
    user_type enum('common', 'checker', 'admin') default 'common',
    user_status enum('normal', 'banned', 'deleted') default 'normal',
    user_image varchar(32) not null
);

create table follow (
    follow_user_id int,
    followed_user_id int,
    follow_time timestamp default now(),
    primary key(follow_user_id, follow_time),
    foreign key(follow_user_id) references user(user_id),
    foreign key(followed_user_id) references user(user_id)
);

create table message (
    mongodb_id varchar(50) primary key,
		send_user_id int,
    receive_user_id int,
    send_time timestamp default now(),
    foreign key(send_user_id) references user(user_id),
    foreign key(receive_user_id) references user(user_id)
);

create table picture (
    picture_id int primary key auto_increment,
    picture_author_id int not null,
    picture_name nchar(30) not null,
    picture_path varchar(50) not null,
    picture_intro nchar(200),
    picture_view int default 0,
    picture_transmit int default 0,
    picture_modify_time timestamp default now(),
    picture_status enum('normal', 'deleted') default 'normal'
);

create table comment (
    mongodb_id varchar(50) primary key,
    comment_user_id int,
    comment_picture_id int,
    comment_time timestamp default now(),
    comment_status enum('normal', 'deleted') default 'normal',
    foreign key(comment_user_id) references user(user_id),
    foreign key(comment_picture_id) references picture(picture_id)
);

create table tag (
    tag_id int auto_increment,
    tag_name nchar(30) not null,
    tag_status enum('normal', 'deleted') default 'normal',
    primary key(tag_id, tag_name)
);

create table tagpicture (
    tag_id int,
    picture_id int,
    primary key(tag_id, picture_id),
    foreign key(tag_id) references tag(tag_id),
    foreign key(picture_id) references picture(picture_id)
);

create table likes (
    user_id int,
    picture_id int,
    like_time timestamp default now(),
    is_liking int,
    primary key(user_id, picture_id),
    foreign key(user_id) references user(user_id),
    foreign key(picture_id) references picture(picture_id)
);

create table checkingpicture (
    checking_picture_id int auto_increment primary key,
    picture_author_id int,
    picture_name nchar(30) not null,
    picture_path varchar(64) not null,
    picture_intro nchar(200),
    original_picture_id int,
    checking_status enum('checking', 'checked') default 'checking'
);

create table checkingpicturetag (
    checking_picture_id int,
    checking_picture_tag_id int,
    primary key(checking_picture_id, checking_picture_tag_id)
);

create table result (
    picture_id int,
    checker_id int,
    check_time timestamp default now(),
    check_result enum('accessed', 'failed') default 'failed',
    primary key(picture_id, checker_id, check_time),
    foreign key(picture_id) references picture(picture_id),
    foreign key(checker_id) references user(user_id)
);

create table deleteduser (
    user_id int primary key
);

create table banneduser (
    user_id int,
    banned_time timestamp default now(),
    banned_reason nchar(50),
    is_banned int,
    primary key(user_id, banned_time),
    foreign key(user_id) references user(user_id)
);

create table deletedpicture (
    picture_id int primary key
);

create table deletedtag (
    tag_id int primary key
);

create table deletedcomment (
    mongodb_id varchar(50) primary key
);

alter table `user`
add fulltext index user_name_index(user_name)
with parser ngram;

alter table picture
add fulltext index picture_name_index(picture_name)
with parser ngram;




alter table `user`
drop index user_name_index;

alter table picture
drop index picture_name_index;

drop table deletedcomment;
drop table deletedtag;
drop table deletedpicture;
drop table banneduser;
drop table deleteduser;
drop table result;
drop table checkingpicturetag;
drop table checkingpicture;
drop table likes;
drop table tagpicture;
drop table tag;
drop table comment;
drop table picture;
drop table message;
drop table follow;
drop table user;