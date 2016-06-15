CREATE TABLE items(
  id MEDIUMINT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY(id),
  task VARCHAR(64) NOT NULL,
  done BOOLEAN NOT NULL,
  created DATETIME
);

insert into items (task, done) values ('Buy socks!', '0');
insert into items (task, done) values ('Buy hairties!!', '0');
