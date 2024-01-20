CREATE DATABASE `travel_db`;
use `travel_db`;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `tour` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` TEXT,
  `image` TEXT,
  `description` TEXT,
  `address` TEXT,
  `start_day` DATETIME,
  `end_day` DATETIME,
  `price` BIGINT,
  `status` BOOLEAN,
  PRIMARY KEY (`id`)
);

CREATE TABLE `booking` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT,
  `tour_id` BIGINT,
  `create_date` DATETIME,
  `status` BOOLEAN,
  PRIMARY KEY (`id`),
  FOREIGN KEY (tour_id) REFERENCES tour(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE `people` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` TEXT,
  PRIMARY KEY (`id`)
);

CREATE TABLE `booking_people` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `booking_id` BIGINT,
  `quantity` BIGINT,
  `people_id` BIGINT,
  PRIMARY KEY (`id`),
  FOREIGN KEY (booking_id) REFERENCES booking(id),
  FOREIGN KEY (people_id) REFERENCES people(id)
);

CREATE TABLE `role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role` varchar(255),
  PRIMARY KEY (`id`)
);

CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255),
  `password` varchar(255),
  `email` varchar(255),
  `full_name` varchar(255), 
  `address` TEXT,
  `phone_number` varchar(10),
  `status` varchar(255),
  `role_id` bigint,
  PRIMARY KEY (`id`),
  INDEX `role_id`(`role_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) 
);

CREATE TABLE `comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint ,
  `tour_id` bigint NULL DEFAULT NULL,
  `text` text,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  FOREIGN KEY (`tour_id`) REFERENCES `tour` (`id`)
);

CREATE TABLE `rate`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint,
  `tour_id` bigint,
  `number_star` int,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  FOREIGN KEY (`tour_id`) REFERENCES `tour` (`id`)
);


INSERT INTO `role` (`role`)
VALUES ('ADMIN_ROLE'), ('USER_ROLE');
  
INSERT INTO `user` VALUES 
(1,'baoanhvip','123456789','baoanh@gmail.com','Nguyễn Bảo Anh','HCM','1234567890','ACTIVATED',2),
(2,'admin','123456789','admin@gmail.com','Nguyễn Luân admin','HCM','0998900129','ACTIVATED',1),
(3,'haicon','123456789','haicon@gmail.com','Bá Hải','HCM','0968900789','ACTIVATED',2),
(4,'thuyVi','123456789','vivertor@gmail.com','Hoàng Thúy Vi','HCM','0968900628','ACTIVATED',2),
(5,'kaioken','123456789','akio@gmail.com','Nguyễn Thị Trúc','HCM','0968900782','ACTIVATED',2),
(6,'quuyen','123456789','quenroi@gmail.com','Nguyễn Thị Quyên','HCM','0968900621','ACTIVATED',2),
(7,'hatien','123456789','hatran@gmail.com','Trần Văn Hà','Hà Nội','0968900021','ACTIVATED',2);

INSERT INTO `people` VALUES 
('1', 'adult'),
('2', 'children');

