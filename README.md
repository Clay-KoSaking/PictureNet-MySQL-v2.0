# PictureNet-MySQL-v2.0

在启动 SpringBoot 项目前，后端数据库的准备流程如下：
1. 执行 PictureNet_1.sql 中除删除操作外的所有语句；
2. 在 picture_net 数据库中执行 SQL 语句
  ```sql
  insert into `user` values (
      1, 'sysAdmin', '12345678', 'The user doesn\'t have an intro now.', 
      'sys@admin.pn', 'admin', 'normal', './image/default.png'
  )
  ```
3. 执行 PictureNet_2.sql 中除删除操作外的所有语句。
