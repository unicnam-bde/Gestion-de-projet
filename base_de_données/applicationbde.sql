SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;

DROP DATABASE IF EXISTS `applicationbde`;
CREATE DATABASE IF NOT EXISTS `applicationbde`;

USE `applicationbde`;

DROP TABLE IF EXISTS `bde_badge`;
CREATE TABLE IF NOT EXISTS `bde_badge` (
  `b_id`          int(11)       NOT NULL    AUTO_INCREMENT,
  `b_name`        varchar(255)  NOT NULL,
  `b_description` text          NOT NULL,
  `b_image`       blob          NOT NULL,
  PRIMARY KEY (`b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_contact`;
CREATE TABLE IF NOT EXISTS `bde_contact` (
  `c_id`        int(11)      NOT NULL   AUTO_INCREMENT,
  `c_name`      varchar(255) NOT NULL,
  `c_firstname` varchar(255) NOT NULL,
  `c_email`     varchar(255) NOT NULL,
  `c_phone`     varchar(10)  DEFAULT NULL,
  `c_role`      varchar(255) NOT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_type`;
CREATE TABLE IF NOT EXISTS `bde_type` (
  `t_id`    int(11)       NOT NULL    AUTO_INCREMENT,
  `t_label` varchar(255)  NOT NULL,
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_user`;
CREATE TABLE IF NOT EXISTS `bde_user` (
  `u_id`            int(11)       NOT NULL    AUTO_INCREMENT,
  `u_name`          varchar(255)  NOT NULL,
  `u_firstname`     varchar(255)  NOT NULL,
  `u_email`         varchar(255)  NOT NULL,
  `u_phone`         varchar(10)   DEFAULT NULL,
  `u_password`      varchar(255)  NOT NULL,
  `u_is_confirmed`  tinyint(1)    NOT NULL,
  `u_fk_type_id`    int(11)       NOT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_news`;
CREATE TABLE IF NOT EXISTS `bde_news` (
  `n_id`                int(11)       NOT NULL    AUTO_INCREMENT,
  `n_label`             varchar(255)  NOT NULL,
  `n_description`       text          NOT NULL,
  `n_date`              datetime      NOT NULL,
  `n_date_publication`  datetime      NOT NULL,
  `n_image`             blob          NOT NULL,
  `n_fk_user_id`        int(11)       NOT NULL,
  PRIMARY KEY (`n_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_poll`;
CREATE TABLE IF NOT EXISTS `bde_poll` (
	`po_fk_news_id`	int(11)		NOT NULL,
    PRIMARY KEY (`po_fk_news_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_project`;
CREATE TABLE IF NOT EXISTS `bde_project` (
	`pr_fk_news_id`	int(11)		NOT NULL,
    PRIMARY KEY (`pr_fk_news_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_response`;
CREATE TABLE IF NOT EXISTS `bde_response` (
	`r_id`			int(11)			NOT NULL	AUTO_INCREMENT,
    `r_label`		varchar(255)	NOT NULL,
    `r_fk_poll_id`	int(11)			NOT NULL,
    PRIMARY KEY (`r_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_event`;
CREATE TABLE IF NOT EXISTS `bde_event` (
	`e_id`			int(11)			NOT NULL	AUTO_INCREMENT,
    `e_place`		varchar(255)	NOT NULL,
    `e_type`		varchar(255)	NOT NULL,
    `e_fk_user_id`	int(11)			NOT NULL,
    `e_fk_poll_id`	int(11)			NOT NULL,
    `e_fk_news_id`	int(11)			NOT NULL,
    PRIMARY KEY (`e_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_badge_user`;
CREATE TABLE IF NOT EXISTS `bde_badge_user` (
  `bu_fk_user_id`       int(11)   NOT NULL,
  `bu_fk_badge_id`      int(11)   NOT NULL,
  `bu_date_receipt`     datetime  NOT NULL,
  PRIMARY KEY (`bu_fk_user_id`, `bu_fk_badge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_news_user`;
CREATE TABLE IF NOT EXISTS `bde_news_user` (
  `nu_fk_user_id` int(11)       NOT NULL,
  `nu_fk_news_id` int(11)       NOT NULL,
  `nu_state`      varchar(255)  NOT NULL,
  PRIMARY KEY (`nu_fk_user_id`, `nu_fk_news_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_project_user`;
CREATE TABLE IF NOT EXISTS `bde_project_user` (
	`pu_fk_user_id`		int(11)		NOT NULL,
    `pu_fk_project_id`	int(11)		NOT NULL,
    PRIMARY KEY (`pu_fk_user_id`, `pu_fk_project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_response_user`;
CREATE TABLE IF NOT EXISTS `bde_response_user` (
	`ru_fk_user_id`		int(11)		NOT NULL,
    `ru_fk_response_id`	int(11)		NOT NULL,
    PRIMARY KEY (`ru_fk_user_id`, `ru_fk_response_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bde_event_user`;
CREATE TABLE IF NOT EXISTS `bde_event_user` (
	`eu_fk_user_id`		int(11)		NOT NULL,
    `eu_fk_event_id`	int(11)		NOT NULL,
    `eu_nb_persons`		int(11)		NOT NULL,
    `eu_participe`		tinyint(1)	NOT NULL,
    PRIMARY KEY (`eu_fk_user_id`, `eu_fk_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `bde_badge_user` ADD FOREIGN KEY (`bu_fk_user_id`) REFERENCES `bde_user`(`u_id`);
ALTER TABLE `bde_badge_user` ADD FOREIGN KEY (`bu_fk_badge_id`) REFERENCES `bde_badge`(`b_id`);
ALTER TABLE `bde_news` ADD FOREIGN KEY (`n_fk_user_id`) REFERENCES `bde_user`(`u_id`);
ALTER TABLE `bde_news_user` ADD FOREIGN KEY (`nu_fk_user_id`) REFERENCES `bde_user`(`u_id`);
ALTER TABLE `bde_news_user` ADD FOREIGN KEY (`nu_fk_news_id`) REFERENCES `bde_news`(`n_id`);
ALTER TABLE `bde_user` ADD FOREIGN KEY (`u_fk_type_id`) REFERENCES `bde_type`(`t_id`);
ALTER TABLE `bde_event` ADD FOREIGN KEY (`e_fk_news_id`) REFERENCES `bde_news`(`n_id`);
ALTER TABLE `bde_event`	ADD FOREIGN KEY (`e_fk_poll_id`) REFERENCES `bde_poll`(`po_fk_news_id`);
ALTER TABLE `bde_event` ADD FOREIGN KEY (`e_fk_user_id`) REFERENCES `bde_user`(`u_id`);
ALTER TABLE `bde_poll` ADD FOREIGN KEY (`po_fk_news_id`) REFERENCES `bde_news`(`n_id`);
ALTER TABLE `bde_project` ADD FOREIGN KEY (`pr_fk_news_id`) REFERENCES `bde_news`(`n_id`);
ALTER TABLE `bde_response` ADD FOREIGN KEY (`r_fk_poll_id`) REFERENCES `bde_poll`(`po_fk_news_id`);
ALTER TABLE `bde_event_user` ADD FOREIGN KEY (`eu_fk_event_id`) REFERENCES `bde_event`(`e_id`);
ALTER TABLE `bde_event_user` ADD FOREIGN KEY (`eu_fk_user_id`) REFERENCES `bde_user`(`u_id`);
ALTER TABLE `bde_project_user` ADD FOREIGN KEY  (`pu_fk_project_id`) REFERENCES `bde_project`(`pr_fk_news_id`);
ALTER TABLE `bde_project_user` ADD FOREIGN KEY (`pu_fk_user_id`) REFERENCES `bde_user`(`u_id`);
ALTER TABLE `bde_response_user` ADD FOREIGN KEY (`ru_fk_response_id`) REFERENCES `bde_response`(`r_id`);
ALTER TABLE `bde_response_user` ADD FOREIGN KEY (`ru_fk_user_id`) REFERENCES `bde_user`(`u_id`);

COMMIT;