CREATE TABLE build (
  build_id BIGINT(20) NOT NULL AUTO_INCREMENT,
  branch VARCHAR(100) NOT NULL,
  revision VARCHAR(100) NOT NULL,
  output_tx MEDIUMTEXT DEFAULT NULL,
  exit_status INTEGER DEFAULT NULL,
  exec_sec DECIMAL DEFAULT NULL,
  version VARCHAR(100) DEFAULT NULL,
  build_size DECIMAL DEFAULT NULL,
  deploy_dttm TIMESTAMP DEFAULT NULL,
  revert_dttm TIMESTAMP DEFAULT NULL,
  create_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  update_dttm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  delete_dttm TIMESTAMP DEFAULT NULL,
  PRIMARY KEY (build_id),
  UNIQUE (version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
