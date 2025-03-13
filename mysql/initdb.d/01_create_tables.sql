USE ${MYSQL_DATABASE};

CREATE TABLE `project` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name`	VARCHAR(50)	NOT NULL,
	`type`	INT	NULL	COMMENT '메인 프로젝트, 꼬꼬마 프로젝트 등으로 표현됨',
	`status`	INT	NOT NULL	COMMENT '완료, 진행 중, 시작 전 등으로 표현됨',
	`start_date`	DATE	NULL,
	`end_date`	DATE	NULL,
	`graphic`	VARCHAR(20)	NULL,
	`platform`	VARCHAR(40)	NULL,
	`is_finding_member`	BOOL	NOT NULL	DEFAULT false,
	`is_able_inquiry`	BOOL	NOT NULL	DEFAULT true
);

-- 회원 기본 정보
CREATE TABLE `user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `hash` VARCHAR(64) NOT NULL,
  `is_signed` BOOLEAN NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `phone_number` VARCHAR(56),
  `fcm_token` VARCHAR(255),
  `role` INT NOT NULL,
  UNIQUE INDEX `idx_hash` (`hash`)
);

-- 회원 프로필 정보
CREATE TABLE `profile` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `profile_image` VARCHAR(1023),
  `birth_date` DATE,
  `etc_message` VARCHAR(1023),
  `gogoma` VARCHAR(30),
  UNIQUE INDEX `idx_user_id` (`user_id`)
);

-- 회원 학업 정보
CREATE TABLE `academic` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `university` VARCHAR(100),
  `major` VARCHAR(256),
  `grade` INT NOT NULL,
  `student_id` VARCHAR(64),
  UNIQUE INDEX `idx_user_id` (`user_id`)
);

-- 회원 멤버십 정보
CREATE TABLE `membership` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `level` INT NOT NULL,
  `part` INT NOT NULL,
  `join_date` DATE,
  `workshop_attendance_count` INT,
  `last_cleaning_date` DATE,
  UNIQUE INDEX `idx_user_id` (`user_id`)
);

-- 회원 부재 정보
CREATE TABLE `absence` (
  `id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` BIGINT NOT NULL,
  `type` INT NOT NULL, -- 0: 재학, 1: 일반휴학, 2: 군휴학
  `reason` VARCHAR(150),
  `description` VARCHAR(1023),
  `expected_return_date` DATE,
  UNIQUE INDEX `idx_user_id` (`user_id`)
);

CREATE TABLE `user_project` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_id`	BIGINT	NOT NULL,
	`project_id`	BIGINT	NOT NULL,
	`is_pm`	BOOL	NOT NULL	DEFAULT false
);

CREATE TABLE `warning` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_id`	BIGINT	NOT NULL,
	`category`	INT	NOT NULL	COMMENT '경고, 주의, 경고 차감, 주의 차감, 경고 초기화',
	`date`	DATE	NOT NULL,
	`description`	VARCHAR(255)	NOT NULL,
	`comment`	VARCHAR(255)	NULL
);

CREATE TABLE `project_question` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`project_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`index`	BIGINT	NOT NULL	COMMENT '첫 문의사항 안에 문의사항들이 들어가는 형식이므로 첫 문의사항을 위한 인덱스를 마련함',
	`message`	VARCHAR(511)	NOT NULL,
	`date`	TIMESTAMP	NOT NULL
);

CREATE TABLE `product` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`code`	VARCHAR(511)	NOT NULL,
	`is_available`	BOOL	NOT NULL	DEFAULT false,
	`name`	VARCHAR(255)	NOT NULL,
	`category`	VARCHAR(50)	NOT NULL,
	`location`	VARCHAR(50)	NOT NULL,
	`detail_location`	VARCHAR(100)	NULL,
	`model_name`	VARCHAR(255)	NULL,
	`status`	VARCHAR(20)	NOT NULL,
	`author`	VARCHAR(30)	NULL,
	`publisher`	VARCHAR(255)	NULL
);

CREATE TABLE `seminar` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_id`	BIGINT	NOT NULL,
	`title`	VARCHAR(255)	NOT NULL,
	`url`	VARCHAR(255)	NOT NULL	COMMENT '판도라큐브 카페 게시물 주소',
	`category`	INT	NOT NULL	COMMENT '프로그래밍, 디자인, 아트 / 재학생 (수정 중)',
	`date`	DATE	NOT NULL
);

CREATE TABLE `rent_list` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`product_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`deadline`	DATE	NOT NULL,
	`rent_day`	DATE	NOT NULL,
	`return_day`	DATE	NULL	DEFAULT NULL
);

CREATE TABLE `feedback` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_id`	BIGINT	NOT NULL,
	`date`	DATE	NOT NULL,
	`title`	VARCHAR(128)	NOT NULL,
	`content`	VARCHAR(1024)	NOT NULL,
	`is_anonymous`	BOOL	NOT NULL	DEFAULT false,
	`is_answered`	BOOL	NULL	DEFAULT false
);

