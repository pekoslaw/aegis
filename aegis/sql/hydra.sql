-- hydra_type: the structure of each type of work to be performed by hydra.
CREATE TABLE hydra_type (
  hydra_type_id int NOT NULL AUTO_INCREMENT,
  hydra_type_name varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  hydra_type_desc text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  priority_ndx tinyint NOT NULL DEFAULT '0' COMMENT 'Lower number = higher priority',
  status varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,            -- canceled, running, scheduled, disabled, ugc/on-demand/trigger etc?
  last_run_dttm datetime DEFAULT NULL,
  scheduled_dttm datetime DEFAULT NULL,
  next_run_sql varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,     -- date_add(now(), interval 6 hour). NOT REQUIRED.
  run_cnt int NOT NULL DEFAULT '0',
  create_dttm datetime NOT NULL,
  update_dttm timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  delete_dttm datetime DEFAULT NULL,
  PRIMARY KEY (hydra_type_name),
  KEY hydra_type_id (hydra_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- hydra_queue: putting the hydra_type and its work-specific data onto the queue for processing
CREATE TABLE hydra_queue (
  hydra_queue_id int NOT NULL AUTO_INCREMENT,
  hydra_type_id bigint NOT NULL,
  priority_ndx tinyint NOT NULL DEFAULT '0',           -- Lower number = higher priority
  work_data mediumtext COLLATE utf8mb4_unicode_ci,     -- JSON string describing the work-specific data
  start_dttm datetime NOT NULL,                        -- When the work is scheduled to be done
  claimed_dttm datetime DEFAULT NULL,
  finish_dttm datetime DEFAULT NULL,
  try_cnt int NOT NULL DEFAULT '0',
  error_cnt int NOT NULL DEFAULT '0',
  create_dttm datetime NOT NULL,
  update_dttm datetime NOT NULL,
  delete_dttm datetime DEFAULT NULL,
  PRIMARY KEY (work_dttm, priority_ind, hydra_queue_id),
  KEY hydra_queue_id (hydra_queue_id),
  KEY hydra_type_id (hydra_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- hydra_job: recording the progress of each job after it's finished being worked on
CREATE TABLE hydra_job (
  hydra_job_id int NOT NULL AUTO_INCREMENT,
  hydra_type_id int NOT NULL,
  status varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  start_dttm datetime NOT NULL,
  finish_dttm datetime DEFAULT NULL,
  run_time int NOT NULL DEFAULT '0',
  row_cnt int NOT NULL DEFAULT '0',
  last_row_id int DEFAULT NULL,
  create_dttm datetime NOT NULL,
  update_dttm timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  delete_dttm datetime DEFAULT NULL,
  PRIMARY KEY (hydra_job_id),
  KEY hydra_type (hydra_type_id, start_dttm),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;