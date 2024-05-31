create table languages_list
(
    language_acr  varchar(5)   not null
        primary key,
    language_name varchar(255) not null
);

create table newsletter
(
    id          int auto_increment
        primary key,
    title       varchar(255) not null,
    description text         not null,
    picture     varchar(255) null,
    recurrence  tinyint(1)   not null
);

create table products
(
    id                 int auto_increment
        primary key,
    picture            varchar(255) not null,
    title              varchar(255) not null,
    description        varchar(255) not null,
    price              double       not null,
    link_tutorial      text         null,
    link_documentation text         null
);

create table product_opinion
(
    id            int auto_increment
        primary key,
    product_id_fk int          not null,
    description   varchar(255) not null,
    note          tinyint(1)   not null,
    constraint product_opinion_products_id_fk
        foreign key (product_id_fk) references products (id)
            on update cascade on delete cascade
);

create table user
(
    id                int auto_increment
        primary key,
    email             varchar(255)            not null,
    password          varchar(255)            not null,
    username          varchar(40)             not null,
    newsletter        tinyint(1) default 1    not null,
    darkmode          tinyint(1) default 0    not null,
    language          varchar(5) default 'FR' not null,
    min_soil_humidity int        default 10   not null,
    max_soil_humidity int        default 60   not null,
    min_air_humidity  int        default 30   not null,
    max_air_humidity  int        default 60   not null,
    min_temperature   int        default 20   not null,
    max_temperature   int        default 35   not null,
    notifications     tinyint(1) default 1    not null,
    `rank`            tinyint(1) default 0    not null,
    insee_code        varchar(10)             null
);

create table greenhouse
(
    id         int          not null
        primary key,
    user_id_fk int          not null,
    name       varchar(255) not null,
    constraint greenhouse_user_id_fk
        foreign key (user_id_fk) references user (id)
            on update cascade on delete cascade
);

create table log_greenhouse
(
    id               int      not null
        primary key,
    greenhouse_id_fk int      not null,
    humidity         int      not null,
    soil_humidity    int      not null,
    temperature      int      not null,
    date             datetime not null,
    constraint log_greenhouse_greenhouse_id_fk
        foreign key (greenhouse_id_fk) references greenhouse (id)
            on update cascade on delete cascade
);

create table `order`
(
    id          int auto_increment
        primary key,
    user_id_fk  int    not null,
    total_price double not null,
    constraint order_user_id_fk
        foreign key (user_id_fk) references user (id)
            on update cascade on delete cascade
);

create table products_order
(
    id          int auto_increment
        primary key,
    order_id_fk int not null,
    id_product  int not null,
    quantity    int not null,
    constraint products_order_order_id_fk
        foreign key (order_id_fk) references `order` (id)
            on update cascade on delete cascade
);