CREATE TABLE `membership_fee` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_id`	BIGINT	NOT NULL,
	`date`	DATE	NOT NULL	COMMENT 'YYYY-MM-01(매 달의 첫째날로 지정)',
	`category`	INT	NOT NULL	COMMENT '(기간 외, 납부 완료, 납부 지연, 미납)',
	`amount`	BIGINT	NOT NULL
);

CREATE TABLE `accounting` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`date`	DATE	NOT NULL,
	`amount`	BIGINT	NOT NULL,
	`description`	VARCHAR(255)	NULL,
	`category`	VARCHAR(64)	NOT NULL	COMMENT '내역 유형',
	`payment_method`	INT	NOT NULL	COMMENT '통장/금고'
);

CREATE TABLE `montly_payment_period` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`date`	DATE	NOT NULL	COMMENT 'YYYY-MM-01 (매 달의 첫째날로 지정)',
	`start_date`	DATE	NOT NULL,
	`end_date`	DATE	NOT NULL
);

CREATE TABLE `feedback_answer` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`feedback_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`content`	VARCHAR(1024)	NOT NULL
);

CREATE TABLE `schedule` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`type`	TINYINT	NULL,
	`title`	VARCHAR(255)	NOT NULL,
	`start_date`	DATE	NOT NULL,
	`start_time`	TIME	NULL	COMMENT '시작 시간이 정해져 있는 경우 설정',
	`end_date`	DATE	NULL	COMMENT '이틀 이상 걸리는 일정일 경우 설정',
	`end_time`	TIME	NULL	COMMENT '종료 시간이 정해져 있는 경우 설정'
);

CREATE TABLE `data_map` (
	`category`	VARCHAR(64)	NOT NULL PRIMARY KEY,
	`value`	VARCHAR(255)	NULL
);

CREATE TABLE `notification` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`category`	INT	NOT NULL	COMMENT '정기회의, 파트회의(디자인, 아트, 프로그래밍), 청소, 기타',
	`member_category`	INT	NOT NULL	COMMENT '활동 중인 회원 전체, 활동 중인 정회원, 활동 중인 수습회원, 기타 선택',
	`date`	DATE	NULL	COMMENT '값이 설정된 경우 해당 날짜에 알림 전송',
	`day`	TINYINT	NOT NULL	COMMENT '값이 설정된 경우 해당 요일마다 반복',
	`time`	TIME	NOT NULL,
	`location`	VARCHAR(128)	NOT NULL,
	`schedule`	DATETIME	NOT NULL,
	`message`	VARCHAR(512)	NULL,
	`memo`	VARCHAR(512)	NULL
);

CREATE TABLE `user_notification` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_id`	BIGINT	NOT NULL,
	`notification_id`	BIGINT	NOT NULL,
	`is_sent`	BOOL	NOT NULL	COMMENT '0: 전송되지 않음, 1: 전송됨',
	`is_read`	BOOL	NOT NULL	COMMENT '0: 읽지 않음, 1: 읽음'
);

CREATE TABLE `attendance` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`meeting_id`	BIGINT	NOT NULL,
	`date`	DATE	NOT NULL,
	`first_auth_start_time`	TIME	NULL,
	`first_auth_end_time`	TIME	NULL,
	`second_auth_start_time`	TIME	NULL,
	`second_auth_end_time`	TIME	NULL
);

CREATE TABLE `user_attendance` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_id`	BIGINT	NOT NULL,
	`attendance_id`	BIGINT	NOT NULL,
	`state`	INT	NULL	COMMENT '출석, 지각, 불참',
	`first_auth_time`	TIME	NULL,
	`second_auth_time`	TIME	NULL
);

CREATE TABLE `notification_setting` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_id`	BIGINT	NOT NULL,
	`permission`	BOOL	NOT NULL,
	`regular_meeting`	BOOL	NOT NULL,
	`part_meeting`	BOOL	NOT NULL,
	`membership_fee`	BOOL	NOT NULL,
	`cleaning`	BOOL	NOT NULL,
	`book_rental`	BOOL	NOT NULL
);

CREATE TABLE `admin` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_id`	BIGINT	NOT NULL,
	`role`	TINYINT	NOT NULL,
	`start_date`	DATE	NOT NULL,
	`end_date`	DATE	NOT NULL
);

CREATE TABLE `meeting` (
	`id`	BIGINT	NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`type`	TINYINT	NOT NULL	COMMENT '0 ~ 4 (정기, 디자인, 아트, 프로그래밍, 기타)',
	`title`	VARCHAR(255)	NOT NULL,
	`location`	VARCHAR(255)	NOT NULL,
	`day`	TINYINT	NOT NULL	COMMENT '월요일: 0 ~ 일요일: 6',
	`time`	TIME	NOT NULL
);