INSERT INTO `tour` VALUES 
(2,'Vũng Tàu Beach','vung-tau.png','Chuyến du lịch tham quan Vũng Tàu.\r\nChuyến du lịch tham quan Vũng Tàu.\r\nChuyến du lịch tham quan Vũng Tàu.\r\nChuyến du lịch tham quan Vũng Tàu.\r\nChuyến du lịch tham quan Vũng Tàu.\r\nChuyến du lịch tham quan Vũng Tàu.\r\n','HCM','2024-01-01 00:00:00','2024-01-05 00:00:00',650000,1),
(3,'Nha Trang Beach','nha-trang.png','Chuyến du lịch tham quan Nha Trang 2 ngày 1 đêm.','Nha Trang City','2024-08-10 00:00:00','2024-08-15 00:00:00',1200000,1),
(4,'Đà Lạt','da-lat.png','Hành trình khám phá Đà Lạt 3 ngày 2 đêm\r\nMình đã từng không muốn đến Đà Lạt vì nhiều lý do: vì nghe kể lại, nghe người ta nói, nghe các bài hát về Đà Lạt: 1 Đà Lạt buồn đến nao lòng! \r\n \r\n\r\nVà 1 ngày khi được xem review từ 1 người bạn, xem review về đồ ăn, thứ mình yêu thích nhất, và cho đến khi cuối cùng khi được chính thức đặt chân đến thành phố tuyệt diệu này, đúng là trăm nghe không bằng 1 thấy, và mình đã chứng minh được: Đà Lạt không buồn như người ta nghĩ! \r\n\r\nVề vé máy bay và phòng: Mình book combo của Thu Hằng Sđt 0911766338 – Công ty du lịch Elite Tour chỉ với giá 1.990.000vnđ/người đã bao gồm vé máy bay khứ hồi và khách sạn 3* nhé. Bạn ấy Tư vấn nhiệt tình chi tiết, giá rẻ hơn các chỗ khác nên các bạn có nhu cầu thì liên hệ bạn ấy nha. À mình đi từ Hà Nội nha nếu bạn mà đi từ Hồ Chí Minh thì chắc chắn sẽ rẻ hơn nha.','TP Đà Lạt','2024-01-01 00:00:00','2024-01-10 00:00:00',750000,1),
(6,'Phú quốc','phu-quoc.png','Review Phú Quốc có gì? Được mệnh danh là thiên đường biển xinh đẹp nhất Việt Nam, đảo Phú Quốc sở hữu những nét đẹp nên thơ và lãng mạn hiếm nơi nào có. Dù là tới nghỉ dưỡng hay du lịch khám phá, nơi đây cũng sẽ hứa hẹn khiến bạn hài lòng khi ghé thăm. Bạn đã lên lịch trình cụ thể cho chuyến du lịch Phú Quốc này chưa? Hãy cùng khám phá hòn đảo xinh đẹp này qua những review chi tiết dưới đây nhé!\r\n\r\n1. Giới thiệu về Phú Quốc - đảo ngọc xinh đẹp hút hồn mọi du khách\r\nPhú Quốc là một hòn đảo nằm trong vịnh Thái Lan thuộc tỉnh Kiên Giang của nước ta. Đây là hòn đảo lớn nhất của Việt Nam ở phía Tây Nam và đảo ngọc này cũng là hòn đảo lớn nhất trong hệ thống quần thể các đảo lớn nhỏ tại đây. Nhờ lợi thế khí hậu hài hòa cùng khung cảnh thiên nhiên đẹp tựa bức tranh, hằng năm Phú Quốc thu hút hàng triệu lượt khách ghé thăm và khám phá. ','Phú Quốc','2024-01-01 00:00:00','2024-01-10 00:00:00',500000,1),
(7,'Phú Yên','phu-yen.png','Xứ “hoa vàng cỏ xanh” là vùng đất được ưu đãi nhiều thắng cảnh thiên nhiên đẹp. Tuy không lộng lẫy, hào nhoáng, xa hoa như nhiều địa danh khác, nhưng chính sự mộc mạc và bình dị toát lên từ khung cảnh nơi đây đã khiến chuyến du lịch Phú Yên trở thành sự lựa chọn ưu tiên của bao du khách gần xa. Hãy xem ngay chia sẻ của Vietnam Booking về các địa điểm du lịch Phú Yên hot nhất đang được dân mê xê dịch săn lùng nhé.\r\n\r\n1. Gành Đá Dĩa\r\nGành Đá Dĩa là địa điểm nổi tiếng ở Phú Yên độc đáo hiếm có mà bạn chắc chắn phải đến. Gành đá ở đây được tạo nên từ những dòng nham thạch nóng hổi phun trào từ hàng nghìn năm trước, gặp dòng nước biển lạnh đông lại thành những phiến đá đen tuyền nổi bật. \r\n\r\nNhững tảng đá đen hình trụ này trải qua nhiều năm phong hóa trở nên nhẵn nhụi như được gọt dũa. Nhìn từ xa, gành đá như một tổ ong khổng lồ nằm sát bên bờ biển. Tuyệt tác thiên nhiên này không hề có sự tham gia của con người. Đến Gành Đá Dĩa, bạn đừng bỏ lỡ cơ hội ngắm nhìn bình minh trên biển để thấy sắc vàng óng ánh của những phiến đá đen bí ẩn nhé.','Phú Yên','2024-01-01 00:00:00','2024-01-05 00:00:00',800000,1),
(8,'Bến Tre','ben-tre.png','Chuyến du lịch tham quan bến tre.','Bến Tre','2023-10-01 00:00:00','2023-10-01 00:00:00',350000,1),
(9,'Long An','long-an.png','Chuyến du lịch tham quan Long An thú vị.','HCM','2023-10-02 00:00:00','2023-10-02 00:00:00',150000,1);

INSERT INTO `booking` VALUES 
(1,1,3,'2023-10-01 12:31:30',1),
(2,1,4,'2023-10-01 12:31:36',1),
(3,3,7,'2023-10-01 12:32:15',1),
(4,3,6,'2023-10-01 12:32:22',1),
(5,4,2,'2023-10-01 12:32:39',1),
(6,4,4,'2023-10-01 12:32:45',1),
(7,5,3,'2023-10-01 12:33:02',1),
(8,5,7,'2023-10-01 12:33:07',1);

INSERT INTO `booking_people` VALUES 
(1,1,2,1),
(2,1,3,2),
(3,2,4,1),
(4,2,1,2),
(5,3,2,1),
(6,3,3,2),
(7,4,5,1),
(8,4,2,2),
(9,5,2,1),
(10,5,2,2),
(11,6,3,1),
(12,6,1,2),
(13,7,3,1),
(14,7,1,2),
(15,8,2,1),
(16,8,1,2);

