/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50515
Source Host           : localhost:3306
Source Database       : ppmall_study

Target Server Type    : MYSQL
Target Server Version : 50515
File Encoding         : 65001

Date: 2020-05-19 15:08:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `oms_cart_item`
-- ----------------------------
DROP TABLE IF EXISTS `oms_cart_item`;
CREATE TABLE `oms_cart_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `product_sku_id` bigint(20) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL COMMENT '购买数量',
  `price` decimal(10,2) DEFAULT NULL COMMENT '添加到购物车的价格',
  `sp1` varchar(200) DEFAULT NULL COMMENT '销售属性1',
  `sp2` varchar(200) DEFAULT NULL COMMENT '销售属性2',
  `sp3` varchar(200) DEFAULT NULL COMMENT '销售属性3',
  `product_pic` varchar(1000) DEFAULT NULL COMMENT '商品主图',
  `product_name` varchar(500) DEFAULT NULL COMMENT '商品名称',
  `product_sub_title` varchar(500) DEFAULT NULL COMMENT '商品副标题（卖点）',
  `product_sku_code` varchar(200) DEFAULT NULL COMMENT '商品sku条码',
  `member_nickname` varchar(500) DEFAULT NULL COMMENT '会员昵称',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_date` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_status` int(1) DEFAULT '0' COMMENT '是否删除',
  `product_category_id` bigint(20) DEFAULT NULL COMMENT '商品分类',
  `product_brand` varchar(200) DEFAULT NULL,
  `product_sn` varchar(200) DEFAULT NULL,
  `product_attr` varchar(500) DEFAULT NULL COMMENT '商品销售属性:[{"key":"颜色","value":"颜色"},{"key":"容量","value":"4G"}]',
  `is_checked` varchar(10) DEFAULT '1' COMMENT '订单是否被选中',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='购物车表';

-- ----------------------------
-- Records of oms_cart_item
-- ----------------------------
INSERT INTO `oms_cart_item` VALUES ('21', '70', '109', '1', '2', '5499.00', null, null, null, 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAKn4CAARDAkbMoEI429.jpg', 'Apple iPhone 11 (A2223) 64GB 白色 移动联通电信4G手机 双卡双待', null, '201806070026004', 'test423', '2020-04-23 22:43:58', '2020-04-23 22:43:58', '0', '61', '', null, '', '0');
INSERT INTO `oms_cart_item` VALUES ('22', '70', '112', '1', '1', '5499.00', null, null, null, 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAKn4CAARDAkbMoEI429.jpg', 'Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待', null, '201806070026004', 'test423', '2020-04-23 23:22:40', '2020-04-23 23:22:40', '0', '61', '', null, '', '0');
INSERT INTO `oms_cart_item` VALUES ('23', '69', '107', '1', '4', '1299.00', null, null, null, 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', null, '202004290069001', 'test423', '2020-04-29 23:14:21', '2020-04-29 23:14:21', '0', '61', '', null, '', '1');

-- ----------------------------
-- Table structure for `oms_company_address`
-- ----------------------------
DROP TABLE IF EXISTS `oms_company_address`;
CREATE TABLE `oms_company_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address_name` varchar(200) DEFAULT NULL COMMENT '地址名称',
  `send_status` int(1) DEFAULT NULL COMMENT '默认发货地址：0->否；1->是',
  `receive_status` int(1) DEFAULT NULL COMMENT '是否默认收货地址：0->否；1->是',
  `name` varchar(64) DEFAULT NULL COMMENT '收发货人姓名',
  `phone` varchar(64) DEFAULT NULL COMMENT '收货人电话',
  `province` varchar(64) DEFAULT NULL COMMENT '省/直辖市',
  `city` varchar(64) DEFAULT NULL COMMENT '市',
  `region` varchar(64) DEFAULT NULL COMMENT '区',
  `detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='公司收发货地址表';

-- ----------------------------
-- Records of oms_company_address
-- ----------------------------
INSERT INTO `oms_company_address` VALUES ('1', '深圳发货点', '1', '1', '大梨', '18000000000', '广东省', '深圳市', '南山区', '科兴科学园');
INSERT INTO `oms_company_address` VALUES ('2', '北京发货点', '0', '0', '大梨', '18000000000', '北京市', null, '南山区', '科兴科学园');
INSERT INTO `oms_company_address` VALUES ('3', '南京发货点', '0', '0', '大梨', '18000000000', '江苏省', '南京市', '南山区', '科兴科学园');

-- ----------------------------
-- Table structure for `oms_order`
-- ----------------------------
DROP TABLE IF EXISTS `oms_order`;
CREATE TABLE `oms_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `member_id` bigint(20) NOT NULL COMMENT '用户id',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '优惠券id',
  `order_sn` varchar(64) DEFAULT NULL COMMENT '订单编号',
  `create_time` datetime DEFAULT NULL COMMENT '提交时间',
  `member_username` varchar(64) DEFAULT NULL COMMENT '用户帐号',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '订单总金额',
  `pay_amount` decimal(10,2) DEFAULT NULL COMMENT '应付金额（实际支付金额）',
  `freight_amount` decimal(10,2) DEFAULT NULL COMMENT '运费金额',
  `promotion_amount` decimal(10,2) DEFAULT NULL COMMENT '促销优化金额（促销价、满减、阶梯价）',
  `integration_amount` decimal(10,2) DEFAULT NULL COMMENT '积分抵扣金额',
  `coupon_amount` decimal(10,2) DEFAULT NULL COMMENT '优惠券抵扣金额',
  `discount_amount` decimal(10,2) DEFAULT NULL COMMENT '管理员后台调整订单使用的折扣金额',
  `pay_type` int(1) DEFAULT '0' COMMENT '支付方式：0->未支付；1->支付宝；2->微信',
  `source_type` int(1) DEFAULT '0' COMMENT '订单来源：0->PC订单；1->app订单',
  `status` int(1) DEFAULT '0' COMMENT '订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单',
  `order_type` int(1) DEFAULT '0' COMMENT '订单类型：0->正常订单；1->秒杀订单',
  `delivery_company` varchar(64) DEFAULT '圆通速递' COMMENT '物流公司(配送方式)',
  `delivery_sn` varchar(64) DEFAULT NULL COMMENT '物流单号',
  `auto_confirm_day` int(11) DEFAULT NULL COMMENT '自动确认时间（天）',
  `integration` int(11) DEFAULT '0' COMMENT '可以获得的积分',
  `growth` int(11) DEFAULT '0' COMMENT '可以活动的成长值',
  `promotion_info` varchar(100) DEFAULT NULL COMMENT '活动信息',
  `bill_type` int(1) DEFAULT '0' COMMENT '发票类型：0->不开发票；1->电子发票；2->纸质发票',
  `bill_header` varchar(200) DEFAULT NULL COMMENT '发票抬头',
  `bill_content` varchar(200) DEFAULT NULL COMMENT '发票内容',
  `bill_receiver_phone` varchar(32) DEFAULT NULL COMMENT '收票人电话',
  `bill_receiver_email` varchar(64) DEFAULT NULL COMMENT '收票人邮箱',
  `receiver_name` varchar(100) NOT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(32) NOT NULL COMMENT '收货人电话',
  `receiver_post_code` varchar(32) DEFAULT NULL COMMENT '收货人邮编',
  `receiver_province` varchar(32) DEFAULT NULL COMMENT '省份/直辖市',
  `receiver_city` varchar(32) DEFAULT NULL COMMENT '城市',
  `receiver_region` varchar(32) DEFAULT NULL COMMENT '区',
  `receiver_detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `note` varchar(500) DEFAULT '无' COMMENT '订单备注',
  `confirm_status` int(1) DEFAULT '0' COMMENT '确认收货状态：0->未确认；1->已确认',
  `delete_status` int(1) NOT NULL DEFAULT '0' COMMENT '删除状态：0->未删除；1->已删除',
  `use_integration` int(11) DEFAULT '0' COMMENT '下单时使用的积分',
  `payment_time` datetime DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime DEFAULT NULL COMMENT '确认收货时间',
  `comment_time` datetime DEFAULT NULL COMMENT '评价时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of oms_order
-- ----------------------------
INSERT INTO `oms_order` VALUES ('21', '1', '2', '201809140101000002', '2018-09-14 16:16:16', 'test', '18732.00', '16377.75', '0.00', '2344.25', '0.00', '10.00', '0.00', '2', '1', '1', '0', null, null, '15', '18682', '18682', '单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠', null, null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', null, '0', '0', null, null, null, null, null, null);
INSERT INTO `oms_order` VALUES ('22', '1', '2', '201809150101000005', '2018-09-15 12:24:27', 'test', '18732.00', '16377.75', '0.00', '2344.25', '0.00', '10.00', '0.00', '0', '1', '1', '0', '顺丰快递', '201707196398345', '15', '0', '0', '单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠', null, null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', null, '0', '0', null, null, '2018-10-12 14:01:28', null, null, null);
INSERT INTO `oms_order` VALUES ('23', '1', '2', '201809150102000006', '2018-09-15 14:24:29', 'test', '18732.00', '16377.75', '0.00', '2344.25', '0.00', '10.00', '0.00', '1', '1', '1', '0', '顺丰快递', 'xxx', '15', '0', '0', '单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠', null, null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', null, '0', '0', '1000', null, '2018-10-16 14:41:28', null, null, null);
INSERT INTO `oms_order` VALUES ('24', '1', '2', '201809130101000005', '2018-09-13 16:57:40', 'test', '18732.00', '16377.75', '0.00', '2344.25', '0.00', '10.00', '0.00', '2', '1', '1', '0', null, null, '15', '18682', '18682', '单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠', null, null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', null, '0', '0', null, null, null, null, null, null);
INSERT INTO `oms_order` VALUES ('25', '1', '2', '201809130102000006', '2018-09-13 17:03:00', 'test', '18732.00', '16377.75', '10.00', '2344.25', '0.00', '10.00', '5.00', '1', '1', '1', '0', null, null, '15', '18682', '18682', '单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠', null, null, null, null, null, '大梨22', '18033441849', '518000', '北京市', '北京城区', '东城区', '东城街道', 'xxx', '0', '0', null, null, null, null, null, '2018-10-30 15:08:31');
INSERT INTO `oms_order` VALUES ('26', '1', '2', '201809140101000003', '2018-09-14 16:16:16', 'test', '18732.00', '16377.75', '0.00', '2344.25', '0.00', '10.00', '0.00', '2', '1', '1', '0', null, null, '15', '18682', '18682', '单品促销,打折优惠：满3件，打7.50折,满减优惠：满1000.00元，减120.00元,满减优惠：满1000.00元，减120.00元,无优惠', null, null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', null, '0', '1', null, null, null, null, null, null);
INSERT INTO `oms_order` VALUES ('64', '1', '2', '202004291302071588136527786', '2020-04-29 13:02:07', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 13:02:07', null, null);
INSERT INTO `oms_order` VALUES ('65', '1', '2', '202004291302231588136543102', '2020-04-29 13:02:23', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 13:02:23', null, null);
INSERT INTO `oms_order` VALUES ('66', '1', '2', '202004291305351588136735920', '2020-04-29 13:05:35', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 13:05:35', null, null);
INSERT INTO `oms_order` VALUES ('67', '1', '2', '202004291309211588136961360', '2020-04-29 13:09:21', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 13:09:21', null, null);
INSERT INTO `oms_order` VALUES ('68', '1', '2', '202004291413131588140793481', '2020-04-29 14:13:13', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 14:13:13', null, null);
INSERT INTO `oms_order` VALUES ('69', '1', '2', '202004291419411588141181457', '2020-04-29 14:19:41', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 14:19:41', null, null);
INSERT INTO `oms_order` VALUES ('70', '1', '2', '202004291503451588143825649', '2020-04-29 15:03:45', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 15:03:45', null, null);
INSERT INTO `oms_order` VALUES ('71', '1', '2', '202004291510271588144227433', '2020-04-29 15:10:27', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 15:10:27', null, null);
INSERT INTO `oms_order` VALUES ('72', '1', '2', '202004291515561588144556144', '2020-04-29 15:15:56', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 15:15:56', null, null);
INSERT INTO `oms_order` VALUES ('73', '1', '2', '202004291540171588146017778', '2020-04-29 15:40:17', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 15:40:17', null, null);
INSERT INTO `oms_order` VALUES ('74', '1', '2', '202004291546291588146389259', '2020-04-29 15:46:29', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 15:46:29', null, null);
INSERT INTO `oms_order` VALUES ('75', '1', '2', '202004291552491588146769974', '2020-04-29 15:52:49', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 15:52:49', null, null);
INSERT INTO `oms_order` VALUES ('76', '1', '2', '202004291614011588148041649', '2020-04-29 16:14:01', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 16:14:01', null, null);
INSERT INTO `oms_order` VALUES ('77', '1', '2', '202004291621421588148502993', '2020-04-29 16:21:43', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 16:21:43', null, null);
INSERT INTO `oms_order` VALUES ('78', '1', '2', '202004291624061588148646791', '2020-04-29 16:24:06', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 16:24:06', null, null);
INSERT INTO `oms_order` VALUES ('79', '1', '2', '202004291626231588148783651', '2020-04-29 16:26:23', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 16:26:23', null, null);
INSERT INTO `oms_order` VALUES ('80', '1', '2', '202004292203401588169020781', '2020-04-29 22:03:40', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 22:03:40', null, null);
INSERT INTO `oms_order` VALUES ('81', '1', '2', '202004292225191588170319050', '2020-04-29 22:25:19', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '0', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 22:25:19', null, null);
INSERT INTO `oms_order` VALUES ('82', '1', '2', '202004292228121588170492888', '2020-04-29 22:28:12', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 22:28:12', null, null);
INSERT INTO `oms_order` VALUES ('83', '1', '2', '202004292233511588170831331', '2020-04-29 22:33:51', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 22:33:51', null, null);
INSERT INTO `oms_order` VALUES ('84', '1', '2', '202004292242401588171360352', '2020-04-29 22:42:40', '小卢', '2598.00', '2598.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 22:42:40', null, null);
INSERT INTO `oms_order` VALUES ('85', '1', '2', '202004292314461588173286191', '2020-04-29 23:14:46', '小卢', '5196.00', '5196.00', null, null, null, null, null, '0', '0', '1', '0', '圆通速递', null, '7', '0', '0', null, '0', null, null, null, null, '大梨', '18033441849', '518000', '广东省', '深圳市', '福田区', '东晓街道', '快点发货', '0', '0', '0', null, null, '2020-05-07 23:14:46', null, null);

-- ----------------------------
-- Table structure for `oms_order_item`
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_item`;
CREATE TABLE `oms_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `order_sn` varchar(64) DEFAULT NULL COMMENT '订单编号',
  `product_id` bigint(20) DEFAULT NULL,
  `product_pic` varchar(500) DEFAULT NULL,
  `product_name` varchar(200) DEFAULT NULL,
  `product_brand` varchar(200) DEFAULT NULL,
  `product_sn` varchar(64) DEFAULT NULL,
  `product_price` decimal(10,2) DEFAULT NULL COMMENT '销售价格',
  `product_quantity` int(11) DEFAULT NULL COMMENT '购买数量',
  `product_sku_id` bigint(20) DEFAULT NULL COMMENT '商品sku编号',
  `product_sku_code` varchar(50) DEFAULT NULL COMMENT '商品sku条码',
  `product_category_id` bigint(20) DEFAULT NULL COMMENT '商品分类id',
  `sp1` varchar(100) DEFAULT NULL COMMENT '商品的销售属性',
  `sp2` varchar(100) DEFAULT NULL,
  `sp3` varchar(100) DEFAULT NULL,
  `promotion_name` varchar(200) DEFAULT NULL COMMENT '商品促销名称',
  `promotion_amount` decimal(10,2) DEFAULT NULL COMMENT '商品促销分解金额',
  `coupon_amount` decimal(10,2) DEFAULT NULL COMMENT '优惠券优惠分解金额',
  `integration_amount` decimal(10,2) DEFAULT NULL COMMENT '积分优惠分解金额',
  `real_amount` decimal(10,2) DEFAULT NULL COMMENT '该商品经过优惠后的分解金额',
  `gift_integration` int(11) DEFAULT '0',
  `gift_growth` int(11) DEFAULT '0',
  `product_attr` varchar(500) DEFAULT NULL COMMENT '商品销售属性:[{"key":"颜色","value":"颜色"},{"key":"容量","value":"4G"}]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='订单中所包含的商品';

-- ----------------------------
-- Records of oms_order_item
-- ----------------------------
INSERT INTO `oms_order_item` VALUES ('35', '14', '201809130101000001', '29', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg', 'Apple iPhone 8 Plus', '苹果', '7437799', '5499.00', '1', '106', '201808270029001', '19', null, null, null, '无优惠', '0.00', '2.94', '0.00', '5496.06', '5499', '5499', '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]');
INSERT INTO `oms_order_item` VALUES ('36', '15', '201809130101000001', '26', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20', '华为', '6946605', '3788.00', '1', '90', '201806070026001', '19', null, null, null, '单品促销', '200.00', '2.02', '0.00', '3585.98', '3788', '3788', '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]');
INSERT INTO `oms_order_item` VALUES ('37', '15', '201809130101000001', '27', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '7437788', '2699.00', '3', '98', '201808270027001', '19', null, null, null, '打折优惠：满3件，打7.50折', '674.75', '1.44', '0.00', '2022.81', '2699', '2699', '[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]');
INSERT INTO `oms_order_item` VALUES ('38', '15', '201809130101000001', '28', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '7437789', '649.00', '1', '102', '201808270028001', '19', null, null, null, '满减优惠：满1000.00元，减120.00元', '57.60', '0.35', '0.00', '591.05', '649', '649', '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]');
INSERT INTO `oms_order_item` VALUES ('39', '15', '201809130101000001', '28', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '7437789', '699.00', '1', '103', '201808270028001', '19', null, null, null, '满减优惠：满1000.00元，减120.00元', '62.40', '0.37', '0.00', '636.23', '649', '649', '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]');
INSERT INTO `oms_order_item` VALUES ('40', '15', '201809130101000001', '29', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg', 'Apple iPhone 8 Plus', '苹果', '7437799', '5499.00', '1', '106', '201808270029001', '19', null, null, null, '无优惠', '0.00', '2.94', '0.00', '5496.06', '5499', '5499', '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]');
INSERT INTO `oms_order_item` VALUES ('41', '16', '201809140101000001', '26', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20', '华为', '6946605', '3788.00', '1', '90', '201806070026001', '19', null, null, null, '单品促销', '200.00', '2.02', '0.00', '3585.98', '3788', '3788', '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]');
INSERT INTO `oms_order_item` VALUES ('42', '16', '201809140101000001', '27', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '7437788', '2699.00', '3', '98', '201808270027001', '19', null, null, null, '打折优惠：满3件，打7.50折', '674.75', '1.44', '0.00', '2022.81', '2699', '2699', '[{\"key\":\"颜色\",\"value\":\"黑色\"},{\"key\":\"容量\",\"value\":\"32G\"}]');
INSERT INTO `oms_order_item` VALUES ('43', '16', '201809140101000001', '28', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '7437789', '649.00', '1', '102', '201808270028001', '19', null, null, null, '满减优惠：满1000.00元，减120.00元', '57.60', '0.35', '0.00', '591.05', '649', '649', '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"16G\"}]');
INSERT INTO `oms_order_item` VALUES ('44', '16', '201809140101000001', '28', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '7437789', '699.00', '1', '103', '201808270028001', '19', null, null, null, '满减优惠：满1000.00元，减120.00元', '62.40', '0.37', '0.00', '636.23', '649', '649', '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]');
INSERT INTO `oms_order_item` VALUES ('45', '16', '201809140101000001', '29', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg', null, '苹果', '7437799', '5499.00', '1', '106', '201808270029001', '19', null, null, null, '无优惠', '0.00', '2.94', '0.00', '5496.06', '5499', '5499', '[{\"key\":\"颜色\",\"value\":\"金色\"},{\"key\":\"容量\",\"value\":\"32G\"}]');
INSERT INTO `oms_order_item` VALUES ('83', '64', '202004291302071588136527786', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('84', '65', '202004291302231588136543102', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('85', '66', '202004291305351588136735920', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('86', '67', '202004291309211588136961360', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('87', '68', '202004291413131588140793481', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('88', '69', '202004291419411588141181457', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('89', '70', '202004291503451588143825649', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('90', '71', '202004291510271588144227433', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('91', '72', '202004291515561588144556144', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('92', '73', '202004291540171588146017778', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('93', '74', '202004291546291588146389259', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('94', '75', '202004291552491588146769974', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('95', '76', '202004291614011588148041649', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('96', '77', '202004291621421588148502993', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('97', '78', '202004291624061588148646791', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('98', '79', '202004291626231588148783651', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('99', '80', '202004292203401588169020781', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('100', '81', '202004292225191588170319050', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('101', '82', '202004292228121588170492888', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('102', '83', '202004292233511588170831331', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('103', '84', '202004292242401588171360352', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '2', '107', '1111111111', '61', null, null, null, null, null, null, null, '2598.00', '0', '0', '');
INSERT INTO `oms_order_item` VALUES ('104', '85', '202004292314461588173286191', '69', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '', null, '1299.00', '4', '107', '202004290069001', '61', null, null, null, null, null, null, null, '5196.00', '0', '0', '');

-- ----------------------------
-- Table structure for `payment_info`
-- ----------------------------
DROP TABLE IF EXISTS `payment_info`;
CREATE TABLE `payment_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `out_trade_no` varchar(255) DEFAULT NULL COMMENT '对外业务编号',
  `order_id` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `alipay_trade_no` varchar(50) DEFAULT NULL COMMENT '支付宝交易编号',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '支付金额',
  `subject` varchar(200) DEFAULT NULL COMMENT '交易内容',
  `payment_status` varchar(20) DEFAULT NULL COMMENT '支付状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `callback_content` varchar(4000) DEFAULT NULL COMMENT '回调信息',
  `callback_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8 COMMENT='支付信息表';

-- ----------------------------
-- Records of payment_info
-- ----------------------------
INSERT INTO `payment_info` VALUES ('267', '202004282127101588080430128', '51', '2020042822001465451404130688', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-28 21:27:15', 'charset=utf-8&out_trade_no=202004282127101588080430128&method=alipay.trade.page.pay.return&total_amount=0.01&sign=AJL76AbOo4CbZ6w66vF22VvKMyuZP%2BM4OuO3hyOdOJQM%2BR%2F2iRd%2B%2Fe7%2FCZxLFYYnyP8kPWbSIwlK4RApYR6avAXpCujVcv6EDPTdBuUHmvzHDZJz9z9NdbY7Tu2nZOcP2yJU8EHLcn30Na2%2BjV3KxnJeMNd2wOA8S8hGJXE3kvSYLk6oBkA5GQwzpM%2Bmx2c0H2XiVBKQmIa16f4io0vEAOZsHQoZArBdY%2BoxrjuAv9NFssbnF1NME%2BOOVMrhIWVlwgm3zDsojQMqlQULpwlup8hsISgVC%2Fx3qoMMnJHbA87A2MVBSsil4qmqxtObCHxJqpadiIEQ4xCwJCLNCl9wvA%3D%3D&trade_no=2020042822001465451404130688&auth_app_id=2018020102122556&version=1.0&app_id=2018020102122556&sign_type=RSA2&seller_id=2088921750292524&timestamp=2020-04-28+21%3A28%3A14', '2020-04-28 21:28:17');
INSERT INTO `payment_info` VALUES ('268', '202004282322021588087322220', '52', '2020042822001465451404108087', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-28 23:22:07', 'charset=utf-8&out_trade_no=202004282322021588087322220&method=alipay.trade.page.pay.return&total_amount=0.01&sign=d2iQTS0gBzkDnfy1vr%2Bdk4UZ38yGUVaqc%2BUX0AOGEJ81DDsgTXbCZxZPVa74W%2BJ3NZe2GGcDJt5yA1a5kPfylkVFhj98tTz64rh2ne9wnneMsX4oM3OXGkBXa3cxkPkLxuhuwkmoKvuedJEMXPr4Bp%2BSPQIP4fuMDs0Un6o0MERnXYRKdNp1mESiKjSZbmVKjUcL4Dfbn%2BN7trHIRTXrrBOwHm1OMRGArFpaJDoFnPHqH3u6isfJ4dvUYy2oEh4eXu3gZMUXUcLPwfYmbPIr5PeapcQCrWdaeYGmoIkroYEH70U1zOvVbAQp3XD5P287CbdOipFYPnQZebXH4xax5w%3D%3D&trade_no=2020042822001465451404108087&auth_app_id=2018020102122556&version=1.0&app_id=2018020102122556&sign_type=RSA2&seller_id=2088921750292524&timestamp=2020-04-28+23%3A22%3A26', '2020-04-28 23:23:45');
INSERT INTO `payment_info` VALUES ('269', '202004282326511588087611409', '53', '2020042822001465451403821646', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-28 23:26:56', 'charset=utf-8&out_trade_no=202004282326511588087611409&method=alipay.trade.page.pay.return&total_amount=0.01&sign=UVFrh9mvEtPWGqcPbtzYa3L5ExJzb%2FPcpMYJtHqrNQEgQIQvO5e8AbZ963ZaSHNfofbVnWRaULMefpAp5JFFNZDFhuz6n87%2FKE9t7Ds48rMGh%2F%2FKPh6%2FmRQEk9VbsniKNpw99YJOHdv0Vx7oLh7Sksl0b7efSGShcWnpnAbPEGWGp7Md56%2FVg%2F7JKRYWib7Kv351kVzZIOV1JJSa5FSLFhV%2BqSDY6Sbbl4EmHU%2BTRSH7R45VE%2FcX1Q7ebcaNu0lh%2BhWYHDco4ZBXXs1QNA1nc19lYWLL5N5XXny6Z1pdQuntwhY6QAutXc5u%2FDmr%2BJIF1SPB39xpyzRlfZoL2XCPQw%3D%3D&trade_no=2020042822001465451403821646&auth_app_id=2018020102122556&version=1.0&app_id=2018020102122556&sign_type=RSA2&seller_id=2088921750292524&timestamp=2020-04-28+23%3A27%3A18', '2020-04-28 23:28:37');
INSERT INTO `payment_info` VALUES ('270', '202004282342151588088535231', '54', '2020042822001465451404110035', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-28 23:42:23', 'charset=utf-8&out_trade_no=202004282342151588088535231&method=alipay.trade.page.pay.return&total_amount=0.01&sign=RlwB188x3aSrpb%2FMdkpQT3xMbtQk1oLClN2wemChbKh4BvDR%2FeZC7VNwUpjfIp2%2FFoRJValiUAjUmvPYHHnD%2BakzpFVvXR3DjBrO6mK0Z%2FxxjcamBEjj%2FUspKyoIln0rw%2BCPGfOWGAdD3AK32r08tjQqDWhxcCJk%2FztMZL3uWCJlE3iZsSeztA4IpO4Y2RE%2FZhcnAycvB8ZzCTAhzrHzvhOfesxwx1k4VuNB2OO25sS%2BYj86TtyrRbOEDdEHaeNcaGTAcPErbFzkeyhN8J3QhlIot7eF9fsEy9bQ1DHpGspJaEAJnhIdUbpXpcA3C9%2FuaOOWd0lRJEO80evIzaSxpQ%3D%3D&trade_no=2020042822001465451404110035&auth_app_id=2018020102122556&version=1.0&app_id=2018020102122556&sign_type=RSA2&seller_id=2088921750292524&timestamp=2020-04-28+23%3A42%3A46', '2020-04-28 23:43:56');
INSERT INTO `payment_info` VALUES ('271', '202004282353151588089195890', '55', '2020042822001465451404110038', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-28 23:53:19', 'charset=utf-8&out_trade_no=202004282353151588089195890&method=alipay.trade.page.pay.return&total_amount=0.01&sign=QMUtGs5z0FUp79O5i3brT%2BZClB0hUPJ5kYr%2BW25x8l%2F%2FDKO8Y5wk87EnI6H8y0nolO1263%2F11tgRLcVJMK%2FFd6838OZ7eaZIhQM0ltJ9k31vaJcEpkplpd3vtLyU9QSGWiJWFjEAeeFNkNMTycvrMA3lCDD1HA%2BecsyEhu31pRd7533jBztokvtGlZhScfHKdZRMbgVUp9aMk%2FTHIeMuPCxgwvuXktwq9aHqsoQ9sT5imV7yS9zaqj1Ytw%2Fe0THeAboN3%2BxJeskZact4bkpCLi9JVqsfZGSoCIkEMXTCoLaQwR%2FuRo9uUfNbixA%2B%2FbGT9hcbcbAX5H9loAsUGIVAzA%3D%3D&trade_no=2020042822001465451404110038&auth_app_id=2018020102122556&version=1.0&app_id=2018020102122556&sign_type=RSA2&seller_id=2088921750292524&timestamp=2020-04-28+23%3A53%3A41', '2020-04-28 23:53:44');
INSERT INTO `payment_info` VALUES ('283', '202004291419411588141181457', '69', '2020042922001465451404115094', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 14:19:43', 'charset=utf-8&out_trade_no=202004291419411588141181457&method=alipay.trade.page.pay.return&total_amount=0.01&sign=O%2B2DHrpnnyyuEafQOCZ1AKBEFxyoDxDMQ95YBUkKyFS5EEX%2B7Bmv580JFGOBnHBwWqucn3qs79mJ%2B7ksQe%2B%2ByBpXaCpm1o51N4%2Fl3HMWV%2Bn4xRo%2BwkxPBQE%2B0dHj60MectdESjTGq8MeXJ37BsJE%2FUuTkUsOSVAnjv1vDbUdnwdYalFzzTdynhREMXRyLLFN2vJtc5KlM5s5w8LqS45H8Mo7mmSwKFJT3rTQTkYuO5wVnDrvi0EsTcDBz8eQXHv2Ilvxv1feQwGkzACq8HKy2YJrBV06TdJnJzLlWYRp5le1FiVtBtz4vbeYeOT9G64q2utm0DJxszRt31W0g%2Fzomw%3D%3D&trade_no=2020042922001465451404115094&auth_app_id=2018020102122556&version=1.0&app_id=2018020102122556&sign_type=RSA2&seller_id=2088921750292524&timestamp=2020-04-29+14%3A20%3A00', '2020-04-29 14:20:04');
INSERT INTO `payment_info` VALUES ('284', '202004291503451588143825649', '70', '2020042922001465451404083255', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 15:05:01', 'Success', '2020-04-29 15:06:02');
INSERT INTO `payment_info` VALUES ('285', '202004291510271588144227433', '71', '2020042922001465451404496634', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 15:11:32', 'charset=utf-8&out_trade_no=202004291510271588144227433&method=alipay.trade.page.pay.return&total_amount=0.01&sign=No6nWSRsj67tZVdZ21eFeMYJm00Mn28MKcsvqSGeY5q%2BDaiCOTnex5xWaYrilK%2BV9ZYKxzl%2B3QOIBxSTDPL%2Bi2SpbvD12h9tfECH5JYVK%2FNd7RDun4SmTB0EAIFcSdTf0TYmn5Xq4MDpcgm1SRqt58CIBeTuuezhNqmv1KX6qGUxU45kzEF11T72WHZjoSY9RRw8iOPZv7eI61iiOuuSWkmHo98sudLEzscNjiv3Wg00PW9aLY1QiUeNWTJ9KmUPKxa1DmZZOmyhAXyuBXx6MYeYUEr7xIYevzeUIMOBKx%2B6zqIipDDckkEGM%2FUhuEUulJ0sABXYIa3sKLTxbrgvQg%3D%3D&trade_no=2020042922001465451404496634&auth_app_id=2018020102122556&version=1.0&app_id=2018020102122556&sign_type=RSA2&seller_id=2088921750292524&timestamp=2020-04-29+15%3A11%3A55', '2020-04-29 15:11:59');
INSERT INTO `payment_info` VALUES ('286', '202004291515561588144556144', '72', '2020042922001465451404132412', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 15:15:58', 'Success', '2020-04-29 15:16:58');
INSERT INTO `payment_info` VALUES ('287', '202004291540171588146017778', '73', '2020042922001465451404122873', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 15:40:21', null, '2020-04-29 15:40:42');
INSERT INTO `payment_info` VALUES ('288', '202004291546291588146389259', '74', '2020042922001465451404499703', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 15:46:32', null, '2020-04-29 15:51:44');
INSERT INTO `payment_info` VALUES ('289', '202004291552491588146769974', '75', '2020042922001465451404115119', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 15:52:53', 'charset=utf-8&out_trade_no=202004291552491588146769974&method=alipay.trade.page.pay.return&total_amount=0.01&sign=clqCU40Ocr%2BXkSoBfH9GhHiKcUyIfnTRATzDXwDfDSDomEmHQ2CVDULtuqaknzSySmzF%2Ft%2BJsbHVWFKBhZO7TORX7R7S3SjSOLP%2BQhyecCrSqeyERI1%2FAvlY%2FkyAudmP8D3DuwRDh3TnFdVnhcB6dAmCF%2BYUarjg%2FIUszyc2CrayjrDxClty0GkwFUj15aqR%2BPqjyMeOZ1yBLQTqmO2Ut2K7F82uwAy1I1IyWTTtnqtoilzBG3mhK7Wbw5RIrR0leAPQ%2FQiCAKiYGRpT6WdyWu0Mu7XRBPdOukWx798pWo%2FVmYvVO3eBRTAIs8r%2BvcSvU2527M30J3XNHjzfTwvbEw%3D%3D&trade_no=2020042922001465451404115119&auth_app_id=2018020102122556&version=1.0&app_id=2018020102122556&sign_type=RSA2&seller_id=2088921750292524&timestamp=2020-04-29+15%3A53%3A11', '2020-04-29 15:53:15');
INSERT INTO `payment_info` VALUES ('292', '202004291624061588148646791', '78', '2020042922001465451404549016', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 16:24:11', 'IKDSlGh3m9%2BEaOT2bLhjyUWgl7WycfombgGbJUSdGe03sjcLaFclVQnROFv4F3iaoH6ncFWScUcAguqJMzHuHItKRYtWbAcirfGctQ57VH49ek0IokwQle8u4ptPCsBSEQZ7DO%2BAQAxEIuzzy2AM45OUIs5itA2C%2FMuQrrrUWvSSd2nC6rsZvGgKIZ9HBQNsVTpuvoXS0RKpou0gr56pYgrRQ067DDsFUD1%2BYR%2FKb1XTx2J39diTc4P7GxLwRPROsoTFRkIhexIOGh0WLbQOgWay2oosjUIZTknBmqXN4GuRMo7shyrraDyVrsX5ATBPpvlpcXLD%2BctQtbLzxdRRGg%3D%3D', '2020-04-29 16:25:31');
INSERT INTO `payment_info` VALUES ('293', '202004291626231588148783651', '79', '2020042922001465451404531635', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 16:26:25', 'bUm1BTUUuxekFPEYeyQOLnCO+Gh9jhBuQ6Ggr3fDFrH+Vg90eFERC62+GYsbnBY0nH9J2p50rj8txBrbBem5OhDH7ggA/UWjHey1oCUEA9wNODf9m4Lw0dHRbZPZu1NKEBzndEkBGG/9EmTkuR9YxM0t7czhqkg+2XBizO4UZ4m8/1BS2fdNpcMAOVx3+sG6o1GAQfvRFt8MviLieVYPFTbpePSx77U/2WQAHCBt4XSxkd6H57ONVGA9YmCHXbTidlcGoa4UBfzXR7Eokj7aphRplsSVWkVXONIhNMUF4gLMMp6RI992wxnEf5N54fPLAZxq9ScmYQgeZjBO+wjR4Q==', '2020-04-29 16:26:56');
INSERT INTO `payment_info` VALUES ('294', '202004292203401588169020781', '80', '2020042922001465451404496738', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 22:03:42', 'eSPBtnKsCCw/9448z552LyPQ21SuN84OIqFhMkZPZdJDPoS2mfl15V/9jrD+hxqkQRWGVPt9oQpY4otim0wwvx3yh1K+TOmtXTWsMmc52zDfnWqWXJw6wgxr3lWS9t8Gpb0WglLADqbgsMnpNUeNxnNZW6si94Q4DFza33rEDPSG6Up6A6EoEXbWaPmX1rhfTUJfkqQvqyORZgtThec1oB8Hz60hvYYTLGs9L2k7Cop41QNfNqdM4nB7WLl5/CzWgbI8Xid/TmMva9IsKv3YLHlFE4jnb3qoZX7Dy+C1hO/4LDT3YsXd9RKXTr7/R7CaVtTfgSQ4AVIxQMKZpKskVQ==', '2020-04-29 22:08:11');
INSERT INTO `payment_info` VALUES ('295', '202004292228121588170492888', '82', '2020042922001465451404540898', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 22:28:15', 'DJ0mklBX0Y8++mNpcuMN5Zyo1zh73nKc9URzGl89TvHh0DSiSS861vXkR4j4K62HrYAo1iTs0G9TeeuNGa4pZDZBEDI7SDEqJafUl6MeMxY5YaxyRTOJNWcVH84XxCxT+fydeJBSQ8D5GCVymRCPGct61MR6PXK8L/fZdDzuswd+GLxLSv6XjeMEmI8JKnyke4Ng5oPS6qLqINdH4YYTVpLJ6jcYjE9iesb5ARmVrQad2K7I6VctAHV6rbcficX8vVyes3JGKoO3xYDhYfRDYcAd58PRrAhqMu6T+vbgPLyEtLv2DTfsUl6YG/AjXz0YrU14b6ssF361w7tN9Vx2Mw==', '2020-04-29 22:31:35');
INSERT INTO `payment_info` VALUES ('296', '202004292233511588170831331', '83', '2020042922001465451404540899', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 22:33:55', 'ADyJx1ERyoqPrxaCV5M3aBCVqUMimE9vZ9HTg6D0gmbLzAfRGwIJWrBRLdhfUKjOpeq7wbkJD1OQxpG4S/g/aKmGqw/dCrbrH5vQNLVJbuKvBi2EY/xV5Jcyv06U9IX5pfJ6/KMFpjV/k0a/8K4DZsVWVZQwUBW0pjA2t5RFn0tMSOY0yLcZYvy/xEeM2wTZaN5TpQ3HsthXSv07pqEHwmHJv/SYRXG0gfI0wJJ2wS12wnne3JC1g2zns478w+OltV8s9p5KhTJzTGlD6mArh5rAWi2dDabeYcNkEb2m3gUhfP08e59QTGbUNWa9vnIcm9dTKej7jBhf4urgq68cmA==', '2020-04-29 22:34:19');
INSERT INTO `payment_info` VALUES ('297', '202004292242401588171360352', '84', '2020042922001465451404553674', '2598.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 22:42:42', 'O/Mp72cwKNT4S5vQ9c3KdkbEKrPExhggRs+vwMXb3fXeIHAUb4NzrtkPJPLQJmxkpsJinL2Fymh7SL+HMuLLmgpdvMD8NIxU4IhLSBOiQmnJpmBV9vMraJ3/ac8Ai6vkzgi1M25EB5jxb2q2AvwMU9ZOz9LS5hsCcuItEULHuBzx3KteSnDvLkqttfs3rpgJKfIIynjH0Q3/6LS0qKPsADd6o41ZM5hGFsxUuLECN9lq7fGkMBOwLJ615TUB0opMSq2yyO5PQVWlqHPqXNL4NHxVBUfXGcCOl28p5l68NQ9hgGcqAty2K3FtzAI9fkQJ8eifTxh+HvSqJywsWOQS6A==', '2020-04-29 22:43:17');
INSERT INTO `payment_info` VALUES ('298', '202004292314461588173286191', '85', '2020042922001465451404564392', '5196.00', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '交易支付成功', '2020-04-29 23:14:49', 'elvLQHrsNj+FG2hCKISu6k7dOsPaiEzxgx7JpLE1DWq+9XcJb6IWtW3B9XHzNhIpbJmBy7jRbJbEvajsWQmXpYnzLjxbwhkMJYN8GVB9qeOtu6yCjAlo2T93GXUh0PrZQJ6QuERc2Zu1PutYMl7T9lGccYOx+VH5FhclHgO70n6QmWHFlHO3YbIklzzJNTEv8GBup0j7PxKl7dIExuoMP7wmQ12OQehhLtQ90DTqIbk0jIS4NtvyDjWH2zIwAG97u/9069LkjyIC4FqF8dmtYgPAK0o6H9bXZKvUxhcQFMvA/fKmVTkIcEnGPBlou/BSHGAge5nQizZOhjZOAMxRLg==', '2020-04-29 23:15:31');

-- ----------------------------
-- Table structure for `pms_base_attr_info`
-- ----------------------------
DROP TABLE IF EXISTS `pms_base_attr_info`;
CREATE TABLE `pms_base_attr_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `attr_name` varchar(100) NOT NULL COMMENT '属性名称',
  `catalog3_id` bigint(20) DEFAULT NULL,
  `is_enabled` varchar(1) DEFAULT NULL COMMENT '启用：1 停用：0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='属性表';

-- ----------------------------
-- Records of pms_base_attr_info
-- ----------------------------
INSERT INTO `pms_base_attr_info` VALUES ('12', '尺寸', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('13', '内存', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('25', '屏幕尺寸', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('26', '内存容量', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('27', '颜色', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('28', 'cpu', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('29', '外壳', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('31', '容错率', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('32', '时空传送距离', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('33', '待机时间', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('34', '线宽', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('35', '高度', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('36', '吃鸡性能', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('37', 'lol性能', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('38', '续航时间', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('40', '商品保修期', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('41', '一级内存', '61', null);
INSERT INTO `pms_base_attr_info` VALUES ('44', '二级内存', '61', null);

-- ----------------------------
-- Table structure for `pms_base_attr_value`
-- ----------------------------
DROP TABLE IF EXISTS `pms_base_attr_value`;
CREATE TABLE `pms_base_attr_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `value_name` varchar(100) NOT NULL COMMENT '属性值名称',
  `attr_id` bigint(20) DEFAULT NULL COMMENT '属性id',
  `is_enabled` varchar(1) DEFAULT NULL COMMENT '启用：1 停用：0 1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 COMMENT='属性值表';

-- ----------------------------
-- Records of pms_base_attr_value
-- ----------------------------
INSERT INTO `pms_base_attr_value` VALUES ('39', '4寸以下', '25', '');
INSERT INTO `pms_base_attr_value` VALUES ('40', '4.1寸-5寸', '25', '');
INSERT INTO `pms_base_attr_value` VALUES ('41', '5.1寸-5.5寸', '25', '');
INSERT INTO `pms_base_attr_value` VALUES ('42', '5.6寸以上', '25', '');
INSERT INTO `pms_base_attr_value` VALUES ('43', '16G', '26', '');
INSERT INTO `pms_base_attr_value` VALUES ('44', '32G', '26', '');
INSERT INTO `pms_base_attr_value` VALUES ('45', '64G', '26', '');
INSERT INTO `pms_base_attr_value` VALUES ('46', '128G', '26', '');
INSERT INTO `pms_base_attr_value` VALUES ('47', '256G', '26', '');
INSERT INTO `pms_base_attr_value` VALUES ('48', 'z1', '12', '');
INSERT INTO `pms_base_attr_value` VALUES ('49', 'z2', '12', '');
INSERT INTO `pms_base_attr_value` VALUES ('50', 'z3', '12', '');
INSERT INTO `pms_base_attr_value` VALUES ('51', 'n1', '13', '');
INSERT INTO `pms_base_attr_value` VALUES ('52', 'n2', '13', '');
INSERT INTO `pms_base_attr_value` VALUES ('53', 'n3', '13', '');
INSERT INTO `pms_base_attr_value` VALUES ('54', '红色', '27', '');
INSERT INTO `pms_base_attr_value` VALUES ('55', '蓝色', '27', '');
INSERT INTO `pms_base_attr_value` VALUES ('56', '紫色', '27', '');
INSERT INTO `pms_base_attr_value` VALUES ('57', '灰色', '27', '');
INSERT INTO `pms_base_attr_value` VALUES ('58', '100寸', '25', '');
INSERT INTO `pms_base_attr_value` VALUES ('59', 'i5', '28', '');
INSERT INTO `pms_base_attr_value` VALUES ('60', 'i7', '28', '');
INSERT INTO `pms_base_attr_value` VALUES ('61', 'i9', '28', '');
INSERT INTO `pms_base_attr_value` VALUES ('62', '陶瓷', '29', '');
INSERT INTO `pms_base_attr_value` VALUES ('63', '铁', '29', '');
INSERT INTO `pms_base_attr_value` VALUES ('64', '金', '29', '');
INSERT INTO `pms_base_attr_value` VALUES ('65', '环绕立体声', '32', '');
INSERT INTO `pms_base_attr_value` VALUES ('66', '影院效果', '32', '');
INSERT INTO `pms_base_attr_value` VALUES ('67', '不容错', '31', null);
INSERT INTO `pms_base_attr_value` VALUES ('68', '容错', '31', null);
INSERT INTO `pms_base_attr_value` VALUES ('69', '100m', '32', null);
INSERT INTO `pms_base_attr_value` VALUES ('70', '200m', '32', null);
INSERT INTO `pms_base_attr_value` VALUES ('71', '300m', '32', null);
INSERT INTO `pms_base_attr_value` VALUES ('72', '1小时', '33', null);
INSERT INTO `pms_base_attr_value` VALUES ('73', '2小时', '33', null);
INSERT INTO `pms_base_attr_value` VALUES ('74', '3小时', '33', null);
INSERT INTO `pms_base_attr_value` VALUES ('75', '线宽1', '34', null);
INSERT INTO `pms_base_attr_value` VALUES ('76', '线宽2', '34', null);
INSERT INTO `pms_base_attr_value` VALUES ('77', '线宽3', '34', null);
INSERT INTO `pms_base_attr_value` VALUES ('78', '1米', '35', null);
INSERT INTO `pms_base_attr_value` VALUES ('79', '2米', '35', null);
INSERT INTO `pms_base_attr_value` VALUES ('80', '3米', '35', null);
INSERT INTO `pms_base_attr_value` VALUES ('81', '入门级', '36', null);
INSERT INTO `pms_base_attr_value` VALUES ('82', '大师级', '36', null);
INSERT INTO `pms_base_attr_value` VALUES ('83', '超神', '36', null);
INSERT INTO `pms_base_attr_value` VALUES ('84', '最低配置', '37', null);
INSERT INTO `pms_base_attr_value` VALUES ('85', '中等配置', '37', null);
INSERT INTO `pms_base_attr_value` VALUES ('86', '高等配置', '37', null);
INSERT INTO `pms_base_attr_value` VALUES ('87', '1天', '38', null);
INSERT INTO `pms_base_attr_value` VALUES ('88', '2天', '38', null);
INSERT INTO `pms_base_attr_value` VALUES ('89', '3天', '38', null);
INSERT INTO `pms_base_attr_value` VALUES ('92', '一天', '40', null);
INSERT INTO `pms_base_attr_value` VALUES ('93', '两天', '40', null);
INSERT INTO `pms_base_attr_value` VALUES ('94', '1T', '41', null);
INSERT INTO `pms_base_attr_value` VALUES ('95', '2T', '41', null);
INSERT INTO `pms_base_attr_value` VALUES ('96', '3T', '41', null);
INSERT INTO `pms_base_attr_value` VALUES ('97', '1T', '42', null);
INSERT INTO `pms_base_attr_value` VALUES ('98', '2T', '42', null);
INSERT INTO `pms_base_attr_value` VALUES ('99', '3T', '42', null);
INSERT INTO `pms_base_attr_value` VALUES ('103', '32G', '44', null);
INSERT INTO `pms_base_attr_value` VALUES ('104', '64G', '44', null);
INSERT INTO `pms_base_attr_value` VALUES ('105', '128G', '44', null);
INSERT INTO `pms_base_attr_value` VALUES ('106', '256G', '44', null);

-- ----------------------------
-- Table structure for `pms_base_catalog1`
-- ----------------------------
DROP TABLE IF EXISTS `pms_base_catalog1`;
CREATE TABLE `pms_base_catalog1` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(200) NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='一级分类表';

-- ----------------------------
-- Records of pms_base_catalog1
-- ----------------------------
INSERT INTO `pms_base_catalog1` VALUES ('1', '图书、音像、电子书刊');
INSERT INTO `pms_base_catalog1` VALUES ('2', '手机');
INSERT INTO `pms_base_catalog1` VALUES ('3', '家用电器');
INSERT INTO `pms_base_catalog1` VALUES ('4', '数码');
INSERT INTO `pms_base_catalog1` VALUES ('5', '家居家装');
INSERT INTO `pms_base_catalog1` VALUES ('6', '电脑办公');
INSERT INTO `pms_base_catalog1` VALUES ('7', '厨具');
INSERT INTO `pms_base_catalog1` VALUES ('8', '个护化妆');
INSERT INTO `pms_base_catalog1` VALUES ('9', '服饰内衣');
INSERT INTO `pms_base_catalog1` VALUES ('10', '钟表');
INSERT INTO `pms_base_catalog1` VALUES ('11', '鞋靴');
INSERT INTO `pms_base_catalog1` VALUES ('12', '母婴');
INSERT INTO `pms_base_catalog1` VALUES ('13', '礼品箱包');
INSERT INTO `pms_base_catalog1` VALUES ('14', '食品饮料、保健食品');
INSERT INTO `pms_base_catalog1` VALUES ('15', '珠宝');
INSERT INTO `pms_base_catalog1` VALUES ('16', '汽车用品');
INSERT INTO `pms_base_catalog1` VALUES ('17', '运动健康');
INSERT INTO `pms_base_catalog1` VALUES ('18', '玩具乐器');
INSERT INTO `pms_base_catalog1` VALUES ('19', '彩票、旅行、充值、票务');
INSERT INTO `pms_base_catalog1` VALUES ('20', '生鲜');
INSERT INTO `pms_base_catalog1` VALUES ('21', '整车');

-- ----------------------------
-- Table structure for `pms_base_catalog2`
-- ----------------------------
DROP TABLE IF EXISTS `pms_base_catalog2`;
CREATE TABLE `pms_base_catalog2` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(200) NOT NULL COMMENT '二级分类名称',
  `catalog1_id` int(11) DEFAULT NULL COMMENT '一级分类编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pms_base_catalog2
-- ----------------------------
INSERT INTO `pms_base_catalog2` VALUES ('1', '电子书刊', '1');
INSERT INTO `pms_base_catalog2` VALUES ('2', '音像', '1');
INSERT INTO `pms_base_catalog2` VALUES ('3', '英文原版', '1');
INSERT INTO `pms_base_catalog2` VALUES ('4', '文艺', '1');
INSERT INTO `pms_base_catalog2` VALUES ('5', '少儿', '1');
INSERT INTO `pms_base_catalog2` VALUES ('6', '人文社科', '1');
INSERT INTO `pms_base_catalog2` VALUES ('7', '经管励志', '1');
INSERT INTO `pms_base_catalog2` VALUES ('8', '生活', '1');
INSERT INTO `pms_base_catalog2` VALUES ('9', '科技', '1');
INSERT INTO `pms_base_catalog2` VALUES ('10', '教育', '1');
INSERT INTO `pms_base_catalog2` VALUES ('11', '港台图书', '1');
INSERT INTO `pms_base_catalog2` VALUES ('12', '其他', '1');
INSERT INTO `pms_base_catalog2` VALUES ('13', '手机通讯', '2');
INSERT INTO `pms_base_catalog2` VALUES ('14', '运营商', '2');
INSERT INTO `pms_base_catalog2` VALUES ('15', '手机配件', '2');
INSERT INTO `pms_base_catalog2` VALUES ('16', '大 家 电', '3');
INSERT INTO `pms_base_catalog2` VALUES ('17', '厨卫大电', '3');
INSERT INTO `pms_base_catalog2` VALUES ('18', '厨房小电', '3');
INSERT INTO `pms_base_catalog2` VALUES ('19', '生活电器', '3');
INSERT INTO `pms_base_catalog2` VALUES ('20', '个护健康', '3');
INSERT INTO `pms_base_catalog2` VALUES ('21', '五金家装', '3');
INSERT INTO `pms_base_catalog2` VALUES ('22', '摄影摄像', '4');
INSERT INTO `pms_base_catalog2` VALUES ('23', '数码配件', '4');
INSERT INTO `pms_base_catalog2` VALUES ('24', '智能设备', '4');
INSERT INTO `pms_base_catalog2` VALUES ('25', '影音娱乐', '4');
INSERT INTO `pms_base_catalog2` VALUES ('26', '电子教育', '4');
INSERT INTO `pms_base_catalog2` VALUES ('27', '虚拟商品', '4');
INSERT INTO `pms_base_catalog2` VALUES ('28', '家纺', '5');
INSERT INTO `pms_base_catalog2` VALUES ('29', '灯具', '5');
INSERT INTO `pms_base_catalog2` VALUES ('30', '生活日用', '5');
INSERT INTO `pms_base_catalog2` VALUES ('31', '家装软饰', '5');
INSERT INTO `pms_base_catalog2` VALUES ('32', '宠物生活', '5');
INSERT INTO `pms_base_catalog2` VALUES ('33', '电脑整机', '6');
INSERT INTO `pms_base_catalog2` VALUES ('34', '电脑配件', '6');
INSERT INTO `pms_base_catalog2` VALUES ('35', '外设产品', '6');
INSERT INTO `pms_base_catalog2` VALUES ('36', '游戏设备', '6');
INSERT INTO `pms_base_catalog2` VALUES ('37', '网络产品', '6');
INSERT INTO `pms_base_catalog2` VALUES ('38', '办公设备', '6');
INSERT INTO `pms_base_catalog2` VALUES ('39', '文具/耗材', '6');
INSERT INTO `pms_base_catalog2` VALUES ('40', '服务产品', '6');
INSERT INTO `pms_base_catalog2` VALUES ('41', '烹饪锅具', '7');
INSERT INTO `pms_base_catalog2` VALUES ('42', '刀剪菜板', '7');
INSERT INTO `pms_base_catalog2` VALUES ('43', '厨房配件', '7');
INSERT INTO `pms_base_catalog2` VALUES ('44', '水具酒具', '7');
INSERT INTO `pms_base_catalog2` VALUES ('45', '餐具', '7');
INSERT INTO `pms_base_catalog2` VALUES ('46', '酒店用品', '7');
INSERT INTO `pms_base_catalog2` VALUES ('47', '茶具/咖啡具', '7');
INSERT INTO `pms_base_catalog2` VALUES ('48', '清洁用品', '8');
INSERT INTO `pms_base_catalog2` VALUES ('49', '面部护肤', '8');
INSERT INTO `pms_base_catalog2` VALUES ('50', '身体护理', '8');
INSERT INTO `pms_base_catalog2` VALUES ('51', '口腔护理', '8');
INSERT INTO `pms_base_catalog2` VALUES ('52', '女性护理', '8');
INSERT INTO `pms_base_catalog2` VALUES ('53', '洗发护发', '8');
INSERT INTO `pms_base_catalog2` VALUES ('54', '香水彩妆', '8');
INSERT INTO `pms_base_catalog2` VALUES ('55', '女装', '9');
INSERT INTO `pms_base_catalog2` VALUES ('56', '男装', '9');
INSERT INTO `pms_base_catalog2` VALUES ('57', '内衣', '9');
INSERT INTO `pms_base_catalog2` VALUES ('58', '洗衣服务', '9');
INSERT INTO `pms_base_catalog2` VALUES ('59', '服饰配件', '9');
INSERT INTO `pms_base_catalog2` VALUES ('60', '钟表', '10');
INSERT INTO `pms_base_catalog2` VALUES ('61', '流行男鞋', '11');
INSERT INTO `pms_base_catalog2` VALUES ('62', '时尚女鞋', '11');
INSERT INTO `pms_base_catalog2` VALUES ('63', '奶粉', '12');
INSERT INTO `pms_base_catalog2` VALUES ('64', '营养辅食', '12');
INSERT INTO `pms_base_catalog2` VALUES ('65', '尿裤湿巾', '12');
INSERT INTO `pms_base_catalog2` VALUES ('66', '喂养用品', '12');
INSERT INTO `pms_base_catalog2` VALUES ('67', '洗护用品', '12');
INSERT INTO `pms_base_catalog2` VALUES ('68', '童车童床', '12');
INSERT INTO `pms_base_catalog2` VALUES ('69', '寝居服饰', '12');
INSERT INTO `pms_base_catalog2` VALUES ('70', '妈妈专区', '12');
INSERT INTO `pms_base_catalog2` VALUES ('71', '童装童鞋', '12');
INSERT INTO `pms_base_catalog2` VALUES ('72', '安全座椅', '12');
INSERT INTO `pms_base_catalog2` VALUES ('73', '潮流女包', '13');
INSERT INTO `pms_base_catalog2` VALUES ('74', '精品男包', '13');
INSERT INTO `pms_base_catalog2` VALUES ('75', '功能箱包', '13');
INSERT INTO `pms_base_catalog2` VALUES ('76', '礼品', '13');
INSERT INTO `pms_base_catalog2` VALUES ('77', '奢侈品', '13');
INSERT INTO `pms_base_catalog2` VALUES ('78', '婚庆', '13');
INSERT INTO `pms_base_catalog2` VALUES ('79', '进口食品', '14');
INSERT INTO `pms_base_catalog2` VALUES ('80', '地方特产', '14');
INSERT INTO `pms_base_catalog2` VALUES ('81', '休闲食品', '14');
INSERT INTO `pms_base_catalog2` VALUES ('82', '粮油调味', '14');
INSERT INTO `pms_base_catalog2` VALUES ('83', '饮料冲调', '14');
INSERT INTO `pms_base_catalog2` VALUES ('84', '食品礼券', '14');
INSERT INTO `pms_base_catalog2` VALUES ('85', '茗茶', '14');
INSERT INTO `pms_base_catalog2` VALUES ('86', '时尚饰品', '15');
INSERT INTO `pms_base_catalog2` VALUES ('87', '黄金', '15');
INSERT INTO `pms_base_catalog2` VALUES ('88', 'K金饰品', '15');
INSERT INTO `pms_base_catalog2` VALUES ('89', '金银投资', '15');
INSERT INTO `pms_base_catalog2` VALUES ('90', '银饰', '15');
INSERT INTO `pms_base_catalog2` VALUES ('91', '钻石', '15');
INSERT INTO `pms_base_catalog2` VALUES ('92', '翡翠玉石', '15');
INSERT INTO `pms_base_catalog2` VALUES ('93', '水晶玛瑙', '15');
INSERT INTO `pms_base_catalog2` VALUES ('94', '彩宝', '15');
INSERT INTO `pms_base_catalog2` VALUES ('95', '铂金', '15');
INSERT INTO `pms_base_catalog2` VALUES ('96', '木手串/把件', '15');
INSERT INTO `pms_base_catalog2` VALUES ('97', '珍珠', '15');
INSERT INTO `pms_base_catalog2` VALUES ('98', '维修保养', '16');
INSERT INTO `pms_base_catalog2` VALUES ('99', '车载电器', '16');
INSERT INTO `pms_base_catalog2` VALUES ('100', '美容清洗', '16');
INSERT INTO `pms_base_catalog2` VALUES ('101', '汽车装饰', '16');
INSERT INTO `pms_base_catalog2` VALUES ('102', '安全自驾', '16');
INSERT INTO `pms_base_catalog2` VALUES ('103', '汽车服务', '16');
INSERT INTO `pms_base_catalog2` VALUES ('104', '赛事改装', '16');
INSERT INTO `pms_base_catalog2` VALUES ('105', '运动鞋包', '17');
INSERT INTO `pms_base_catalog2` VALUES ('106', '运动服饰', '17');
INSERT INTO `pms_base_catalog2` VALUES ('107', '骑行运动', '17');
INSERT INTO `pms_base_catalog2` VALUES ('108', '垂钓用品', '17');
INSERT INTO `pms_base_catalog2` VALUES ('109', '游泳用品', '17');
INSERT INTO `pms_base_catalog2` VALUES ('110', '户外鞋服', '17');
INSERT INTO `pms_base_catalog2` VALUES ('111', '户外装备', '17');
INSERT INTO `pms_base_catalog2` VALUES ('112', '健身训练', '17');
INSERT INTO `pms_base_catalog2` VALUES ('113', '体育用品', '17');
INSERT INTO `pms_base_catalog2` VALUES ('114', '适用年龄', '18');
INSERT INTO `pms_base_catalog2` VALUES ('115', '遥控/电动', '18');
INSERT INTO `pms_base_catalog2` VALUES ('116', '毛绒布艺', '18');
INSERT INTO `pms_base_catalog2` VALUES ('117', '娃娃玩具', '18');
INSERT INTO `pms_base_catalog2` VALUES ('118', '模型玩具', '18');
INSERT INTO `pms_base_catalog2` VALUES ('119', '健身玩具', '18');
INSERT INTO `pms_base_catalog2` VALUES ('120', '动漫玩具', '18');
INSERT INTO `pms_base_catalog2` VALUES ('121', '益智玩具', '18');
INSERT INTO `pms_base_catalog2` VALUES ('122', '积木拼插', '18');
INSERT INTO `pms_base_catalog2` VALUES ('123', 'DIY玩具', '18');
INSERT INTO `pms_base_catalog2` VALUES ('124', '创意减压', '18');
INSERT INTO `pms_base_catalog2` VALUES ('125', '乐器', '18');
INSERT INTO `pms_base_catalog2` VALUES ('126', '彩票', '19');
INSERT INTO `pms_base_catalog2` VALUES ('127', '机票', '19');
INSERT INTO `pms_base_catalog2` VALUES ('128', '酒店', '19');
INSERT INTO `pms_base_catalog2` VALUES ('129', '旅行', '19');
INSERT INTO `pms_base_catalog2` VALUES ('130', '充值', '19');
INSERT INTO `pms_base_catalog2` VALUES ('131', '游戏', '19');
INSERT INTO `pms_base_catalog2` VALUES ('132', '票务', '19');
INSERT INTO `pms_base_catalog2` VALUES ('133', '产地直供', '20');
INSERT INTO `pms_base_catalog2` VALUES ('134', '水果', '20');
INSERT INTO `pms_base_catalog2` VALUES ('135', '猪牛羊肉', '20');
INSERT INTO `pms_base_catalog2` VALUES ('136', '海鲜水产', '20');
INSERT INTO `pms_base_catalog2` VALUES ('137', '禽肉蛋品', '20');
INSERT INTO `pms_base_catalog2` VALUES ('138', '冷冻食品', '20');
INSERT INTO `pms_base_catalog2` VALUES ('139', '熟食腊味', '20');
INSERT INTO `pms_base_catalog2` VALUES ('140', '饮品甜品', '20');
INSERT INTO `pms_base_catalog2` VALUES ('141', '蔬菜', '20');
INSERT INTO `pms_base_catalog2` VALUES ('142', '全新整车', '21');
INSERT INTO `pms_base_catalog2` VALUES ('143', '二手车', '21');

-- ----------------------------
-- Table structure for `pms_base_catalog3`
-- ----------------------------
DROP TABLE IF EXISTS `pms_base_catalog3`;
CREATE TABLE `pms_base_catalog3` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(200) NOT NULL COMMENT '三级分类名称',
  `catalog2_id` bigint(20) DEFAULT NULL COMMENT '二级分类编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1260 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pms_base_catalog3
-- ----------------------------
INSERT INTO `pms_base_catalog3` VALUES ('1', '电子书', '1');
INSERT INTO `pms_base_catalog3` VALUES ('2', '网络原创', '1');
INSERT INTO `pms_base_catalog3` VALUES ('3', '数字杂志', '1');
INSERT INTO `pms_base_catalog3` VALUES ('4', '多媒体图书', '1');
INSERT INTO `pms_base_catalog3` VALUES ('5', '音乐', '2');
INSERT INTO `pms_base_catalog3` VALUES ('6', '影视', '2');
INSERT INTO `pms_base_catalog3` VALUES ('7', '教育音像', '2');
INSERT INTO `pms_base_catalog3` VALUES ('8', '少儿', '3');
INSERT INTO `pms_base_catalog3` VALUES ('9', '商务投资', '3');
INSERT INTO `pms_base_catalog3` VALUES ('10', '英语学习与考试', '3');
INSERT INTO `pms_base_catalog3` VALUES ('11', '文学', '3');
INSERT INTO `pms_base_catalog3` VALUES ('12', '传记', '3');
INSERT INTO `pms_base_catalog3` VALUES ('13', '励志', '3');
INSERT INTO `pms_base_catalog3` VALUES ('14', '小说', '4');
INSERT INTO `pms_base_catalog3` VALUES ('15', '文学', '4');
INSERT INTO `pms_base_catalog3` VALUES ('16', '青春文学', '4');
INSERT INTO `pms_base_catalog3` VALUES ('17', '传记', '4');
INSERT INTO `pms_base_catalog3` VALUES ('18', '艺术', '4');
INSERT INTO `pms_base_catalog3` VALUES ('19', '少儿', '5');
INSERT INTO `pms_base_catalog3` VALUES ('20', '0-2岁', '5');
INSERT INTO `pms_base_catalog3` VALUES ('21', '3-6岁', '5');
INSERT INTO `pms_base_catalog3` VALUES ('22', '7-10岁', '5');
INSERT INTO `pms_base_catalog3` VALUES ('23', '11-14岁', '5');
INSERT INTO `pms_base_catalog3` VALUES ('24', '历史', '6');
INSERT INTO `pms_base_catalog3` VALUES ('25', '哲学', '6');
INSERT INTO `pms_base_catalog3` VALUES ('26', '国学', '6');
INSERT INTO `pms_base_catalog3` VALUES ('27', '政治/军事', '6');
INSERT INTO `pms_base_catalog3` VALUES ('28', '法律', '6');
INSERT INTO `pms_base_catalog3` VALUES ('29', '人文社科', '6');
INSERT INTO `pms_base_catalog3` VALUES ('30', '心理学', '6');
INSERT INTO `pms_base_catalog3` VALUES ('31', '文化', '6');
INSERT INTO `pms_base_catalog3` VALUES ('32', '社会科学', '6');
INSERT INTO `pms_base_catalog3` VALUES ('33', '经济', '7');
INSERT INTO `pms_base_catalog3` VALUES ('34', '金融与投资', '7');
INSERT INTO `pms_base_catalog3` VALUES ('35', '管理', '7');
INSERT INTO `pms_base_catalog3` VALUES ('36', '励志与成功', '7');
INSERT INTO `pms_base_catalog3` VALUES ('37', '生活', '8');
INSERT INTO `pms_base_catalog3` VALUES ('38', '健身与保健', '8');
INSERT INTO `pms_base_catalog3` VALUES ('39', '家庭与育儿', '8');
INSERT INTO `pms_base_catalog3` VALUES ('40', '旅游', '8');
INSERT INTO `pms_base_catalog3` VALUES ('41', '烹饪美食', '8');
INSERT INTO `pms_base_catalog3` VALUES ('42', '工业技术', '9');
INSERT INTO `pms_base_catalog3` VALUES ('43', '科普读物', '9');
INSERT INTO `pms_base_catalog3` VALUES ('44', '建筑', '9');
INSERT INTO `pms_base_catalog3` VALUES ('45', '医学', '9');
INSERT INTO `pms_base_catalog3` VALUES ('46', '科学与自然', '9');
INSERT INTO `pms_base_catalog3` VALUES ('47', '计算机与互联网', '9');
INSERT INTO `pms_base_catalog3` VALUES ('48', '电子通信', '9');
INSERT INTO `pms_base_catalog3` VALUES ('49', '中小学教辅', '10');
INSERT INTO `pms_base_catalog3` VALUES ('50', '教育与考试', '10');
INSERT INTO `pms_base_catalog3` VALUES ('51', '外语学习', '10');
INSERT INTO `pms_base_catalog3` VALUES ('52', '大中专教材', '10');
INSERT INTO `pms_base_catalog3` VALUES ('53', '字典词典', '10');
INSERT INTO `pms_base_catalog3` VALUES ('54', '艺术/设计/收藏', '11');
INSERT INTO `pms_base_catalog3` VALUES ('55', '经济管理', '11');
INSERT INTO `pms_base_catalog3` VALUES ('56', '文化/学术', '11');
INSERT INTO `pms_base_catalog3` VALUES ('57', '少儿', '11');
INSERT INTO `pms_base_catalog3` VALUES ('58', '工具书', '12');
INSERT INTO `pms_base_catalog3` VALUES ('59', '杂志/期刊', '12');
INSERT INTO `pms_base_catalog3` VALUES ('60', '套装书', '12');
INSERT INTO `pms_base_catalog3` VALUES ('61', '手机', '13');
INSERT INTO `pms_base_catalog3` VALUES ('62', '对讲机', '13');
INSERT INTO `pms_base_catalog3` VALUES ('63', '合约机', '14');
INSERT INTO `pms_base_catalog3` VALUES ('64', '选号中心', '14');
INSERT INTO `pms_base_catalog3` VALUES ('65', '装宽带', '14');
INSERT INTO `pms_base_catalog3` VALUES ('66', '办套餐', '14');
INSERT INTO `pms_base_catalog3` VALUES ('67', '移动电源', '15');
INSERT INTO `pms_base_catalog3` VALUES ('68', '电池/移动电源', '15');
INSERT INTO `pms_base_catalog3` VALUES ('69', '蓝牙耳机', '15');
INSERT INTO `pms_base_catalog3` VALUES ('70', '充电器/数据线', '15');
INSERT INTO `pms_base_catalog3` VALUES ('71', '苹果周边', '15');
INSERT INTO `pms_base_catalog3` VALUES ('72', '手机耳机', '15');
INSERT INTO `pms_base_catalog3` VALUES ('73', '手机贴膜', '15');
INSERT INTO `pms_base_catalog3` VALUES ('74', '手机存储卡', '15');
INSERT INTO `pms_base_catalog3` VALUES ('75', '充电器', '15');
INSERT INTO `pms_base_catalog3` VALUES ('76', '数据线', '15');
INSERT INTO `pms_base_catalog3` VALUES ('77', '手机保护套', '15');
INSERT INTO `pms_base_catalog3` VALUES ('78', '车载配件', '15');
INSERT INTO `pms_base_catalog3` VALUES ('79', 'iPhone 配件', '15');
INSERT INTO `pms_base_catalog3` VALUES ('80', '手机电池', '15');
INSERT INTO `pms_base_catalog3` VALUES ('81', '创意配件', '15');
INSERT INTO `pms_base_catalog3` VALUES ('82', '便携/无线音响', '15');
INSERT INTO `pms_base_catalog3` VALUES ('83', '手机饰品', '15');
INSERT INTO `pms_base_catalog3` VALUES ('84', '拍照配件', '15');
INSERT INTO `pms_base_catalog3` VALUES ('85', '手机支架', '15');
INSERT INTO `pms_base_catalog3` VALUES ('86', '平板电视', '16');
INSERT INTO `pms_base_catalog3` VALUES ('87', '空调', '16');
INSERT INTO `pms_base_catalog3` VALUES ('88', '冰箱', '16');
INSERT INTO `pms_base_catalog3` VALUES ('89', '洗衣机', '16');
INSERT INTO `pms_base_catalog3` VALUES ('90', '家庭影院', '16');
INSERT INTO `pms_base_catalog3` VALUES ('91', 'DVD/电视盒子', '16');
INSERT INTO `pms_base_catalog3` VALUES ('92', '迷你音响', '16');
INSERT INTO `pms_base_catalog3` VALUES ('93', '冷柜/冰吧', '16');
INSERT INTO `pms_base_catalog3` VALUES ('94', '家电配件', '16');
INSERT INTO `pms_base_catalog3` VALUES ('95', '功放', '16');
INSERT INTO `pms_base_catalog3` VALUES ('96', '回音壁/Soundbar', '16');
INSERT INTO `pms_base_catalog3` VALUES ('97', 'Hi-Fi专区', '16');
INSERT INTO `pms_base_catalog3` VALUES ('98', '电视盒子', '16');
INSERT INTO `pms_base_catalog3` VALUES ('99', '酒柜', '16');
INSERT INTO `pms_base_catalog3` VALUES ('100', '燃气灶', '17');
INSERT INTO `pms_base_catalog3` VALUES ('101', '油烟机', '17');
INSERT INTO `pms_base_catalog3` VALUES ('102', '热水器', '17');
INSERT INTO `pms_base_catalog3` VALUES ('103', '消毒柜', '17');
INSERT INTO `pms_base_catalog3` VALUES ('104', '洗碗机', '17');
INSERT INTO `pms_base_catalog3` VALUES ('105', '料理机', '18');
INSERT INTO `pms_base_catalog3` VALUES ('106', '榨汁机', '18');
INSERT INTO `pms_base_catalog3` VALUES ('107', '电饭煲', '18');
INSERT INTO `pms_base_catalog3` VALUES ('108', '电压力锅', '18');
INSERT INTO `pms_base_catalog3` VALUES ('109', '豆浆机', '18');
INSERT INTO `pms_base_catalog3` VALUES ('110', '咖啡机', '18');
INSERT INTO `pms_base_catalog3` VALUES ('111', '微波炉', '18');
INSERT INTO `pms_base_catalog3` VALUES ('112', '电烤箱', '18');
INSERT INTO `pms_base_catalog3` VALUES ('113', '电磁炉', '18');
INSERT INTO `pms_base_catalog3` VALUES ('114', '面包机', '18');
INSERT INTO `pms_base_catalog3` VALUES ('115', '煮蛋器', '18');
INSERT INTO `pms_base_catalog3` VALUES ('116', '酸奶机', '18');
INSERT INTO `pms_base_catalog3` VALUES ('117', '电炖锅', '18');
INSERT INTO `pms_base_catalog3` VALUES ('118', '电水壶/热水瓶', '18');
INSERT INTO `pms_base_catalog3` VALUES ('119', '电饼铛', '18');
INSERT INTO `pms_base_catalog3` VALUES ('120', '多用途锅', '18');
INSERT INTO `pms_base_catalog3` VALUES ('121', '电烧烤炉', '18');
INSERT INTO `pms_base_catalog3` VALUES ('122', '果蔬解毒机', '18');
INSERT INTO `pms_base_catalog3` VALUES ('123', '其它厨房电器', '18');
INSERT INTO `pms_base_catalog3` VALUES ('124', '养生壶/煎药壶', '18');
INSERT INTO `pms_base_catalog3` VALUES ('125', '电热饭盒', '18');
INSERT INTO `pms_base_catalog3` VALUES ('126', '取暖电器', '19');
INSERT INTO `pms_base_catalog3` VALUES ('127', '净化器', '19');
INSERT INTO `pms_base_catalog3` VALUES ('128', '加湿器', '19');
INSERT INTO `pms_base_catalog3` VALUES ('129', '扫地机器人', '19');
INSERT INTO `pms_base_catalog3` VALUES ('130', '吸尘器', '19');
INSERT INTO `pms_base_catalog3` VALUES ('131', '挂烫机/熨斗', '19');
INSERT INTO `pms_base_catalog3` VALUES ('132', '插座', '19');
INSERT INTO `pms_base_catalog3` VALUES ('133', '电话机', '19');
INSERT INTO `pms_base_catalog3` VALUES ('134', '清洁机', '19');
INSERT INTO `pms_base_catalog3` VALUES ('135', '除湿机', '19');
INSERT INTO `pms_base_catalog3` VALUES ('136', '干衣机', '19');
INSERT INTO `pms_base_catalog3` VALUES ('137', '收录/音机', '19');
INSERT INTO `pms_base_catalog3` VALUES ('138', '电风扇', '19');
INSERT INTO `pms_base_catalog3` VALUES ('139', '冷风扇', '19');
INSERT INTO `pms_base_catalog3` VALUES ('140', '其它生活电器', '19');
INSERT INTO `pms_base_catalog3` VALUES ('141', '生活电器配件', '19');
INSERT INTO `pms_base_catalog3` VALUES ('142', '净水器', '19');
INSERT INTO `pms_base_catalog3` VALUES ('143', '饮水机', '19');
INSERT INTO `pms_base_catalog3` VALUES ('144', '剃须刀', '20');
INSERT INTO `pms_base_catalog3` VALUES ('145', '剃/脱毛器', '20');
INSERT INTO `pms_base_catalog3` VALUES ('146', '口腔护理', '20');
INSERT INTO `pms_base_catalog3` VALUES ('147', '电吹风', '20');
INSERT INTO `pms_base_catalog3` VALUES ('148', '美容器', '20');
INSERT INTO `pms_base_catalog3` VALUES ('149', '理发器', '20');
INSERT INTO `pms_base_catalog3` VALUES ('150', '卷/直发器', '20');
INSERT INTO `pms_base_catalog3` VALUES ('151', '按摩椅', '20');
INSERT INTO `pms_base_catalog3` VALUES ('152', '按摩器', '20');
INSERT INTO `pms_base_catalog3` VALUES ('153', '足浴盆', '20');
INSERT INTO `pms_base_catalog3` VALUES ('154', '血压计', '20');
INSERT INTO `pms_base_catalog3` VALUES ('155', '电子秤/厨房秤', '20');
INSERT INTO `pms_base_catalog3` VALUES ('156', '血糖仪', '20');
INSERT INTO `pms_base_catalog3` VALUES ('157', '体温计', '20');
INSERT INTO `pms_base_catalog3` VALUES ('158', '其它健康电器', '20');
INSERT INTO `pms_base_catalog3` VALUES ('159', '计步器/脂肪检测仪', '20');
INSERT INTO `pms_base_catalog3` VALUES ('160', '电动工具', '21');
INSERT INTO `pms_base_catalog3` VALUES ('161', '手动工具', '21');
INSERT INTO `pms_base_catalog3` VALUES ('162', '仪器仪表', '21');
INSERT INTO `pms_base_catalog3` VALUES ('163', '浴霸/排气扇', '21');
INSERT INTO `pms_base_catalog3` VALUES ('164', '灯具', '21');
INSERT INTO `pms_base_catalog3` VALUES ('165', 'LED灯', '21');
INSERT INTO `pms_base_catalog3` VALUES ('166', '洁身器', '21');
INSERT INTO `pms_base_catalog3` VALUES ('167', '水槽', '21');
INSERT INTO `pms_base_catalog3` VALUES ('168', '龙头', '21');
INSERT INTO `pms_base_catalog3` VALUES ('169', '淋浴花洒', '21');
INSERT INTO `pms_base_catalog3` VALUES ('170', '厨卫五金', '21');
INSERT INTO `pms_base_catalog3` VALUES ('171', '家具五金', '21');
INSERT INTO `pms_base_catalog3` VALUES ('172', '门铃', '21');
INSERT INTO `pms_base_catalog3` VALUES ('173', '电气开关', '21');
INSERT INTO `pms_base_catalog3` VALUES ('174', '插座', '21');
INSERT INTO `pms_base_catalog3` VALUES ('175', '电工电料', '21');
INSERT INTO `pms_base_catalog3` VALUES ('176', '监控安防', '21');
INSERT INTO `pms_base_catalog3` VALUES ('177', '电线/线缆', '21');
INSERT INTO `pms_base_catalog3` VALUES ('178', '数码相机', '22');
INSERT INTO `pms_base_catalog3` VALUES ('179', '单电/微单相机', '22');
INSERT INTO `pms_base_catalog3` VALUES ('180', '单反相机', '22');
INSERT INTO `pms_base_catalog3` VALUES ('181', '摄像机', '22');
INSERT INTO `pms_base_catalog3` VALUES ('182', '拍立得', '22');
INSERT INTO `pms_base_catalog3` VALUES ('183', '运动相机', '22');
INSERT INTO `pms_base_catalog3` VALUES ('184', '镜头', '22');
INSERT INTO `pms_base_catalog3` VALUES ('185', '户外器材', '22');
INSERT INTO `pms_base_catalog3` VALUES ('186', '影棚器材', '22');
INSERT INTO `pms_base_catalog3` VALUES ('187', '冲印服务', '22');
INSERT INTO `pms_base_catalog3` VALUES ('188', '数码相框', '22');
INSERT INTO `pms_base_catalog3` VALUES ('189', '存储卡', '23');
INSERT INTO `pms_base_catalog3` VALUES ('190', '读卡器', '23');
INSERT INTO `pms_base_catalog3` VALUES ('191', '滤镜', '23');
INSERT INTO `pms_base_catalog3` VALUES ('192', '闪光灯/手柄', '23');
INSERT INTO `pms_base_catalog3` VALUES ('193', '相机包', '23');
INSERT INTO `pms_base_catalog3` VALUES ('194', '三脚架/云台', '23');
INSERT INTO `pms_base_catalog3` VALUES ('195', '相机清洁/贴膜', '23');
INSERT INTO `pms_base_catalog3` VALUES ('196', '机身附件', '23');
INSERT INTO `pms_base_catalog3` VALUES ('197', '镜头附件', '23');
INSERT INTO `pms_base_catalog3` VALUES ('198', '电池/充电器', '23');
INSERT INTO `pms_base_catalog3` VALUES ('199', '移动电源', '23');
INSERT INTO `pms_base_catalog3` VALUES ('200', '数码支架', '23');
INSERT INTO `pms_base_catalog3` VALUES ('201', '智能手环', '24');
INSERT INTO `pms_base_catalog3` VALUES ('202', '智能手表', '24');
INSERT INTO `pms_base_catalog3` VALUES ('203', '智能眼镜', '24');
INSERT INTO `pms_base_catalog3` VALUES ('204', '运动跟踪器', '24');
INSERT INTO `pms_base_catalog3` VALUES ('205', '健康监测', '24');
INSERT INTO `pms_base_catalog3` VALUES ('206', '智能配饰', '24');
INSERT INTO `pms_base_catalog3` VALUES ('207', '智能家居', '24');
INSERT INTO `pms_base_catalog3` VALUES ('208', '体感车', '24');
INSERT INTO `pms_base_catalog3` VALUES ('209', '其他配件', '24');
INSERT INTO `pms_base_catalog3` VALUES ('210', '智能机器人', '24');
INSERT INTO `pms_base_catalog3` VALUES ('211', '无人机', '24');
INSERT INTO `pms_base_catalog3` VALUES ('212', 'MP3/MP4', '25');
INSERT INTO `pms_base_catalog3` VALUES ('213', '智能设备', '25');
INSERT INTO `pms_base_catalog3` VALUES ('214', '耳机/耳麦', '25');
INSERT INTO `pms_base_catalog3` VALUES ('215', '便携/无线音箱', '25');
INSERT INTO `pms_base_catalog3` VALUES ('216', '音箱/音响', '25');
INSERT INTO `pms_base_catalog3` VALUES ('217', '高清播放器', '25');
INSERT INTO `pms_base_catalog3` VALUES ('218', '收音机', '25');
INSERT INTO `pms_base_catalog3` VALUES ('219', 'MP3/MP4配件', '25');
INSERT INTO `pms_base_catalog3` VALUES ('220', '麦克风', '25');
INSERT INTO `pms_base_catalog3` VALUES ('221', '专业音频', '25');
INSERT INTO `pms_base_catalog3` VALUES ('222', '苹果配件', '25');
INSERT INTO `pms_base_catalog3` VALUES ('223', '学生平板', '26');
INSERT INTO `pms_base_catalog3` VALUES ('224', '点读机/笔', '26');
INSERT INTO `pms_base_catalog3` VALUES ('225', '早教益智', '26');
INSERT INTO `pms_base_catalog3` VALUES ('226', '录音笔', '26');
INSERT INTO `pms_base_catalog3` VALUES ('227', '电纸书', '26');
INSERT INTO `pms_base_catalog3` VALUES ('228', '电子词典', '26');
INSERT INTO `pms_base_catalog3` VALUES ('229', '复读机', '26');
INSERT INTO `pms_base_catalog3` VALUES ('230', '延保服务', '27');
INSERT INTO `pms_base_catalog3` VALUES ('231', '杀毒软件', '27');
INSERT INTO `pms_base_catalog3` VALUES ('232', '积分商品', '27');
INSERT INTO `pms_base_catalog3` VALUES ('233', '桌布/罩件', '28');
INSERT INTO `pms_base_catalog3` VALUES ('234', '地毯地垫', '28');
INSERT INTO `pms_base_catalog3` VALUES ('235', '沙发垫套/椅垫', '28');
INSERT INTO `pms_base_catalog3` VALUES ('236', '床品套件', '28');
INSERT INTO `pms_base_catalog3` VALUES ('237', '被子', '28');
INSERT INTO `pms_base_catalog3` VALUES ('238', '枕芯', '28');
INSERT INTO `pms_base_catalog3` VALUES ('239', '床单被罩', '28');
INSERT INTO `pms_base_catalog3` VALUES ('240', '毯子', '28');
INSERT INTO `pms_base_catalog3` VALUES ('241', '床垫/床褥', '28');
INSERT INTO `pms_base_catalog3` VALUES ('242', '蚊帐', '28');
INSERT INTO `pms_base_catalog3` VALUES ('243', '抱枕靠垫', '28');
INSERT INTO `pms_base_catalog3` VALUES ('244', '毛巾浴巾', '28');
INSERT INTO `pms_base_catalog3` VALUES ('245', '电热毯', '28');
INSERT INTO `pms_base_catalog3` VALUES ('246', '窗帘/窗纱', '28');
INSERT INTO `pms_base_catalog3` VALUES ('247', '布艺软饰', '28');
INSERT INTO `pms_base_catalog3` VALUES ('248', '凉席', '28');
INSERT INTO `pms_base_catalog3` VALUES ('249', '台灯', '29');
INSERT INTO `pms_base_catalog3` VALUES ('250', '节能灯', '29');
INSERT INTO `pms_base_catalog3` VALUES ('251', '装饰灯', '29');
INSERT INTO `pms_base_catalog3` VALUES ('252', '落地灯', '29');
INSERT INTO `pms_base_catalog3` VALUES ('253', '应急灯/手电', '29');
INSERT INTO `pms_base_catalog3` VALUES ('254', 'LED灯', '29');
INSERT INTO `pms_base_catalog3` VALUES ('255', '吸顶灯', '29');
INSERT INTO `pms_base_catalog3` VALUES ('256', '五金电器', '29');
INSERT INTO `pms_base_catalog3` VALUES ('257', '筒灯射灯', '29');
INSERT INTO `pms_base_catalog3` VALUES ('258', '吊灯', '29');
INSERT INTO `pms_base_catalog3` VALUES ('259', '氛围照明', '29');
INSERT INTO `pms_base_catalog3` VALUES ('260', '保暖防护', '30');
INSERT INTO `pms_base_catalog3` VALUES ('261', '收纳用品', '30');
INSERT INTO `pms_base_catalog3` VALUES ('262', '雨伞雨具', '30');
INSERT INTO `pms_base_catalog3` VALUES ('263', '浴室用品', '30');
INSERT INTO `pms_base_catalog3` VALUES ('264', '缝纫/针织用品', '30');
INSERT INTO `pms_base_catalog3` VALUES ('265', '洗晒/熨烫', '30');
INSERT INTO `pms_base_catalog3` VALUES ('266', '净化除味', '30');
INSERT INTO `pms_base_catalog3` VALUES ('267', '相框/照片墙', '31');
INSERT INTO `pms_base_catalog3` VALUES ('268', '装饰字画', '31');
INSERT INTO `pms_base_catalog3` VALUES ('269', '节庆饰品', '31');
INSERT INTO `pms_base_catalog3` VALUES ('270', '手工/十字绣', '31');
INSERT INTO `pms_base_catalog3` VALUES ('271', '装饰摆件', '31');
INSERT INTO `pms_base_catalog3` VALUES ('272', '帘艺隔断', '31');
INSERT INTO `pms_base_catalog3` VALUES ('273', '墙贴/装饰贴', '31');
INSERT INTO `pms_base_catalog3` VALUES ('274', '钟饰', '31');
INSERT INTO `pms_base_catalog3` VALUES ('275', '花瓶花艺', '31');
INSERT INTO `pms_base_catalog3` VALUES ('276', '香薰蜡烛', '31');
INSERT INTO `pms_base_catalog3` VALUES ('277', '创意家居', '31');
INSERT INTO `pms_base_catalog3` VALUES ('278', '宠物主粮', '32');
INSERT INTO `pms_base_catalog3` VALUES ('279', '宠物零食', '32');
INSERT INTO `pms_base_catalog3` VALUES ('280', '医疗保健', '32');
INSERT INTO `pms_base_catalog3` VALUES ('281', '家居日用', '32');
INSERT INTO `pms_base_catalog3` VALUES ('282', '宠物玩具', '32');
INSERT INTO `pms_base_catalog3` VALUES ('283', '出行装备', '32');
INSERT INTO `pms_base_catalog3` VALUES ('284', '洗护美容', '32');
INSERT INTO `pms_base_catalog3` VALUES ('285', '笔记本', '33');
INSERT INTO `pms_base_catalog3` VALUES ('286', '超极本', '33');
INSERT INTO `pms_base_catalog3` VALUES ('287', '游戏本', '33');
INSERT INTO `pms_base_catalog3` VALUES ('288', '平板电脑', '33');
INSERT INTO `pms_base_catalog3` VALUES ('289', '平板电脑配件', '33');
INSERT INTO `pms_base_catalog3` VALUES ('290', '台式机', '33');
INSERT INTO `pms_base_catalog3` VALUES ('291', '服务器/工作站', '33');
INSERT INTO `pms_base_catalog3` VALUES ('292', '笔记本配件', '33');
INSERT INTO `pms_base_catalog3` VALUES ('293', '一体机', '33');
INSERT INTO `pms_base_catalog3` VALUES ('294', 'CPU', '34');
INSERT INTO `pms_base_catalog3` VALUES ('295', '主板', '34');
INSERT INTO `pms_base_catalog3` VALUES ('296', '显卡', '34');
INSERT INTO `pms_base_catalog3` VALUES ('297', '硬盘', '34');
INSERT INTO `pms_base_catalog3` VALUES ('298', 'SSD固态硬盘', '34');
INSERT INTO `pms_base_catalog3` VALUES ('299', '内存', '34');
INSERT INTO `pms_base_catalog3` VALUES ('300', '机箱', '34');
INSERT INTO `pms_base_catalog3` VALUES ('301', '电源', '34');
INSERT INTO `pms_base_catalog3` VALUES ('302', '显示器', '34');
INSERT INTO `pms_base_catalog3` VALUES ('303', '刻录机/光驱', '34');
INSERT INTO `pms_base_catalog3` VALUES ('304', '散热器', '34');
INSERT INTO `pms_base_catalog3` VALUES ('305', '声卡/扩展卡', '34');
INSERT INTO `pms_base_catalog3` VALUES ('306', '装机配件', '34');
INSERT INTO `pms_base_catalog3` VALUES ('307', '组装电脑', '34');
INSERT INTO `pms_base_catalog3` VALUES ('308', '移动硬盘', '35');
INSERT INTO `pms_base_catalog3` VALUES ('309', 'U盘', '35');
INSERT INTO `pms_base_catalog3` VALUES ('310', '鼠标', '35');
INSERT INTO `pms_base_catalog3` VALUES ('311', '键盘', '35');
INSERT INTO `pms_base_catalog3` VALUES ('312', '鼠标垫', '35');
INSERT INTO `pms_base_catalog3` VALUES ('313', '摄像头', '35');
INSERT INTO `pms_base_catalog3` VALUES ('314', '手写板', '35');
INSERT INTO `pms_base_catalog3` VALUES ('315', '硬盘盒', '35');
INSERT INTO `pms_base_catalog3` VALUES ('316', '插座', '35');
INSERT INTO `pms_base_catalog3` VALUES ('317', '线缆', '35');
INSERT INTO `pms_base_catalog3` VALUES ('318', 'UPS电源', '35');
INSERT INTO `pms_base_catalog3` VALUES ('319', '电脑工具', '35');
INSERT INTO `pms_base_catalog3` VALUES ('320', '游戏设备', '35');
INSERT INTO `pms_base_catalog3` VALUES ('321', '电玩', '35');
INSERT INTO `pms_base_catalog3` VALUES ('322', '电脑清洁', '35');
INSERT INTO `pms_base_catalog3` VALUES ('323', '网络仪表仪器', '35');
INSERT INTO `pms_base_catalog3` VALUES ('324', '游戏机', '36');
INSERT INTO `pms_base_catalog3` VALUES ('325', '游戏耳机', '36');
INSERT INTO `pms_base_catalog3` VALUES ('326', '手柄/方向盘', '36');
INSERT INTO `pms_base_catalog3` VALUES ('327', '游戏软件', '36');
INSERT INTO `pms_base_catalog3` VALUES ('328', '游戏周边', '36');
INSERT INTO `pms_base_catalog3` VALUES ('329', '路由器', '37');
INSERT INTO `pms_base_catalog3` VALUES ('330', '网卡', '37');
INSERT INTO `pms_base_catalog3` VALUES ('331', '交换机', '37');
INSERT INTO `pms_base_catalog3` VALUES ('332', '网络存储', '37');
INSERT INTO `pms_base_catalog3` VALUES ('333', '4G/3G上网', '37');
INSERT INTO `pms_base_catalog3` VALUES ('334', '网络盒子', '37');
INSERT INTO `pms_base_catalog3` VALUES ('335', '网络配件', '37');
INSERT INTO `pms_base_catalog3` VALUES ('336', '投影机', '38');
INSERT INTO `pms_base_catalog3` VALUES ('337', '投影配件', '38');
INSERT INTO `pms_base_catalog3` VALUES ('338', '多功能一体机', '38');
INSERT INTO `pms_base_catalog3` VALUES ('339', '打印机', '38');
INSERT INTO `pms_base_catalog3` VALUES ('340', '传真设备', '38');
INSERT INTO `pms_base_catalog3` VALUES ('341', '验钞/点钞机', '38');
INSERT INTO `pms_base_catalog3` VALUES ('342', '扫描设备', '38');
INSERT INTO `pms_base_catalog3` VALUES ('343', '复合机', '38');
INSERT INTO `pms_base_catalog3` VALUES ('344', '碎纸机', '38');
INSERT INTO `pms_base_catalog3` VALUES ('345', '考勤机', '38');
INSERT INTO `pms_base_catalog3` VALUES ('346', '收款/POS机', '38');
INSERT INTO `pms_base_catalog3` VALUES ('347', '会议音频视频', '38');
INSERT INTO `pms_base_catalog3` VALUES ('348', '保险柜', '38');
INSERT INTO `pms_base_catalog3` VALUES ('349', '装订/封装机', '38');
INSERT INTO `pms_base_catalog3` VALUES ('350', '安防监控', '38');
INSERT INTO `pms_base_catalog3` VALUES ('351', '办公家具', '38');
INSERT INTO `pms_base_catalog3` VALUES ('352', '白板', '38');
INSERT INTO `pms_base_catalog3` VALUES ('353', '硒鼓/墨粉', '39');
INSERT INTO `pms_base_catalog3` VALUES ('354', '墨盒', '39');
INSERT INTO `pms_base_catalog3` VALUES ('355', '色带', '39');
INSERT INTO `pms_base_catalog3` VALUES ('356', '纸类', '39');
INSERT INTO `pms_base_catalog3` VALUES ('357', '办公文具', '39');
INSERT INTO `pms_base_catalog3` VALUES ('358', '学生文具', '39');
INSERT INTO `pms_base_catalog3` VALUES ('359', '财会用品', '39');
INSERT INTO `pms_base_catalog3` VALUES ('360', '文件管理', '39');
INSERT INTO `pms_base_catalog3` VALUES ('361', '本册/便签', '39');
INSERT INTO `pms_base_catalog3` VALUES ('362', '计算器', '39');
INSERT INTO `pms_base_catalog3` VALUES ('363', '笔类', '39');
INSERT INTO `pms_base_catalog3` VALUES ('364', '画具画材', '39');
INSERT INTO `pms_base_catalog3` VALUES ('365', '刻录碟片/附件', '39');
INSERT INTO `pms_base_catalog3` VALUES ('366', '上门安装', '40');
INSERT INTO `pms_base_catalog3` VALUES ('367', '延保服务', '40');
INSERT INTO `pms_base_catalog3` VALUES ('368', '维修保养', '40');
INSERT INTO `pms_base_catalog3` VALUES ('369', '电脑软件', '40');
INSERT INTO `pms_base_catalog3` VALUES ('370', '京东服务', '40');
INSERT INTO `pms_base_catalog3` VALUES ('371', '炒锅', '41');
INSERT INTO `pms_base_catalog3` VALUES ('372', '煎锅', '41');
INSERT INTO `pms_base_catalog3` VALUES ('373', '压力锅', '41');
INSERT INTO `pms_base_catalog3` VALUES ('374', '蒸锅', '41');
INSERT INTO `pms_base_catalog3` VALUES ('375', '汤锅', '41');
INSERT INTO `pms_base_catalog3` VALUES ('376', '奶锅', '41');
INSERT INTO `pms_base_catalog3` VALUES ('377', '锅具套装', '41');
INSERT INTO `pms_base_catalog3` VALUES ('378', '煲类', '41');
INSERT INTO `pms_base_catalog3` VALUES ('379', '水壶', '41');
INSERT INTO `pms_base_catalog3` VALUES ('380', '火锅', '41');
INSERT INTO `pms_base_catalog3` VALUES ('381', '菜刀', '42');
INSERT INTO `pms_base_catalog3` VALUES ('382', '剪刀', '42');
INSERT INTO `pms_base_catalog3` VALUES ('383', '刀具套装', '42');
INSERT INTO `pms_base_catalog3` VALUES ('384', '砧板', '42');
INSERT INTO `pms_base_catalog3` VALUES ('385', '瓜果刀/刨', '42');
INSERT INTO `pms_base_catalog3` VALUES ('386', '多功能刀', '42');
INSERT INTO `pms_base_catalog3` VALUES ('387', '保鲜盒', '43');
INSERT INTO `pms_base_catalog3` VALUES ('388', '烘焙/烧烤', '43');
INSERT INTO `pms_base_catalog3` VALUES ('389', '饭盒/提锅', '43');
INSERT INTO `pms_base_catalog3` VALUES ('390', '储物/置物架', '43');
INSERT INTO `pms_base_catalog3` VALUES ('391', '厨房DIY/小工具', '43');
INSERT INTO `pms_base_catalog3` VALUES ('392', '塑料杯', '44');
INSERT INTO `pms_base_catalog3` VALUES ('393', '运动水壶', '44');
INSERT INTO `pms_base_catalog3` VALUES ('394', '玻璃杯', '44');
INSERT INTO `pms_base_catalog3` VALUES ('395', '陶瓷/马克杯', '44');
INSERT INTO `pms_base_catalog3` VALUES ('396', '保温杯', '44');
INSERT INTO `pms_base_catalog3` VALUES ('397', '保温壶', '44');
INSERT INTO `pms_base_catalog3` VALUES ('398', '酒杯/酒具', '44');
INSERT INTO `pms_base_catalog3` VALUES ('399', '杯具套装', '44');
INSERT INTO `pms_base_catalog3` VALUES ('400', '餐具套装', '45');
INSERT INTO `pms_base_catalog3` VALUES ('401', '碗/碟/盘', '45');
INSERT INTO `pms_base_catalog3` VALUES ('402', '筷勺/刀叉', '45');
INSERT INTO `pms_base_catalog3` VALUES ('403', '一次性用品', '45');
INSERT INTO `pms_base_catalog3` VALUES ('404', '果盘/果篮', '45');
INSERT INTO `pms_base_catalog3` VALUES ('405', '自助餐炉', '46');
INSERT INTO `pms_base_catalog3` VALUES ('406', '酒店餐具', '46');
INSERT INTO `pms_base_catalog3` VALUES ('407', '酒店水具', '46');
INSERT INTO `pms_base_catalog3` VALUES ('408', '整套茶具', '47');
INSERT INTO `pms_base_catalog3` VALUES ('409', '茶杯', '47');
INSERT INTO `pms_base_catalog3` VALUES ('410', '茶壶', '47');
INSERT INTO `pms_base_catalog3` VALUES ('411', '茶盘茶托', '47');
INSERT INTO `pms_base_catalog3` VALUES ('412', '茶叶罐', '47');
INSERT INTO `pms_base_catalog3` VALUES ('413', '茶具配件', '47');
INSERT INTO `pms_base_catalog3` VALUES ('414', '茶宠摆件', '47');
INSERT INTO `pms_base_catalog3` VALUES ('415', '咖啡具', '47');
INSERT INTO `pms_base_catalog3` VALUES ('416', '其他', '47');
INSERT INTO `pms_base_catalog3` VALUES ('417', '纸品湿巾', '48');
INSERT INTO `pms_base_catalog3` VALUES ('418', '衣物清洁', '48');
INSERT INTO `pms_base_catalog3` VALUES ('419', '清洁工具', '48');
INSERT INTO `pms_base_catalog3` VALUES ('420', '驱虫用品', '48');
INSERT INTO `pms_base_catalog3` VALUES ('421', '家庭清洁', '48');
INSERT INTO `pms_base_catalog3` VALUES ('422', '皮具护理', '48');
INSERT INTO `pms_base_catalog3` VALUES ('423', '一次性用品', '48');
INSERT INTO `pms_base_catalog3` VALUES ('424', '洁面', '49');
INSERT INTO `pms_base_catalog3` VALUES ('425', '乳液面霜', '49');
INSERT INTO `pms_base_catalog3` VALUES ('426', '面膜', '49');
INSERT INTO `pms_base_catalog3` VALUES ('427', '剃须', '49');
INSERT INTO `pms_base_catalog3` VALUES ('428', '套装', '49');
INSERT INTO `pms_base_catalog3` VALUES ('429', '精华', '49');
INSERT INTO `pms_base_catalog3` VALUES ('430', '眼霜', '49');
INSERT INTO `pms_base_catalog3` VALUES ('431', '卸妆', '49');
INSERT INTO `pms_base_catalog3` VALUES ('432', '防晒', '49');
INSERT INTO `pms_base_catalog3` VALUES ('433', '防晒隔离', '49');
INSERT INTO `pms_base_catalog3` VALUES ('434', 'T区护理', '49');
INSERT INTO `pms_base_catalog3` VALUES ('435', '眼部护理', '49');
INSERT INTO `pms_base_catalog3` VALUES ('436', '精华露', '49');
INSERT INTO `pms_base_catalog3` VALUES ('437', '爽肤水', '49');
INSERT INTO `pms_base_catalog3` VALUES ('438', '沐浴', '50');
INSERT INTO `pms_base_catalog3` VALUES ('439', '润肤', '50');
INSERT INTO `pms_base_catalog3` VALUES ('440', '颈部', '50');
INSERT INTO `pms_base_catalog3` VALUES ('441', '手足', '50');
INSERT INTO `pms_base_catalog3` VALUES ('442', '纤体塑形', '50');
INSERT INTO `pms_base_catalog3` VALUES ('443', '美胸', '50');
INSERT INTO `pms_base_catalog3` VALUES ('444', '套装', '50');
INSERT INTO `pms_base_catalog3` VALUES ('445', '精油', '50');
INSERT INTO `pms_base_catalog3` VALUES ('446', '洗发护发', '50');
INSERT INTO `pms_base_catalog3` VALUES ('447', '染发/造型', '50');
INSERT INTO `pms_base_catalog3` VALUES ('448', '香薰精油', '50');
INSERT INTO `pms_base_catalog3` VALUES ('449', '磨砂/浴盐', '50');
INSERT INTO `pms_base_catalog3` VALUES ('450', '手工/香皂', '50');
INSERT INTO `pms_base_catalog3` VALUES ('451', '洗发', '50');
INSERT INTO `pms_base_catalog3` VALUES ('452', '护发', '50');
INSERT INTO `pms_base_catalog3` VALUES ('453', '染发', '50');
INSERT INTO `pms_base_catalog3` VALUES ('454', '磨砂膏', '50');
INSERT INTO `pms_base_catalog3` VALUES ('455', '香皂', '50');
INSERT INTO `pms_base_catalog3` VALUES ('456', '牙膏/牙粉', '51');
INSERT INTO `pms_base_catalog3` VALUES ('457', '牙刷/牙线', '51');
INSERT INTO `pms_base_catalog3` VALUES ('458', '漱口水', '51');
INSERT INTO `pms_base_catalog3` VALUES ('459', '套装', '51');
INSERT INTO `pms_base_catalog3` VALUES ('460', '卫生巾', '52');
INSERT INTO `pms_base_catalog3` VALUES ('461', '卫生护垫', '52');
INSERT INTO `pms_base_catalog3` VALUES ('462', '私密护理', '52');
INSERT INTO `pms_base_catalog3` VALUES ('463', '脱毛膏', '52');
INSERT INTO `pms_base_catalog3` VALUES ('464', '其他', '52');
INSERT INTO `pms_base_catalog3` VALUES ('465', '洗发', '53');
INSERT INTO `pms_base_catalog3` VALUES ('466', '护发', '53');
INSERT INTO `pms_base_catalog3` VALUES ('467', '染发', '53');
INSERT INTO `pms_base_catalog3` VALUES ('468', '造型', '53');
INSERT INTO `pms_base_catalog3` VALUES ('469', '假发', '53');
INSERT INTO `pms_base_catalog3` VALUES ('470', '套装', '53');
INSERT INTO `pms_base_catalog3` VALUES ('471', '美发工具', '53');
INSERT INTO `pms_base_catalog3` VALUES ('472', '脸部护理', '53');
INSERT INTO `pms_base_catalog3` VALUES ('473', '香水', '54');
INSERT INTO `pms_base_catalog3` VALUES ('474', '底妆', '54');
INSERT INTO `pms_base_catalog3` VALUES ('475', '腮红', '54');
INSERT INTO `pms_base_catalog3` VALUES ('476', '眼影', '54');
INSERT INTO `pms_base_catalog3` VALUES ('477', '唇部', '54');
INSERT INTO `pms_base_catalog3` VALUES ('478', '美甲', '54');
INSERT INTO `pms_base_catalog3` VALUES ('479', '眼线', '54');
INSERT INTO `pms_base_catalog3` VALUES ('480', '美妆工具', '54');
INSERT INTO `pms_base_catalog3` VALUES ('481', '套装', '54');
INSERT INTO `pms_base_catalog3` VALUES ('482', '防晒隔离', '54');
INSERT INTO `pms_base_catalog3` VALUES ('483', '卸妆', '54');
INSERT INTO `pms_base_catalog3` VALUES ('484', '眉笔', '54');
INSERT INTO `pms_base_catalog3` VALUES ('485', '睫毛膏', '54');
INSERT INTO `pms_base_catalog3` VALUES ('486', 'T恤', '55');
INSERT INTO `pms_base_catalog3` VALUES ('487', '衬衫', '55');
INSERT INTO `pms_base_catalog3` VALUES ('488', '针织衫', '55');
INSERT INTO `pms_base_catalog3` VALUES ('489', '雪纺衫', '55');
INSERT INTO `pms_base_catalog3` VALUES ('490', '卫衣', '55');
INSERT INTO `pms_base_catalog3` VALUES ('491', '马甲', '55');
INSERT INTO `pms_base_catalog3` VALUES ('492', '连衣裙', '55');
INSERT INTO `pms_base_catalog3` VALUES ('493', '半身裙', '55');
INSERT INTO `pms_base_catalog3` VALUES ('494', '牛仔裤', '55');
INSERT INTO `pms_base_catalog3` VALUES ('495', '休闲裤', '55');
INSERT INTO `pms_base_catalog3` VALUES ('496', '打底裤', '55');
INSERT INTO `pms_base_catalog3` VALUES ('497', '正装裤', '55');
INSERT INTO `pms_base_catalog3` VALUES ('498', '小西装', '55');
INSERT INTO `pms_base_catalog3` VALUES ('499', '短外套', '55');
INSERT INTO `pms_base_catalog3` VALUES ('500', '风衣', '55');
INSERT INTO `pms_base_catalog3` VALUES ('501', '毛呢大衣', '55');
INSERT INTO `pms_base_catalog3` VALUES ('502', '真皮皮衣', '55');
INSERT INTO `pms_base_catalog3` VALUES ('503', '棉服', '55');
INSERT INTO `pms_base_catalog3` VALUES ('504', '羽绒服', '55');
INSERT INTO `pms_base_catalog3` VALUES ('505', '大码女装', '55');
INSERT INTO `pms_base_catalog3` VALUES ('506', '中老年女装', '55');
INSERT INTO `pms_base_catalog3` VALUES ('507', '婚纱', '55');
INSERT INTO `pms_base_catalog3` VALUES ('508', '打底衫', '55');
INSERT INTO `pms_base_catalog3` VALUES ('509', '旗袍/唐装', '55');
INSERT INTO `pms_base_catalog3` VALUES ('510', '加绒裤', '55');
INSERT INTO `pms_base_catalog3` VALUES ('511', '吊带/背心', '55');
INSERT INTO `pms_base_catalog3` VALUES ('512', '羊绒衫', '55');
INSERT INTO `pms_base_catalog3` VALUES ('513', '短裤', '55');
INSERT INTO `pms_base_catalog3` VALUES ('514', '皮草', '55');
INSERT INTO `pms_base_catalog3` VALUES ('515', '礼服', '55');
INSERT INTO `pms_base_catalog3` VALUES ('516', '仿皮皮衣', '55');
INSERT INTO `pms_base_catalog3` VALUES ('517', '羊毛衫', '55');
INSERT INTO `pms_base_catalog3` VALUES ('518', '设计师/潮牌', '55');
INSERT INTO `pms_base_catalog3` VALUES ('519', '衬衫', '56');
INSERT INTO `pms_base_catalog3` VALUES ('520', 'T恤', '56');
INSERT INTO `pms_base_catalog3` VALUES ('521', 'POLO衫', '56');
INSERT INTO `pms_base_catalog3` VALUES ('522', '针织衫', '56');
INSERT INTO `pms_base_catalog3` VALUES ('523', '羊绒衫', '56');
INSERT INTO `pms_base_catalog3` VALUES ('524', '卫衣', '56');
INSERT INTO `pms_base_catalog3` VALUES ('525', '马甲/背心', '56');
INSERT INTO `pms_base_catalog3` VALUES ('526', '夹克', '56');
INSERT INTO `pms_base_catalog3` VALUES ('527', '风衣', '56');
INSERT INTO `pms_base_catalog3` VALUES ('528', '毛呢大衣', '56');
INSERT INTO `pms_base_catalog3` VALUES ('529', '仿皮皮衣', '56');
INSERT INTO `pms_base_catalog3` VALUES ('530', '西服', '56');
INSERT INTO `pms_base_catalog3` VALUES ('531', '棉服', '56');
INSERT INTO `pms_base_catalog3` VALUES ('532', '羽绒服', '56');
INSERT INTO `pms_base_catalog3` VALUES ('533', '牛仔裤', '56');
INSERT INTO `pms_base_catalog3` VALUES ('534', '休闲裤', '56');
INSERT INTO `pms_base_catalog3` VALUES ('535', '西裤', '56');
INSERT INTO `pms_base_catalog3` VALUES ('536', '西服套装', '56');
INSERT INTO `pms_base_catalog3` VALUES ('537', '大码男装', '56');
INSERT INTO `pms_base_catalog3` VALUES ('538', '中老年男装', '56');
INSERT INTO `pms_base_catalog3` VALUES ('539', '唐装/中山装', '56');
INSERT INTO `pms_base_catalog3` VALUES ('540', '工装', '56');
INSERT INTO `pms_base_catalog3` VALUES ('541', '真皮皮衣', '56');
INSERT INTO `pms_base_catalog3` VALUES ('542', '加绒裤', '56');
INSERT INTO `pms_base_catalog3` VALUES ('543', '卫裤/运动裤', '56');
INSERT INTO `pms_base_catalog3` VALUES ('544', '短裤', '56');
INSERT INTO `pms_base_catalog3` VALUES ('545', '设计师/潮牌', '56');
INSERT INTO `pms_base_catalog3` VALUES ('546', '羊毛衫', '56');
INSERT INTO `pms_base_catalog3` VALUES ('547', '文胸', '57');
INSERT INTO `pms_base_catalog3` VALUES ('548', '女式内裤', '57');
INSERT INTO `pms_base_catalog3` VALUES ('549', '男式内裤', '57');
INSERT INTO `pms_base_catalog3` VALUES ('550', '睡衣/家居服', '57');
INSERT INTO `pms_base_catalog3` VALUES ('551', '塑身美体', '57');
INSERT INTO `pms_base_catalog3` VALUES ('552', '泳衣', '57');
INSERT INTO `pms_base_catalog3` VALUES ('553', '吊带/背心', '57');
INSERT INTO `pms_base_catalog3` VALUES ('554', '抹胸', '57');
INSERT INTO `pms_base_catalog3` VALUES ('555', '连裤袜/丝袜', '57');
INSERT INTO `pms_base_catalog3` VALUES ('556', '美腿袜', '57');
INSERT INTO `pms_base_catalog3` VALUES ('557', '商务男袜', '57');
INSERT INTO `pms_base_catalog3` VALUES ('558', '保暖内衣', '57');
INSERT INTO `pms_base_catalog3` VALUES ('559', '情侣睡衣', '57');
INSERT INTO `pms_base_catalog3` VALUES ('560', '文胸套装', '57');
INSERT INTO `pms_base_catalog3` VALUES ('561', '少女文胸', '57');
INSERT INTO `pms_base_catalog3` VALUES ('562', '休闲棉袜', '57');
INSERT INTO `pms_base_catalog3` VALUES ('563', '大码内衣', '57');
INSERT INTO `pms_base_catalog3` VALUES ('564', '内衣配件', '57');
INSERT INTO `pms_base_catalog3` VALUES ('565', '打底裤袜', '57');
INSERT INTO `pms_base_catalog3` VALUES ('566', '打底衫', '57');
INSERT INTO `pms_base_catalog3` VALUES ('567', '秋衣秋裤', '57');
INSERT INTO `pms_base_catalog3` VALUES ('568', '情趣内衣', '57');
INSERT INTO `pms_base_catalog3` VALUES ('569', '服装洗护', '58');
INSERT INTO `pms_base_catalog3` VALUES ('570', '太阳镜', '59');
INSERT INTO `pms_base_catalog3` VALUES ('571', '光学镜架/镜片', '59');
INSERT INTO `pms_base_catalog3` VALUES ('572', '围巾/手套/帽子套装', '59');
INSERT INTO `pms_base_catalog3` VALUES ('573', '袖扣', '59');
INSERT INTO `pms_base_catalog3` VALUES ('574', '棒球帽', '59');
INSERT INTO `pms_base_catalog3` VALUES ('575', '毛线帽', '59');
INSERT INTO `pms_base_catalog3` VALUES ('576', '遮阳帽', '59');
INSERT INTO `pms_base_catalog3` VALUES ('577', '老花镜', '59');
INSERT INTO `pms_base_catalog3` VALUES ('578', '装饰眼镜', '59');
INSERT INTO `pms_base_catalog3` VALUES ('579', '防辐射眼镜', '59');
INSERT INTO `pms_base_catalog3` VALUES ('580', '游泳镜', '59');
INSERT INTO `pms_base_catalog3` VALUES ('581', '女士丝巾/围巾/披肩', '59');
INSERT INTO `pms_base_catalog3` VALUES ('582', '男士丝巾/围巾', '59');
INSERT INTO `pms_base_catalog3` VALUES ('583', '鸭舌帽', '59');
INSERT INTO `pms_base_catalog3` VALUES ('584', '贝雷帽', '59');
INSERT INTO `pms_base_catalog3` VALUES ('585', '礼帽', '59');
INSERT INTO `pms_base_catalog3` VALUES ('586', '真皮手套', '59');
INSERT INTO `pms_base_catalog3` VALUES ('587', '毛线手套', '59');
INSERT INTO `pms_base_catalog3` VALUES ('588', '防晒手套', '59');
INSERT INTO `pms_base_catalog3` VALUES ('589', '男士腰带/礼盒', '59');
INSERT INTO `pms_base_catalog3` VALUES ('590', '女士腰带/礼盒', '59');
INSERT INTO `pms_base_catalog3` VALUES ('591', '钥匙扣', '59');
INSERT INTO `pms_base_catalog3` VALUES ('592', '遮阳伞/雨伞', '59');
INSERT INTO `pms_base_catalog3` VALUES ('593', '口罩', '59');
INSERT INTO `pms_base_catalog3` VALUES ('594', '耳罩/耳包', '59');
INSERT INTO `pms_base_catalog3` VALUES ('595', '假领', '59');
INSERT INTO `pms_base_catalog3` VALUES ('596', '毛线/布面料', '59');
INSERT INTO `pms_base_catalog3` VALUES ('597', '领带/领结/领带夹', '59');
INSERT INTO `pms_base_catalog3` VALUES ('598', '男表', '60');
INSERT INTO `pms_base_catalog3` VALUES ('599', '瑞表', '60');
INSERT INTO `pms_base_catalog3` VALUES ('600', '女表', '60');
INSERT INTO `pms_base_catalog3` VALUES ('601', '国表', '60');
INSERT INTO `pms_base_catalog3` VALUES ('602', '日韩表', '60');
INSERT INTO `pms_base_catalog3` VALUES ('603', '欧美表', '60');
INSERT INTO `pms_base_catalog3` VALUES ('604', '德表', '60');
INSERT INTO `pms_base_catalog3` VALUES ('605', '儿童手表', '60');
INSERT INTO `pms_base_catalog3` VALUES ('606', '智能手表', '60');
INSERT INTO `pms_base_catalog3` VALUES ('607', '闹钟', '60');
INSERT INTO `pms_base_catalog3` VALUES ('608', '座钟挂钟', '60');
INSERT INTO `pms_base_catalog3` VALUES ('609', '钟表配件', '60');
INSERT INTO `pms_base_catalog3` VALUES ('610', '商务休闲鞋', '61');
INSERT INTO `pms_base_catalog3` VALUES ('611', '正装鞋', '61');
INSERT INTO `pms_base_catalog3` VALUES ('612', '休闲鞋', '61');
INSERT INTO `pms_base_catalog3` VALUES ('613', '凉鞋/沙滩鞋', '61');
INSERT INTO `pms_base_catalog3` VALUES ('614', '男靴', '61');
INSERT INTO `pms_base_catalog3` VALUES ('615', '功能鞋', '61');
INSERT INTO `pms_base_catalog3` VALUES ('616', '拖鞋/人字拖', '61');
INSERT INTO `pms_base_catalog3` VALUES ('617', '雨鞋/雨靴', '61');
INSERT INTO `pms_base_catalog3` VALUES ('618', '传统布鞋', '61');
INSERT INTO `pms_base_catalog3` VALUES ('619', '鞋配件', '61');
INSERT INTO `pms_base_catalog3` VALUES ('620', '帆布鞋', '61');
INSERT INTO `pms_base_catalog3` VALUES ('621', '增高鞋', '61');
INSERT INTO `pms_base_catalog3` VALUES ('622', '工装鞋', '61');
INSERT INTO `pms_base_catalog3` VALUES ('623', '定制鞋', '61');
INSERT INTO `pms_base_catalog3` VALUES ('624', '高跟鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('625', '单鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('626', '休闲鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('627', '凉鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('628', '女靴', '62');
INSERT INTO `pms_base_catalog3` VALUES ('629', '雪地靴', '62');
INSERT INTO `pms_base_catalog3` VALUES ('630', '拖鞋/人字拖', '62');
INSERT INTO `pms_base_catalog3` VALUES ('631', '踝靴', '62');
INSERT INTO `pms_base_catalog3` VALUES ('632', '筒靴', '62');
INSERT INTO `pms_base_catalog3` VALUES ('633', '帆布鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('634', '雨鞋/雨靴', '62');
INSERT INTO `pms_base_catalog3` VALUES ('635', '妈妈鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('636', '鞋配件', '62');
INSERT INTO `pms_base_catalog3` VALUES ('637', '特色鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('638', '鱼嘴鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('639', '布鞋/绣花鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('640', '马丁靴', '62');
INSERT INTO `pms_base_catalog3` VALUES ('641', '坡跟鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('642', '松糕鞋', '62');
INSERT INTO `pms_base_catalog3` VALUES ('643', '内增高', '62');
INSERT INTO `pms_base_catalog3` VALUES ('644', '防水台', '62');
INSERT INTO `pms_base_catalog3` VALUES ('645', '婴幼奶粉', '63');
INSERT INTO `pms_base_catalog3` VALUES ('646', '孕妈奶粉', '63');
INSERT INTO `pms_base_catalog3` VALUES ('647', '益生菌/初乳', '64');
INSERT INTO `pms_base_catalog3` VALUES ('648', '米粉/菜粉', '64');
INSERT INTO `pms_base_catalog3` VALUES ('649', '果泥/果汁', '64');
INSERT INTO `pms_base_catalog3` VALUES ('650', 'DHA', '64');
INSERT INTO `pms_base_catalog3` VALUES ('651', '宝宝零食', '64');
INSERT INTO `pms_base_catalog3` VALUES ('652', '钙铁锌/维生素', '64');
INSERT INTO `pms_base_catalog3` VALUES ('653', '清火/开胃', '64');
INSERT INTO `pms_base_catalog3` VALUES ('654', '面条/粥', '64');
INSERT INTO `pms_base_catalog3` VALUES ('655', '婴儿尿裤', '65');
INSERT INTO `pms_base_catalog3` VALUES ('656', '拉拉裤', '65');
INSERT INTO `pms_base_catalog3` VALUES ('657', '婴儿湿巾', '65');
INSERT INTO `pms_base_catalog3` VALUES ('658', '成人尿裤', '65');
INSERT INTO `pms_base_catalog3` VALUES ('659', '奶瓶奶嘴', '66');
INSERT INTO `pms_base_catalog3` VALUES ('660', '吸奶器', '66');
INSERT INTO `pms_base_catalog3` VALUES ('661', '暖奶消毒', '66');
INSERT INTO `pms_base_catalog3` VALUES ('662', '儿童餐具', '66');
INSERT INTO `pms_base_catalog3` VALUES ('663', '水壶/水杯', '66');
INSERT INTO `pms_base_catalog3` VALUES ('664', '牙胶安抚', '66');
INSERT INTO `pms_base_catalog3` VALUES ('665', '围兜/防溅衣', '66');
INSERT INTO `pms_base_catalog3` VALUES ('666', '辅食料理机', '66');
INSERT INTO `pms_base_catalog3` VALUES ('667', '食物存储', '66');
INSERT INTO `pms_base_catalog3` VALUES ('668', '宝宝护肤', '67');
INSERT INTO `pms_base_catalog3` VALUES ('669', '洗发沐浴', '67');
INSERT INTO `pms_base_catalog3` VALUES ('670', '奶瓶清洗', '67');
INSERT INTO `pms_base_catalog3` VALUES ('671', '驱蚊防晒', '67');
INSERT INTO `pms_base_catalog3` VALUES ('672', '理发器', '67');
INSERT INTO `pms_base_catalog3` VALUES ('673', '洗澡用具', '67');
INSERT INTO `pms_base_catalog3` VALUES ('674', '婴儿口腔清洁', '67');
INSERT INTO `pms_base_catalog3` VALUES ('675', '洗衣液/皂', '67');
INSERT INTO `pms_base_catalog3` VALUES ('676', '日常护理', '67');
INSERT INTO `pms_base_catalog3` VALUES ('677', '座便器', '67');
INSERT INTO `pms_base_catalog3` VALUES ('678', '婴儿推车', '68');
INSERT INTO `pms_base_catalog3` VALUES ('679', '餐椅摇椅', '68');
INSERT INTO `pms_base_catalog3` VALUES ('680', '婴儿床', '68');
INSERT INTO `pms_base_catalog3` VALUES ('681', '学步车', '68');
INSERT INTO `pms_base_catalog3` VALUES ('682', '三轮车', '68');
INSERT INTO `pms_base_catalog3` VALUES ('683', '自行车', '68');
INSERT INTO `pms_base_catalog3` VALUES ('684', '电动车', '68');
INSERT INTO `pms_base_catalog3` VALUES ('685', '扭扭车', '68');
INSERT INTO `pms_base_catalog3` VALUES ('686', '滑板车', '68');
INSERT INTO `pms_base_catalog3` VALUES ('687', '婴儿床垫', '68');
INSERT INTO `pms_base_catalog3` VALUES ('688', '婴儿外出服', '69');
INSERT INTO `pms_base_catalog3` VALUES ('689', '婴儿内衣', '69');
INSERT INTO `pms_base_catalog3` VALUES ('690', '婴儿礼盒', '69');
INSERT INTO `pms_base_catalog3` VALUES ('691', '婴儿鞋帽袜', '69');
INSERT INTO `pms_base_catalog3` VALUES ('692', '安全防护', '69');
INSERT INTO `pms_base_catalog3` VALUES ('693', '家居床品', '69');
INSERT INTO `pms_base_catalog3` VALUES ('694', '睡袋/抱被', '69');
INSERT INTO `pms_base_catalog3` VALUES ('695', '爬行垫', '69');
INSERT INTO `pms_base_catalog3` VALUES ('696', '妈咪包/背婴带', '70');
INSERT INTO `pms_base_catalog3` VALUES ('697', '产后塑身', '70');
INSERT INTO `pms_base_catalog3` VALUES ('698', '文胸/内裤', '70');
INSERT INTO `pms_base_catalog3` VALUES ('699', '防辐射服', '70');
INSERT INTO `pms_base_catalog3` VALUES ('700', '孕妈装', '70');
INSERT INTO `pms_base_catalog3` VALUES ('701', '孕期营养', '70');
INSERT INTO `pms_base_catalog3` VALUES ('702', '孕妇护肤', '70');
INSERT INTO `pms_base_catalog3` VALUES ('703', '待产护理', '70');
INSERT INTO `pms_base_catalog3` VALUES ('704', '月子装', '70');
INSERT INTO `pms_base_catalog3` VALUES ('705', '防溢乳垫', '70');
INSERT INTO `pms_base_catalog3` VALUES ('706', '套装', '71');
INSERT INTO `pms_base_catalog3` VALUES ('707', '上衣', '71');
INSERT INTO `pms_base_catalog3` VALUES ('708', '裤子', '71');
INSERT INTO `pms_base_catalog3` VALUES ('709', '裙子', '71');
INSERT INTO `pms_base_catalog3` VALUES ('710', '内衣/家居服', '71');
INSERT INTO `pms_base_catalog3` VALUES ('711', '羽绒服/棉服', '71');
INSERT INTO `pms_base_catalog3` VALUES ('712', '亲子装', '71');
INSERT INTO `pms_base_catalog3` VALUES ('713', '儿童配饰', '71');
INSERT INTO `pms_base_catalog3` VALUES ('714', '礼服/演出服', '71');
INSERT INTO `pms_base_catalog3` VALUES ('715', '运动鞋', '71');
INSERT INTO `pms_base_catalog3` VALUES ('716', '皮鞋/帆布鞋', '71');
INSERT INTO `pms_base_catalog3` VALUES ('717', '靴子', '71');
INSERT INTO `pms_base_catalog3` VALUES ('718', '凉鞋', '71');
INSERT INTO `pms_base_catalog3` VALUES ('719', '功能鞋', '71');
INSERT INTO `pms_base_catalog3` VALUES ('720', '户外/运动服', '71');
INSERT INTO `pms_base_catalog3` VALUES ('721', '提篮式', '72');
INSERT INTO `pms_base_catalog3` VALUES ('722', '安全座椅', '72');
INSERT INTO `pms_base_catalog3` VALUES ('723', '增高垫', '72');
INSERT INTO `pms_base_catalog3` VALUES ('724', '钱包', '73');
INSERT INTO `pms_base_catalog3` VALUES ('725', '手拿包', '73');
INSERT INTO `pms_base_catalog3` VALUES ('726', '单肩包', '73');
INSERT INTO `pms_base_catalog3` VALUES ('727', '双肩包', '73');
INSERT INTO `pms_base_catalog3` VALUES ('728', '手提包', '73');
INSERT INTO `pms_base_catalog3` VALUES ('729', '斜挎包', '73');
INSERT INTO `pms_base_catalog3` VALUES ('730', '钥匙包', '73');
INSERT INTO `pms_base_catalog3` VALUES ('731', '卡包/零钱包', '73');
INSERT INTO `pms_base_catalog3` VALUES ('732', '男士钱包', '74');
INSERT INTO `pms_base_catalog3` VALUES ('733', '男士手包', '74');
INSERT INTO `pms_base_catalog3` VALUES ('734', '卡包名片夹', '74');
INSERT INTO `pms_base_catalog3` VALUES ('735', '商务公文包', '74');
INSERT INTO `pms_base_catalog3` VALUES ('736', '双肩包', '74');
INSERT INTO `pms_base_catalog3` VALUES ('737', '单肩/斜挎包', '74');
INSERT INTO `pms_base_catalog3` VALUES ('738', '钥匙包', '74');
INSERT INTO `pms_base_catalog3` VALUES ('739', '电脑包', '75');
INSERT INTO `pms_base_catalog3` VALUES ('740', '拉杆箱', '75');
INSERT INTO `pms_base_catalog3` VALUES ('741', '旅行包', '75');
INSERT INTO `pms_base_catalog3` VALUES ('742', '旅行配件', '75');
INSERT INTO `pms_base_catalog3` VALUES ('743', '休闲运动包', '75');
INSERT INTO `pms_base_catalog3` VALUES ('744', '拉杆包', '75');
INSERT INTO `pms_base_catalog3` VALUES ('745', '登山包', '75');
INSERT INTO `pms_base_catalog3` VALUES ('746', '妈咪包', '75');
INSERT INTO `pms_base_catalog3` VALUES ('747', '书包', '75');
INSERT INTO `pms_base_catalog3` VALUES ('748', '相机包', '75');
INSERT INTO `pms_base_catalog3` VALUES ('749', '腰包/胸包', '75');
INSERT INTO `pms_base_catalog3` VALUES ('750', '火机烟具', '76');
INSERT INTO `pms_base_catalog3` VALUES ('751', '礼品文具', '76');
INSERT INTO `pms_base_catalog3` VALUES ('752', '军刀军具', '76');
INSERT INTO `pms_base_catalog3` VALUES ('753', '收藏品', '76');
INSERT INTO `pms_base_catalog3` VALUES ('754', '工艺礼品', '76');
INSERT INTO `pms_base_catalog3` VALUES ('755', '创意礼品', '76');
INSERT INTO `pms_base_catalog3` VALUES ('756', '礼盒礼券', '76');
INSERT INTO `pms_base_catalog3` VALUES ('757', '鲜花绿植', '76');
INSERT INTO `pms_base_catalog3` VALUES ('758', '婚庆节庆', '76');
INSERT INTO `pms_base_catalog3` VALUES ('759', '京东卡', '76');
INSERT INTO `pms_base_catalog3` VALUES ('760', '美妆礼品', '76');
INSERT INTO `pms_base_catalog3` VALUES ('761', '礼品定制', '76');
INSERT INTO `pms_base_catalog3` VALUES ('762', '京东福卡', '76');
INSERT INTO `pms_base_catalog3` VALUES ('763', '古董文玩', '76');
INSERT INTO `pms_base_catalog3` VALUES ('764', '箱包', '77');
INSERT INTO `pms_base_catalog3` VALUES ('765', '钱包', '77');
INSERT INTO `pms_base_catalog3` VALUES ('766', '服饰', '77');
INSERT INTO `pms_base_catalog3` VALUES ('767', '腰带', '77');
INSERT INTO `pms_base_catalog3` VALUES ('768', '太阳镜/眼镜框', '77');
INSERT INTO `pms_base_catalog3` VALUES ('769', '配件', '77');
INSERT INTO `pms_base_catalog3` VALUES ('770', '鞋靴', '77');
INSERT INTO `pms_base_catalog3` VALUES ('771', '饰品', '77');
INSERT INTO `pms_base_catalog3` VALUES ('772', '名品腕表', '77');
INSERT INTO `pms_base_catalog3` VALUES ('773', '高档化妆品', '77');
INSERT INTO `pms_base_catalog3` VALUES ('774', '婚嫁首饰', '78');
INSERT INTO `pms_base_catalog3` VALUES ('775', '婚纱摄影', '78');
INSERT INTO `pms_base_catalog3` VALUES ('776', '婚纱礼服', '78');
INSERT INTO `pms_base_catalog3` VALUES ('777', '婚庆服务', '78');
INSERT INTO `pms_base_catalog3` VALUES ('778', '婚庆礼品/用品', '78');
INSERT INTO `pms_base_catalog3` VALUES ('779', '婚宴', '78');
INSERT INTO `pms_base_catalog3` VALUES ('780', '饼干蛋糕', '79');
INSERT INTO `pms_base_catalog3` VALUES ('781', '糖果/巧克力', '79');
INSERT INTO `pms_base_catalog3` VALUES ('782', '休闲零食', '79');
INSERT INTO `pms_base_catalog3` VALUES ('783', '冲调饮品', '79');
INSERT INTO `pms_base_catalog3` VALUES ('784', '粮油调味', '79');
INSERT INTO `pms_base_catalog3` VALUES ('785', '牛奶', '79');
INSERT INTO `pms_base_catalog3` VALUES ('786', '其他特产', '80');
INSERT INTO `pms_base_catalog3` VALUES ('787', '新疆', '80');
INSERT INTO `pms_base_catalog3` VALUES ('788', '北京', '80');
INSERT INTO `pms_base_catalog3` VALUES ('789', '山西', '80');
INSERT INTO `pms_base_catalog3` VALUES ('790', '内蒙古', '80');
INSERT INTO `pms_base_catalog3` VALUES ('791', '福建', '80');
INSERT INTO `pms_base_catalog3` VALUES ('792', '湖南', '80');
INSERT INTO `pms_base_catalog3` VALUES ('793', '四川', '80');
INSERT INTO `pms_base_catalog3` VALUES ('794', '云南', '80');
INSERT INTO `pms_base_catalog3` VALUES ('795', '东北', '80');
INSERT INTO `pms_base_catalog3` VALUES ('796', '休闲零食', '81');
INSERT INTO `pms_base_catalog3` VALUES ('797', '坚果炒货', '81');
INSERT INTO `pms_base_catalog3` VALUES ('798', '肉干肉脯', '81');
INSERT INTO `pms_base_catalog3` VALUES ('799', '蜜饯果干', '81');
INSERT INTO `pms_base_catalog3` VALUES ('800', '糖果/巧克力', '81');
INSERT INTO `pms_base_catalog3` VALUES ('801', '饼干蛋糕', '81');
INSERT INTO `pms_base_catalog3` VALUES ('802', '无糖食品', '81');
INSERT INTO `pms_base_catalog3` VALUES ('803', '米面杂粮', '82');
INSERT INTO `pms_base_catalog3` VALUES ('804', '食用油', '82');
INSERT INTO `pms_base_catalog3` VALUES ('805', '调味品', '82');
INSERT INTO `pms_base_catalog3` VALUES ('806', '南北干货', '82');
INSERT INTO `pms_base_catalog3` VALUES ('807', '方便食品', '82');
INSERT INTO `pms_base_catalog3` VALUES ('808', '有机食品', '82');
INSERT INTO `pms_base_catalog3` VALUES ('809', '饮用水', '83');
INSERT INTO `pms_base_catalog3` VALUES ('810', '饮料', '83');
INSERT INTO `pms_base_catalog3` VALUES ('811', '牛奶乳品', '83');
INSERT INTO `pms_base_catalog3` VALUES ('812', '咖啡/奶茶', '83');
INSERT INTO `pms_base_catalog3` VALUES ('813', '冲饮谷物', '83');
INSERT INTO `pms_base_catalog3` VALUES ('814', '蜂蜜/柚子茶', '83');
INSERT INTO `pms_base_catalog3` VALUES ('815', '成人奶粉', '83');
INSERT INTO `pms_base_catalog3` VALUES ('816', '月饼', '84');
INSERT INTO `pms_base_catalog3` VALUES ('817', '大闸蟹', '84');
INSERT INTO `pms_base_catalog3` VALUES ('818', '粽子', '84');
INSERT INTO `pms_base_catalog3` VALUES ('819', '卡券', '84');
INSERT INTO `pms_base_catalog3` VALUES ('820', '铁观音', '85');
INSERT INTO `pms_base_catalog3` VALUES ('821', '普洱', '85');
INSERT INTO `pms_base_catalog3` VALUES ('822', '龙井', '85');
INSERT INTO `pms_base_catalog3` VALUES ('823', '绿茶', '85');
INSERT INTO `pms_base_catalog3` VALUES ('824', '红茶', '85');
INSERT INTO `pms_base_catalog3` VALUES ('825', '乌龙茶', '85');
INSERT INTO `pms_base_catalog3` VALUES ('826', '花草茶', '85');
INSERT INTO `pms_base_catalog3` VALUES ('827', '花果茶', '85');
INSERT INTO `pms_base_catalog3` VALUES ('828', '养生茶', '85');
INSERT INTO `pms_base_catalog3` VALUES ('829', '黑茶', '85');
INSERT INTO `pms_base_catalog3` VALUES ('830', '白茶', '85');
INSERT INTO `pms_base_catalog3` VALUES ('831', '其它茶', '85');
INSERT INTO `pms_base_catalog3` VALUES ('832', '项链', '86');
INSERT INTO `pms_base_catalog3` VALUES ('833', '手链/脚链', '86');
INSERT INTO `pms_base_catalog3` VALUES ('834', '戒指', '86');
INSERT INTO `pms_base_catalog3` VALUES ('835', '耳饰', '86');
INSERT INTO `pms_base_catalog3` VALUES ('836', '毛衣链', '86');
INSERT INTO `pms_base_catalog3` VALUES ('837', '发饰/发卡', '86');
INSERT INTO `pms_base_catalog3` VALUES ('838', '胸针', '86');
INSERT INTO `pms_base_catalog3` VALUES ('839', '饰品配件', '86');
INSERT INTO `pms_base_catalog3` VALUES ('840', '婚庆饰品', '86');
INSERT INTO `pms_base_catalog3` VALUES ('841', '黄金吊坠', '87');
INSERT INTO `pms_base_catalog3` VALUES ('842', '黄金项链', '87');
INSERT INTO `pms_base_catalog3` VALUES ('843', '黄金转运珠', '87');
INSERT INTO `pms_base_catalog3` VALUES ('844', '黄金手镯/手链/脚链', '87');
INSERT INTO `pms_base_catalog3` VALUES ('845', '黄金耳饰', '87');
INSERT INTO `pms_base_catalog3` VALUES ('846', '黄金戒指', '87');
INSERT INTO `pms_base_catalog3` VALUES ('847', 'K金吊坠', '88');
INSERT INTO `pms_base_catalog3` VALUES ('848', 'K金项链', '88');
INSERT INTO `pms_base_catalog3` VALUES ('849', 'K金手镯/手链/脚链', '88');
INSERT INTO `pms_base_catalog3` VALUES ('850', 'K金戒指', '88');
INSERT INTO `pms_base_catalog3` VALUES ('851', 'K金耳饰', '88');
INSERT INTO `pms_base_catalog3` VALUES ('852', '投资金', '89');
INSERT INTO `pms_base_catalog3` VALUES ('853', '投资银', '89');
INSERT INTO `pms_base_catalog3` VALUES ('854', '投资收藏', '89');
INSERT INTO `pms_base_catalog3` VALUES ('855', '银吊坠/项链', '90');
INSERT INTO `pms_base_catalog3` VALUES ('856', '银手镯/手链/脚链', '90');
INSERT INTO `pms_base_catalog3` VALUES ('857', '银戒指', '90');
INSERT INTO `pms_base_catalog3` VALUES ('858', '银耳饰', '90');
INSERT INTO `pms_base_catalog3` VALUES ('859', '足银手镯', '90');
INSERT INTO `pms_base_catalog3` VALUES ('860', '宝宝银饰', '90');
INSERT INTO `pms_base_catalog3` VALUES ('861', '裸钻', '91');
INSERT INTO `pms_base_catalog3` VALUES ('862', '钻戒', '91');
INSERT INTO `pms_base_catalog3` VALUES ('863', '钻石项链/吊坠', '91');
INSERT INTO `pms_base_catalog3` VALUES ('864', '钻石耳饰', '91');
INSERT INTO `pms_base_catalog3` VALUES ('865', '钻石手镯/手链', '91');
INSERT INTO `pms_base_catalog3` VALUES ('866', '项链/吊坠', '92');
INSERT INTO `pms_base_catalog3` VALUES ('867', '手镯/手串', '92');
INSERT INTO `pms_base_catalog3` VALUES ('868', '戒指', '92');
INSERT INTO `pms_base_catalog3` VALUES ('869', '耳饰', '92');
INSERT INTO `pms_base_catalog3` VALUES ('870', '挂件/摆件/把件', '92');
INSERT INTO `pms_base_catalog3` VALUES ('871', '玉石孤品', '92');
INSERT INTO `pms_base_catalog3` VALUES ('872', '项链/吊坠', '93');
INSERT INTO `pms_base_catalog3` VALUES ('873', '耳饰', '93');
INSERT INTO `pms_base_catalog3` VALUES ('874', '手镯/手链/脚链', '93');
INSERT INTO `pms_base_catalog3` VALUES ('875', '戒指', '93');
INSERT INTO `pms_base_catalog3` VALUES ('876', '头饰/胸针', '93');
INSERT INTO `pms_base_catalog3` VALUES ('877', '摆件/挂件', '93');
INSERT INTO `pms_base_catalog3` VALUES ('878', '琥珀/蜜蜡', '94');
INSERT INTO `pms_base_catalog3` VALUES ('879', '碧玺', '94');
INSERT INTO `pms_base_catalog3` VALUES ('880', '红宝石/蓝宝石', '94');
INSERT INTO `pms_base_catalog3` VALUES ('881', '坦桑石', '94');
INSERT INTO `pms_base_catalog3` VALUES ('882', '珊瑚', '94');
INSERT INTO `pms_base_catalog3` VALUES ('883', '祖母绿', '94');
INSERT INTO `pms_base_catalog3` VALUES ('884', '葡萄石', '94');
INSERT INTO `pms_base_catalog3` VALUES ('885', '其他天然宝石', '94');
INSERT INTO `pms_base_catalog3` VALUES ('886', '项链/吊坠', '94');
INSERT INTO `pms_base_catalog3` VALUES ('887', '耳饰', '94');
INSERT INTO `pms_base_catalog3` VALUES ('888', '手镯/手链', '94');
INSERT INTO `pms_base_catalog3` VALUES ('889', '戒指', '94');
INSERT INTO `pms_base_catalog3` VALUES ('890', '铂金项链/吊坠', '95');
INSERT INTO `pms_base_catalog3` VALUES ('891', '铂金手镯/手链/脚链', '95');
INSERT INTO `pms_base_catalog3` VALUES ('892', '铂金戒指', '95');
INSERT INTO `pms_base_catalog3` VALUES ('893', '铂金耳饰', '95');
INSERT INTO `pms_base_catalog3` VALUES ('894', '小叶紫檀', '96');
INSERT INTO `pms_base_catalog3` VALUES ('895', '黄花梨', '96');
INSERT INTO `pms_base_catalog3` VALUES ('896', '沉香木', '96');
INSERT INTO `pms_base_catalog3` VALUES ('897', '金丝楠', '96');
INSERT INTO `pms_base_catalog3` VALUES ('898', '菩提', '96');
INSERT INTO `pms_base_catalog3` VALUES ('899', '其他', '96');
INSERT INTO `pms_base_catalog3` VALUES ('900', '橄榄核/核桃', '96');
INSERT INTO `pms_base_catalog3` VALUES ('901', '檀香', '96');
INSERT INTO `pms_base_catalog3` VALUES ('902', '珍珠项链', '97');
INSERT INTO `pms_base_catalog3` VALUES ('903', '珍珠吊坠', '97');
INSERT INTO `pms_base_catalog3` VALUES ('904', '珍珠耳饰', '97');
INSERT INTO `pms_base_catalog3` VALUES ('905', '珍珠手链', '97');
INSERT INTO `pms_base_catalog3` VALUES ('906', '珍珠戒指', '97');
INSERT INTO `pms_base_catalog3` VALUES ('907', '珍珠胸针', '97');
INSERT INTO `pms_base_catalog3` VALUES ('908', '机油', '98');
INSERT INTO `pms_base_catalog3` VALUES ('909', '正时皮带', '98');
INSERT INTO `pms_base_catalog3` VALUES ('910', '添加剂', '98');
INSERT INTO `pms_base_catalog3` VALUES ('911', '汽车喇叭', '98');
INSERT INTO `pms_base_catalog3` VALUES ('912', '防冻液', '98');
INSERT INTO `pms_base_catalog3` VALUES ('913', '汽车玻璃', '98');
INSERT INTO `pms_base_catalog3` VALUES ('914', '滤清器', '98');
INSERT INTO `pms_base_catalog3` VALUES ('915', '火花塞', '98');
INSERT INTO `pms_base_catalog3` VALUES ('916', '减震器', '98');
INSERT INTO `pms_base_catalog3` VALUES ('917', '柴机油/辅助油', '98');
INSERT INTO `pms_base_catalog3` VALUES ('918', '雨刷', '98');
INSERT INTO `pms_base_catalog3` VALUES ('919', '车灯', '98');
INSERT INTO `pms_base_catalog3` VALUES ('920', '后视镜', '98');
INSERT INTO `pms_base_catalog3` VALUES ('921', '轮胎', '98');
INSERT INTO `pms_base_catalog3` VALUES ('922', '轮毂', '98');
INSERT INTO `pms_base_catalog3` VALUES ('923', '刹车片/盘', '98');
INSERT INTO `pms_base_catalog3` VALUES ('924', '维修配件', '98');
INSERT INTO `pms_base_catalog3` VALUES ('925', '蓄电池', '98');
INSERT INTO `pms_base_catalog3` VALUES ('926', '底盘装甲/护板', '98');
INSERT INTO `pms_base_catalog3` VALUES ('927', '贴膜', '98');
INSERT INTO `pms_base_catalog3` VALUES ('928', '汽修工具', '98');
INSERT INTO `pms_base_catalog3` VALUES ('929', '改装配件', '98');
INSERT INTO `pms_base_catalog3` VALUES ('930', '导航仪', '99');
INSERT INTO `pms_base_catalog3` VALUES ('931', '安全预警仪', '99');
INSERT INTO `pms_base_catalog3` VALUES ('932', '行车记录仪', '99');
INSERT INTO `pms_base_catalog3` VALUES ('933', '倒车雷达', '99');
INSERT INTO `pms_base_catalog3` VALUES ('934', '蓝牙设备', '99');
INSERT INTO `pms_base_catalog3` VALUES ('935', '车载影音', '99');
INSERT INTO `pms_base_catalog3` VALUES ('936', '净化器', '99');
INSERT INTO `pms_base_catalog3` VALUES ('937', '电源', '99');
INSERT INTO `pms_base_catalog3` VALUES ('938', '智能驾驶', '99');
INSERT INTO `pms_base_catalog3` VALUES ('939', '车载电台', '99');
INSERT INTO `pms_base_catalog3` VALUES ('940', '车载电器配件', '99');
INSERT INTO `pms_base_catalog3` VALUES ('941', '吸尘器', '99');
INSERT INTO `pms_base_catalog3` VALUES ('942', '智能车机', '99');
INSERT INTO `pms_base_catalog3` VALUES ('943', '冰箱', '99');
INSERT INTO `pms_base_catalog3` VALUES ('944', '汽车音响', '99');
INSERT INTO `pms_base_catalog3` VALUES ('945', '车载生活电器', '99');
INSERT INTO `pms_base_catalog3` VALUES ('946', '车蜡', '100');
INSERT INTO `pms_base_catalog3` VALUES ('947', '补漆笔', '100');
INSERT INTO `pms_base_catalog3` VALUES ('948', '玻璃水', '100');
INSERT INTO `pms_base_catalog3` VALUES ('949', '清洁剂', '100');
INSERT INTO `pms_base_catalog3` VALUES ('950', '洗车工具', '100');
INSERT INTO `pms_base_catalog3` VALUES ('951', '镀晶镀膜', '100');
INSERT INTO `pms_base_catalog3` VALUES ('952', '打蜡机', '100');
INSERT INTO `pms_base_catalog3` VALUES ('953', '洗车配件', '100');
INSERT INTO `pms_base_catalog3` VALUES ('954', '洗车机', '100');
INSERT INTO `pms_base_catalog3` VALUES ('955', '洗车水枪', '100');
INSERT INTO `pms_base_catalog3` VALUES ('956', '毛巾掸子', '100');
INSERT INTO `pms_base_catalog3` VALUES ('957', '脚垫', '101');
INSERT INTO `pms_base_catalog3` VALUES ('958', '座垫', '101');
INSERT INTO `pms_base_catalog3` VALUES ('959', '座套', '101');
INSERT INTO `pms_base_catalog3` VALUES ('960', '后备箱垫', '101');
INSERT INTO `pms_base_catalog3` VALUES ('961', '头枕腰靠', '101');
INSERT INTO `pms_base_catalog3` VALUES ('962', '方向盘套', '101');
INSERT INTO `pms_base_catalog3` VALUES ('963', '香水', '101');
INSERT INTO `pms_base_catalog3` VALUES ('964', '空气净化', '101');
INSERT INTO `pms_base_catalog3` VALUES ('965', '挂件摆件', '101');
INSERT INTO `pms_base_catalog3` VALUES ('966', '功能小件', '101');
INSERT INTO `pms_base_catalog3` VALUES ('967', '车身装饰件', '101');
INSERT INTO `pms_base_catalog3` VALUES ('968', '车衣', '101');
INSERT INTO `pms_base_catalog3` VALUES ('969', '安全座椅', '102');
INSERT INTO `pms_base_catalog3` VALUES ('970', '胎压监测', '102');
INSERT INTO `pms_base_catalog3` VALUES ('971', '防盗设备', '102');
INSERT INTO `pms_base_catalog3` VALUES ('972', '应急救援', '102');
INSERT INTO `pms_base_catalog3` VALUES ('973', '保温箱', '102');
INSERT INTO `pms_base_catalog3` VALUES ('974', '地锁', '102');
INSERT INTO `pms_base_catalog3` VALUES ('975', '摩托车', '102');
INSERT INTO `pms_base_catalog3` VALUES ('976', '充气泵', '102');
INSERT INTO `pms_base_catalog3` VALUES ('977', '储物箱', '102');
INSERT INTO `pms_base_catalog3` VALUES ('978', '自驾野营', '102');
INSERT INTO `pms_base_catalog3` VALUES ('979', '摩托车装备', '102');
INSERT INTO `pms_base_catalog3` VALUES ('980', '清洗美容', '103');
INSERT INTO `pms_base_catalog3` VALUES ('981', '功能升级', '103');
INSERT INTO `pms_base_catalog3` VALUES ('982', '保养维修', '103');
INSERT INTO `pms_base_catalog3` VALUES ('983', '油卡充值', '103');
INSERT INTO `pms_base_catalog3` VALUES ('984', '车险', '103');
INSERT INTO `pms_base_catalog3` VALUES ('985', '加油卡', '103');
INSERT INTO `pms_base_catalog3` VALUES ('986', 'ETC', '103');
INSERT INTO `pms_base_catalog3` VALUES ('987', '驾驶培训', '103');
INSERT INTO `pms_base_catalog3` VALUES ('988', '赛事服装', '104');
INSERT INTO `pms_base_catalog3` VALUES ('989', '赛事用品', '104');
INSERT INTO `pms_base_catalog3` VALUES ('990', '制动系统', '104');
INSERT INTO `pms_base_catalog3` VALUES ('991', '悬挂系统', '104');
INSERT INTO `pms_base_catalog3` VALUES ('992', '进气系统', '104');
INSERT INTO `pms_base_catalog3` VALUES ('993', '排气系统', '104');
INSERT INTO `pms_base_catalog3` VALUES ('994', '电子管理', '104');
INSERT INTO `pms_base_catalog3` VALUES ('995', '车身强化', '104');
INSERT INTO `pms_base_catalog3` VALUES ('996', '赛事座椅', '104');
INSERT INTO `pms_base_catalog3` VALUES ('997', '跑步鞋', '105');
INSERT INTO `pms_base_catalog3` VALUES ('998', '休闲鞋', '105');
INSERT INTO `pms_base_catalog3` VALUES ('999', '篮球鞋', '105');
INSERT INTO `pms_base_catalog3` VALUES ('1000', '板鞋', '105');
INSERT INTO `pms_base_catalog3` VALUES ('1001', '帆布鞋', '105');
INSERT INTO `pms_base_catalog3` VALUES ('1002', '足球鞋', '105');
INSERT INTO `pms_base_catalog3` VALUES ('1003', '乒羽网鞋', '105');
INSERT INTO `pms_base_catalog3` VALUES ('1004', '专项运动鞋', '105');
INSERT INTO `pms_base_catalog3` VALUES ('1005', '训练鞋', '105');
INSERT INTO `pms_base_catalog3` VALUES ('1006', '拖鞋', '105');
INSERT INTO `pms_base_catalog3` VALUES ('1007', '运动包', '105');
INSERT INTO `pms_base_catalog3` VALUES ('1008', '羽绒服', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1009', '棉服', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1010', '运动裤', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1011', '夹克/风衣', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1012', '卫衣/套头衫', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1013', 'T恤', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1014', '套装', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1015', '乒羽网服', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1016', '健身服', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1017', '运动背心', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1018', '毛衫/线衫', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1019', '运动配饰', '106');
INSERT INTO `pms_base_catalog3` VALUES ('1020', '折叠车', '107');
INSERT INTO `pms_base_catalog3` VALUES ('1021', '山地车/公路车', '107');
INSERT INTO `pms_base_catalog3` VALUES ('1022', '电动车', '107');
INSERT INTO `pms_base_catalog3` VALUES ('1023', '其他整车', '107');
INSERT INTO `pms_base_catalog3` VALUES ('1024', '骑行服', '107');
INSERT INTO `pms_base_catalog3` VALUES ('1025', '骑行装备', '107');
INSERT INTO `pms_base_catalog3` VALUES ('1026', '平衡车', '107');
INSERT INTO `pms_base_catalog3` VALUES ('1027', '鱼竿鱼线', '108');
INSERT INTO `pms_base_catalog3` VALUES ('1028', '浮漂鱼饵', '108');
INSERT INTO `pms_base_catalog3` VALUES ('1029', '钓鱼桌椅', '108');
INSERT INTO `pms_base_catalog3` VALUES ('1030', '钓鱼配件', '108');
INSERT INTO `pms_base_catalog3` VALUES ('1031', '钓箱鱼包', '108');
INSERT INTO `pms_base_catalog3` VALUES ('1032', '其它', '108');
INSERT INTO `pms_base_catalog3` VALUES ('1033', '泳镜', '109');
INSERT INTO `pms_base_catalog3` VALUES ('1034', '泳帽', '109');
INSERT INTO `pms_base_catalog3` VALUES ('1035', '游泳包防水包', '109');
INSERT INTO `pms_base_catalog3` VALUES ('1036', '女士泳衣', '109');
INSERT INTO `pms_base_catalog3` VALUES ('1037', '男士泳衣', '109');
INSERT INTO `pms_base_catalog3` VALUES ('1038', '比基尼', '109');
INSERT INTO `pms_base_catalog3` VALUES ('1039', '其它', '109');
INSERT INTO `pms_base_catalog3` VALUES ('1040', '冲锋衣裤', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1041', '速干衣裤', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1042', '滑雪服', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1043', '羽绒服/棉服', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1044', '休闲衣裤', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1045', '抓绒衣裤', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1046', '软壳衣裤', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1047', 'T恤', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1048', '户外风衣', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1049', '功能内衣', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1050', '军迷服饰', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1051', '登山鞋', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1052', '雪地靴', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1053', '徒步鞋', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1054', '越野跑鞋', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1055', '休闲鞋', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1056', '工装鞋', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1057', '溯溪鞋', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1058', '沙滩/凉拖', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1059', '户外袜', '110');
INSERT INTO `pms_base_catalog3` VALUES ('1060', '帐篷/垫子', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1061', '睡袋/吊床', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1062', '登山攀岩', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1063', '户外配饰', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1064', '背包', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1065', '户外照明', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1066', '户外仪表', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1067', '户外工具', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1068', '望远镜', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1069', '旅游用品', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1070', '便携桌椅床', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1071', '野餐烧烤', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1072', '军迷用品', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1073', '救援装备', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1074', '滑雪装备', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1075', '极限户外', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1076', '冲浪潜水', '111');
INSERT INTO `pms_base_catalog3` VALUES ('1077', '综合训练器', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1078', '其他大型器械', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1079', '哑铃', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1080', '仰卧板/收腹机', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1081', '其他中小型器材', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1082', '瑜伽舞蹈', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1083', '甩脂机', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1084', '踏步机', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1085', '武术搏击', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1086', '健身车/动感单车', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1087', '跑步机', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1088', '运动护具', '112');
INSERT INTO `pms_base_catalog3` VALUES ('1089', '羽毛球', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1090', '乒乓球', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1091', '篮球', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1092', '足球', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1093', '网球', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1094', '排球', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1095', '高尔夫', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1096', '台球', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1097', '棋牌麻将', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1098', '轮滑滑板', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1099', '其他', '113');
INSERT INTO `pms_base_catalog3` VALUES ('1100', '0-6个月', '114');
INSERT INTO `pms_base_catalog3` VALUES ('1101', '6-12个月', '114');
INSERT INTO `pms_base_catalog3` VALUES ('1102', '1-3岁', '114');
INSERT INTO `pms_base_catalog3` VALUES ('1103', '3-6岁', '114');
INSERT INTO `pms_base_catalog3` VALUES ('1104', '6-14岁', '114');
INSERT INTO `pms_base_catalog3` VALUES ('1105', '14岁以上', '114');
INSERT INTO `pms_base_catalog3` VALUES ('1106', '遥控车', '115');
INSERT INTO `pms_base_catalog3` VALUES ('1107', '遥控飞机', '115');
INSERT INTO `pms_base_catalog3` VALUES ('1108', '遥控船', '115');
INSERT INTO `pms_base_catalog3` VALUES ('1109', '机器人', '115');
INSERT INTO `pms_base_catalog3` VALUES ('1110', '轨道/助力', '115');
INSERT INTO `pms_base_catalog3` VALUES ('1111', '毛绒/布艺', '116');
INSERT INTO `pms_base_catalog3` VALUES ('1112', '靠垫/抱枕', '116');
INSERT INTO `pms_base_catalog3` VALUES ('1113', '芭比娃娃', '117');
INSERT INTO `pms_base_catalog3` VALUES ('1114', '卡通娃娃', '117');
INSERT INTO `pms_base_catalog3` VALUES ('1115', '智能娃娃', '117');
INSERT INTO `pms_base_catalog3` VALUES ('1116', '仿真模型', '118');
INSERT INTO `pms_base_catalog3` VALUES ('1117', '拼插模型', '118');
INSERT INTO `pms_base_catalog3` VALUES ('1118', '收藏爱好', '118');
INSERT INTO `pms_base_catalog3` VALUES ('1119', '炫舞毯', '119');
INSERT INTO `pms_base_catalog3` VALUES ('1120', '爬行垫/毯', '119');
INSERT INTO `pms_base_catalog3` VALUES ('1121', '户外玩具', '119');
INSERT INTO `pms_base_catalog3` VALUES ('1122', '戏水玩具', '119');
INSERT INTO `pms_base_catalog3` VALUES ('1123', '电影周边', '120');
INSERT INTO `pms_base_catalog3` VALUES ('1124', '卡通周边', '120');
INSERT INTO `pms_base_catalog3` VALUES ('1125', '网游周边', '120');
INSERT INTO `pms_base_catalog3` VALUES ('1126', '摇铃/床铃', '121');
INSERT INTO `pms_base_catalog3` VALUES ('1127', '健身架', '121');
INSERT INTO `pms_base_catalog3` VALUES ('1128', '早教启智', '121');
INSERT INTO `pms_base_catalog3` VALUES ('1129', '拖拉玩具', '121');
INSERT INTO `pms_base_catalog3` VALUES ('1130', '积木', '122');
INSERT INTO `pms_base_catalog3` VALUES ('1131', '拼图', '122');
INSERT INTO `pms_base_catalog3` VALUES ('1132', '磁力棒', '122');
INSERT INTO `pms_base_catalog3` VALUES ('1133', '立体拼插', '122');
INSERT INTO `pms_base_catalog3` VALUES ('1134', '手工彩泥', '123');
INSERT INTO `pms_base_catalog3` VALUES ('1135', '绘画工具', '123');
INSERT INTO `pms_base_catalog3` VALUES ('1136', '情景玩具', '123');
INSERT INTO `pms_base_catalog3` VALUES ('1137', '减压玩具', '124');
INSERT INTO `pms_base_catalog3` VALUES ('1138', '创意玩具', '124');
INSERT INTO `pms_base_catalog3` VALUES ('1139', '钢琴', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1140', '电子琴/电钢琴', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1141', '吉他/尤克里里', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1142', '打击乐器', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1143', '西洋管弦', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1144', '民族管弦乐器', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1145', '乐器配件', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1146', '电脑音乐', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1147', '工艺礼品乐器', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1148', '口琴/口风琴/竖笛', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1149', '手风琴', '125');
INSERT INTO `pms_base_catalog3` VALUES ('1150', '双色球', '126');
INSERT INTO `pms_base_catalog3` VALUES ('1151', '大乐透', '126');
INSERT INTO `pms_base_catalog3` VALUES ('1152', '福彩3D', '126');
INSERT INTO `pms_base_catalog3` VALUES ('1153', '排列三', '126');
INSERT INTO `pms_base_catalog3` VALUES ('1154', '排列五', '126');
INSERT INTO `pms_base_catalog3` VALUES ('1155', '七星彩', '126');
INSERT INTO `pms_base_catalog3` VALUES ('1156', '七乐彩', '126');
INSERT INTO `pms_base_catalog3` VALUES ('1157', '竞彩足球', '126');
INSERT INTO `pms_base_catalog3` VALUES ('1158', '竞彩篮球', '126');
INSERT INTO `pms_base_catalog3` VALUES ('1159', '新时时彩', '126');
INSERT INTO `pms_base_catalog3` VALUES ('1160', '国内机票', '127');
INSERT INTO `pms_base_catalog3` VALUES ('1161', '国内酒店', '128');
INSERT INTO `pms_base_catalog3` VALUES ('1162', '酒店团购', '128');
INSERT INTO `pms_base_catalog3` VALUES ('1163', '度假', '129');
INSERT INTO `pms_base_catalog3` VALUES ('1164', '景点', '129');
INSERT INTO `pms_base_catalog3` VALUES ('1165', '租车', '129');
INSERT INTO `pms_base_catalog3` VALUES ('1166', '火车票', '129');
INSERT INTO `pms_base_catalog3` VALUES ('1167', '旅游团购', '129');
INSERT INTO `pms_base_catalog3` VALUES ('1168', '手机充值', '130');
INSERT INTO `pms_base_catalog3` VALUES ('1169', '游戏点卡', '131');
INSERT INTO `pms_base_catalog3` VALUES ('1170', 'QQ充值', '131');
INSERT INTO `pms_base_catalog3` VALUES ('1171', '电影票', '132');
INSERT INTO `pms_base_catalog3` VALUES ('1172', '演唱会', '132');
INSERT INTO `pms_base_catalog3` VALUES ('1173', '话剧歌剧', '132');
INSERT INTO `pms_base_catalog3` VALUES ('1174', '音乐会', '132');
INSERT INTO `pms_base_catalog3` VALUES ('1175', '体育赛事', '132');
INSERT INTO `pms_base_catalog3` VALUES ('1176', '舞蹈芭蕾', '132');
INSERT INTO `pms_base_catalog3` VALUES ('1177', '戏曲综艺', '132');
INSERT INTO `pms_base_catalog3` VALUES ('1178', '东北', '133');
INSERT INTO `pms_base_catalog3` VALUES ('1179', '华北', '133');
INSERT INTO `pms_base_catalog3` VALUES ('1180', '西北', '133');
INSERT INTO `pms_base_catalog3` VALUES ('1181', '华中', '133');
INSERT INTO `pms_base_catalog3` VALUES ('1182', '华东', '133');
INSERT INTO `pms_base_catalog3` VALUES ('1183', '华南', '133');
INSERT INTO `pms_base_catalog3` VALUES ('1184', '西南', '133');
INSERT INTO `pms_base_catalog3` VALUES ('1185', '苹果', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1186', '橙子', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1187', '奇异果/猕猴桃', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1188', '车厘子/樱桃', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1189', '芒果', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1190', '蓝莓', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1191', '火龙果', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1192', '葡萄/提子', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1193', '柚子', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1194', '香蕉', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1195', '牛油果', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1196', '梨', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1197', '菠萝/凤梨', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1198', '桔/橘', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1199', '柠檬', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1200', '草莓', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1201', '桃/李/杏', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1202', '更多水果', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1203', '水果礼盒/券', '134');
INSERT INTO `pms_base_catalog3` VALUES ('1204', '牛肉', '135');
INSERT INTO `pms_base_catalog3` VALUES ('1205', '羊肉', '135');
INSERT INTO `pms_base_catalog3` VALUES ('1206', '猪肉', '135');
INSERT INTO `pms_base_catalog3` VALUES ('1207', '内脏类', '135');
INSERT INTO `pms_base_catalog3` VALUES ('1208', '鱼类', '136');
INSERT INTO `pms_base_catalog3` VALUES ('1209', '虾类', '136');
INSERT INTO `pms_base_catalog3` VALUES ('1210', '蟹类', '136');
INSERT INTO `pms_base_catalog3` VALUES ('1211', '贝类', '136');
INSERT INTO `pms_base_catalog3` VALUES ('1212', '海参', '136');
INSERT INTO `pms_base_catalog3` VALUES ('1213', '海产干货', '136');
INSERT INTO `pms_base_catalog3` VALUES ('1214', '其他水产', '136');
INSERT INTO `pms_base_catalog3` VALUES ('1215', '海产礼盒', '136');
INSERT INTO `pms_base_catalog3` VALUES ('1216', '鸡肉', '137');
INSERT INTO `pms_base_catalog3` VALUES ('1217', '鸭肉', '137');
INSERT INTO `pms_base_catalog3` VALUES ('1218', '蛋类', '137');
INSERT INTO `pms_base_catalog3` VALUES ('1219', '其他禽类', '137');
INSERT INTO `pms_base_catalog3` VALUES ('1220', '水饺/馄饨', '138');
INSERT INTO `pms_base_catalog3` VALUES ('1221', '汤圆/元宵', '138');
INSERT INTO `pms_base_catalog3` VALUES ('1222', '面点', '138');
INSERT INTO `pms_base_catalog3` VALUES ('1223', '火锅丸串', '138');
INSERT INTO `pms_base_catalog3` VALUES ('1224', '速冻半成品', '138');
INSERT INTO `pms_base_catalog3` VALUES ('1225', '奶酪黄油', '138');
INSERT INTO `pms_base_catalog3` VALUES ('1226', '熟食', '139');
INSERT INTO `pms_base_catalog3` VALUES ('1227', '腊肠/腊肉', '139');
INSERT INTO `pms_base_catalog3` VALUES ('1228', '火腿', '139');
INSERT INTO `pms_base_catalog3` VALUES ('1229', '糕点', '139');
INSERT INTO `pms_base_catalog3` VALUES ('1230', '礼品卡券', '139');
INSERT INTO `pms_base_catalog3` VALUES ('1231', '冷藏果蔬汁', '140');
INSERT INTO `pms_base_catalog3` VALUES ('1232', '冰激凌', '140');
INSERT INTO `pms_base_catalog3` VALUES ('1233', '其他', '140');
INSERT INTO `pms_base_catalog3` VALUES ('1234', '叶菜类', '141');
INSERT INTO `pms_base_catalog3` VALUES ('1235', '茄果瓜类', '141');
INSERT INTO `pms_base_catalog3` VALUES ('1236', '根茎类', '141');
INSERT INTO `pms_base_catalog3` VALUES ('1237', '鲜菌菇', '141');
INSERT INTO `pms_base_catalog3` VALUES ('1238', '葱姜蒜椒', '141');
INSERT INTO `pms_base_catalog3` VALUES ('1239', '半加工蔬菜', '141');
INSERT INTO `pms_base_catalog3` VALUES ('1240', '微型车', '142');
INSERT INTO `pms_base_catalog3` VALUES ('1241', '小型车', '142');
INSERT INTO `pms_base_catalog3` VALUES ('1242', '紧凑型车', '142');
INSERT INTO `pms_base_catalog3` VALUES ('1243', '中型车', '142');
INSERT INTO `pms_base_catalog3` VALUES ('1244', '中大型车', '142');
INSERT INTO `pms_base_catalog3` VALUES ('1245', '豪华车', '142');
INSERT INTO `pms_base_catalog3` VALUES ('1246', 'MPV', '142');
INSERT INTO `pms_base_catalog3` VALUES ('1247', 'SUV', '142');
INSERT INTO `pms_base_catalog3` VALUES ('1248', '跑车', '142');
INSERT INTO `pms_base_catalog3` VALUES ('1249', '微型车（二手）', '143');
INSERT INTO `pms_base_catalog3` VALUES ('1250', '小型车（二手）', '143');
INSERT INTO `pms_base_catalog3` VALUES ('1251', '紧凑型车（二手）', '143');
INSERT INTO `pms_base_catalog3` VALUES ('1252', '中型车（二手）', '143');
INSERT INTO `pms_base_catalog3` VALUES ('1253', '中大型车（二手）', '143');
INSERT INTO `pms_base_catalog3` VALUES ('1254', '豪华车（二手）', '143');
INSERT INTO `pms_base_catalog3` VALUES ('1255', 'MPV（二手）', '143');
INSERT INTO `pms_base_catalog3` VALUES ('1256', 'SUV（二手）', '143');
INSERT INTO `pms_base_catalog3` VALUES ('1257', '跑车（二手）', '143');
INSERT INTO `pms_base_catalog3` VALUES ('1258', '皮卡（二手）', '143');
INSERT INTO `pms_base_catalog3` VALUES ('1259', '面包车（二手）', '143');

-- ----------------------------
-- Table structure for `pms_base_sale_attr`
-- ----------------------------
DROP TABLE IF EXISTS `pms_base_sale_attr`;
CREATE TABLE `pms_base_sale_attr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) NOT NULL COMMENT '销售属性名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pms_base_sale_attr
-- ----------------------------
INSERT INTO `pms_base_sale_attr` VALUES ('1', '颜色');
INSERT INTO `pms_base_sale_attr` VALUES ('2', '尺寸');
INSERT INTO `pms_base_sale_attr` VALUES ('3', '版本');
INSERT INTO `pms_base_sale_attr` VALUES ('4', '容量');

-- ----------------------------
-- Table structure for `pms_brand`
-- ----------------------------
DROP TABLE IF EXISTS `pms_brand`;
CREATE TABLE `pms_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `first_letter` varchar(8) DEFAULT NULL COMMENT '首字母',
  `sort` int(11) DEFAULT NULL,
  `factory_status` int(1) DEFAULT NULL COMMENT '是否为品牌制造商：0->不是；1->是',
  `show_status` int(1) DEFAULT NULL,
  `product_count` int(11) DEFAULT NULL COMMENT '产品数量',
  `product_comment_count` int(11) DEFAULT NULL COMMENT '产品评论数量',
  `logo` varchar(255) DEFAULT NULL COMMENT '品牌logo',
  `big_pic` varchar(255) DEFAULT NULL COMMENT '专区大图',
  `brand_story` text COMMENT '品牌故事',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='品牌表';

-- ----------------------------
-- Records of pms_brand
-- ----------------------------
INSERT INTO `pms_brand` VALUES ('1', '万和', 'W', '0', '1', '1', '100', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(5).jpg', '', 'Victoria\'s Secret的故事');
INSERT INTO `pms_brand` VALUES ('2', '三星', 'S', '100', '1', '1', '100', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (1).jpg', null, '三星的故事');
INSERT INTO `pms_brand` VALUES ('4', '格力', 'G', '30', '1', '1', '100', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/dc794e7e74121272bbe3ce9bc41ec8c3_222_222.jpg', null, 'Victoria\'s Secret的故事');
INSERT INTO `pms_brand` VALUES ('5', '方太', 'F', '20', '1', '1', '100', '100', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (4).jpg', null, 'Victoria\'s Secret的故事');
INSERT INTO `pms_brand` VALUES ('6', '小米', 'X', '0', '1', '1', '100', '200', null, null, null);
INSERT INTO `pms_brand` VALUES ('21', 'OPPO', 'O', '0', '1', '1', '88', '500', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(6).jpg', '', 'string');
INSERT INTO `pms_brand` VALUES ('49', '七匹狼', 'S', '200', '1', '1', '77', '400', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/18d8bc3eb13533fab466d702a0d3fd1f40345bcd.jpg', null, 'BOOB的故事');
INSERT INTO `pms_brand` VALUES ('50', '海澜之家', 'H', '200', '1', '1', '66', '300', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20190129/99d3279f1029d32b929343b09d3c72de_222_222.jpg', '', '海澜之家的故事');
INSERT INTO `pms_brand` VALUES ('51', '苹果', 'A', '200', '1', '1', '55', '200', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', null, '苹果的故事');
INSERT INTO `pms_brand` VALUES ('52', 'ggg', 'g', '0', '0', '0', null, null, 'http://leifengyang.oss-cn-beijing.aliyuncs.com/gmall/images/20190315/7.jpg', '', '');

-- ----------------------------
-- Table structure for `pms_comment`
-- ----------------------------
DROP TABLE IF EXISTS `pms_comment`;
CREATE TABLE `pms_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `member_nick_name` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `star` int(3) DEFAULT NULL COMMENT '评价星数：0->5',
  `member_ip` varchar(64) DEFAULT NULL COMMENT '评价的ip',
  `create_time` datetime DEFAULT NULL,
  `show_status` int(1) DEFAULT NULL,
  `product_attribute` varchar(255) DEFAULT NULL COMMENT '购买时的商品属性',
  `collect_couont` int(11) DEFAULT NULL,
  `read_count` int(11) DEFAULT NULL,
  `content` text,
  `pics` varchar(1000) DEFAULT NULL COMMENT '上传图片地址，以逗号隔开',
  `member_icon` varchar(255) DEFAULT NULL COMMENT '评论用户头像',
  `replay_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品评价表';

-- ----------------------------
-- Records of pms_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `pms_comment_replay`
-- ----------------------------
DROP TABLE IF EXISTS `pms_comment_replay`;
CREATE TABLE `pms_comment_replay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) DEFAULT NULL,
  `member_nick_name` varchar(255) DEFAULT NULL,
  `member_icon` varchar(255) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `type` int(1) DEFAULT NULL COMMENT '评论人员类型；0->会员；1->管理员',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品评价回复表';

-- ----------------------------
-- Records of pms_comment_replay
-- ----------------------------

-- ----------------------------
-- Table structure for `pms_product_image`
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_image`;
CREATE TABLE `pms_product_image` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `product_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `img_name` varchar(200) DEFAULT NULL COMMENT '图片名称',
  `img_url` varchar(200) DEFAULT NULL COMMENT '图片路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8 COMMENT='商品图片表';

-- ----------------------------
-- Records of pms_product_image
-- ----------------------------
INSERT INTO `pms_product_image` VALUES ('1', '9', 'EoeFWGrvdXmKrGU.png', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('2', '9', 'roCFucDzSlyeqAD.png', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('3', '10', 'EoeFWGrvdXmKrGU.png', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('4', '10', 'roCFucDzSlyeqAD.png', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('9', '21', 'javazp.jpg', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('10', '21', 'sql处理流程.jpg', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('11', '22', 'EoeFWGrvdXmKrGU.png', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('12', '23', 'EoeFWGrvdXmKrGU.png', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('32', '12', 'EoeFWGrvdXmKrGU.png', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('33', '12', 'EoeFWGrvdXmKrGU.png', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('38', '11', 'EoeFWGrvdXmKrGU.png', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('39', '11', 'EoeFWGrvdXmKrGU.png', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('40', '24', '黑正面.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAZUeyAABl-Gcmj6Q266.jpg');
INSERT INTO `pms_product_image` VALUES ('41', '24', '黑正2.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAEi7GAAAoCdAcm0Q483.jpg');
INSERT INTO `pms_product_image` VALUES ('42', '24', '黑侧.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAaNHoAAASDgWlJKA341.jpg');
INSERT INTO `pms_product_image` VALUES ('43', '24', '黑角.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJNobAABchtkLSZ4079.jpg');
INSERT INTO `pms_product_image` VALUES ('44', '24', '充电器', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAahD_AAAoTYXCz4M337.jpg');
INSERT INTO `pms_product_image` VALUES ('45', '24', '全家福', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAYBe7AACAQkIGrK0125.jpg');
INSERT INTO `pms_product_image` VALUES ('46', '24', '蓝正', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAPBi4AABzDHfHIis984.jpg');
INSERT INTO `pms_product_image` VALUES ('47', '24', '蓝全', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaATE04AABTFiuk_fQ924.jpg');
INSERT INTO `pms_product_image` VALUES ('48', '24', '蓝背', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaABfJ3AAAxq41Xmt8702.jpg');
INSERT INTO `pms_product_image` VALUES ('49', '24', '蓝底', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJ6nTAAA6Ol3Q8DA559.jpg');
INSERT INTO `pms_product_image` VALUES ('57', '25', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_product_image` VALUES ('58', '25', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_product_image` VALUES ('59', '25', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg');
INSERT INTO `pms_product_image` VALUES ('60', '25', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg');
INSERT INTO `pms_product_image` VALUES ('61', '25', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg');
INSERT INTO `pms_product_image` VALUES ('62', '25', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg');
INSERT INTO `pms_product_image` VALUES ('63', '25', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg');
INSERT INTO `pms_product_image` VALUES ('64', '26', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdHWAUgY1AABGlNSsc8k337.jpg');
INSERT INTO `pms_product_image` VALUES ('65', '26', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AdVB5AACQ33CNBgI849.jpg');
INSERT INTO `pms_product_image` VALUES ('66', '26', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-Af4jjAACnL2DEmZI759.jpg');
INSERT INTO `pms_product_image` VALUES ('67', '26', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-ASvcIAABLvWYyykI760.jpg');
INSERT INTO `pms_product_image` VALUES ('68', '26', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AF-iIAAAzpeBWucQ529.jpg');
INSERT INTO `pms_product_image` VALUES ('69', '27', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuANqf7AAAzpeBWucQ738.jpg');
INSERT INTO `pms_product_image` VALUES ('70', '27', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAKGYbAACQ33CNBgI202.jpg');
INSERT INTO `pms_product_image` VALUES ('71', '27', 'u=1780590834,74343091&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAJZLuAAAbekxUTwU917.jpg');
INSERT INTO `pms_product_image` VALUES ('72', '27', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAbM11AABUx6Stpu8094.jpg');
INSERT INTO `pms_product_image` VALUES ('73', '27', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuABXVvAAA2oBvXGRY799.jpg');
INSERT INTO `pms_product_image` VALUES ('74', '27', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAOy_6AAAqaC4JyRU137.jpg');
INSERT INTO `pms_product_image` VALUES ('75', '28', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOAanCWAABKCGOfKjM751.jpg');
INSERT INTO `pms_product_image` VALUES ('76', '28', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOAFlzvAAB9_p5yd_4645.jpg');
INSERT INTO `pms_product_image` VALUES ('77', '28', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOAHCncAABQITqS23s031.jpg');
INSERT INTO `pms_product_image` VALUES ('78', '28', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOAU2uAAABUx6Stpu8185.jpg');
INSERT INTO `pms_product_image` VALUES ('79', '28', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOANzwpAABGOuGpu5s702.jpg');
INSERT INTO `pms_product_image` VALUES ('80', '28', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOATT9kAAAjTcYpOHA300.jpg');
INSERT INTO `pms_product_image` VALUES ('81', '30', 'qq.jpg', 'https://m.360buyimg.com/babel/jfs/t5137/20/1794970752/352145/d56e4e94/591417dcN4fe5ef33.jpg');
INSERT INTO `pms_product_image` VALUES ('82', '32', 'a.gif', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr46FaAEDBRAAEEvUoMWYY596.gif');
INSERT INTO `pms_product_image` VALUES ('83', '33', 'qq.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr5KiyANDIVAADvM9t8a8k995.jpg');
INSERT INTO `pms_product_image` VALUES ('84', '41', 'qq.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFr6fiGABrsfAAEEvUoMWYY702.gif');
INSERT INTO `pms_product_image` VALUES ('85', '42', 'qq.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFr6fiGABrsfAAEEvUoMWYY702.gif');
INSERT INTO `pms_product_image` VALUES ('86', '43', 'a.gif', 'http://192.168.222.20/group1/M00/00/00/wKjeFFr6fiGABrsfAAEEvUoMWYY702.gif');
INSERT INTO `pms_product_image` VALUES ('87', '43', 'qq.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFr6fiGABrsfAAEEvUoMWYY702.gif');
INSERT INTO `pms_product_image` VALUES ('88', '43', 'google.png', 'http://192.168.222.20/group1/M00/00/00/wKjeFFr6fiGABrsfAAEEvUoMWYY702.gif');
INSERT INTO `pms_product_image` VALUES ('89', '44', 'qq.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr7jPiANGN6AADvM9t8a8k773.jpg');
INSERT INTO `pms_product_image` VALUES ('90', '44', 'a.gif', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr7jPiAVZH9AAEEvUoMWYY884.gif');
INSERT INTO `pms_product_image` VALUES ('91', '45', 'qq.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AOANHAADvM9t8a8k653.jpg');
INSERT INTO `pms_product_image` VALUES ('92', '45', 'google.png', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AcGfjAAAkRcqoM4I236.png');
INSERT INTO `pms_product_image` VALUES ('93', '45', 'a.gif', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AK5PgAAEEvUoMWYY866.gif');
INSERT INTO `pms_product_image` VALUES ('94', '47', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsblSWABkTHAAB9_p5yd_4684.jpg');
INSERT INTO `pms_product_image` VALUES ('95', '47', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsblSmAZZlJAABLvWYyykI646.jpg');
INSERT INTO `pms_product_image` VALUES ('96', '47', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsblSyAZsSGAABQITqS23s445.jpg');
INSERT INTO `pms_product_image` VALUES ('97', '47', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsblTCASdUOAAAzpeBWucQ532.jpg');
INSERT INTO `pms_product_image` VALUES ('98', '47', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsblTOAPTv8AABGOuGpu5s134.jpg');
INSERT INTO `pms_product_image` VALUES ('99', '48', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsblqmAE8C0AAB9_p5yd_4328.jpg');
INSERT INTO `pms_product_image` VALUES ('100', '48', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsblquAIPn0AABLvWYyykI807.jpg');
INSERT INTO `pms_product_image` VALUES ('101', '48', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsblq6AcTDnAABUx6Stpu8908.jpg');
INSERT INTO `pms_product_image` VALUES ('102', '49', 'u=1780590834,74343091&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsbluiAd5_eAAAbekxUTwU976.jpg');
INSERT INTO `pms_product_image` VALUES ('103', '49', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsbluqAFuhvAABQITqS23s918.jpg');
INSERT INTO `pms_product_image` VALUES ('104', '49', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFsbluyAKFB-AAA2oBvXGRY416.jpg');
INSERT INTO `pms_product_image` VALUES ('105', '50', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AHIQrAAB9_p5yd_4967.jpg');
INSERT INTO `pms_product_image` VALUES ('106', '50', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AFwIqAABLvWYyykI463.jpg');
INSERT INTO `pms_product_image` VALUES ('107', '50', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2Ae8JQAABGOuGpu5s305.jpg');
INSERT INTO `pms_product_image` VALUES ('108', '52', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFtlGF2AaZE_AAA2oBvXGRY923.jpg');
INSERT INTO `pms_product_image` VALUES ('109', '52', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFtlGF2AAdS-AACnL2DEmZI442.jpg');
INSERT INTO `pms_product_image` VALUES ('110', '52', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFtlGF2ATVl7AABLvWYyykI587.jpg');
INSERT INTO `pms_product_image` VALUES ('111', '53', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ2AaFK9AACQ33CNBgI041.jpg');
INSERT INTO `pms_product_image` VALUES ('112', '53', 'u=1780590834,74343091&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ2AeWKOAAAbekxUTwU697.jpg');
INSERT INTO `pms_product_image` VALUES ('113', '53', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ2AQXzoAABQITqS23s283.jpg');
INSERT INTO `pms_product_image` VALUES ('114', '53', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ6AMBKmAABGlNSsc8k506.jpg');
INSERT INTO `pms_product_image` VALUES ('115', '53', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ6AKJbhAAB9_p5yd_4702.jpg');
INSERT INTO `pms_product_image` VALUES ('116', '54', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKnaAIeu3AACnL2DEmZI636.jpg');
INSERT INTO `pms_product_image` VALUES ('117', '54', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKniAbY-aAABGlNSsc8k152.jpg');
INSERT INTO `pms_product_image` VALUES ('118', '54', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKnuARNVPAACQ33CNBgI197.jpg');
INSERT INTO `pms_product_image` VALUES ('119', '54', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKn6AfKNyAAA2oBvXGRY513.jpg');
INSERT INTO `pms_product_image` VALUES ('120', '54', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKoKAdFhTAABQITqS23s208.jpg');
INSERT INTO `pms_product_image` VALUES ('121', '56', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFvSx9qANH1cAACnL2DEmZI786.jpg');
INSERT INTO `pms_product_image` VALUES ('122', '56', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFvSx9qAN_XRAABQITqS23s970.jpg');
INSERT INTO `pms_product_image` VALUES ('123', '56', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFvSx9qAWYl9AABGlNSsc8k677.jpg');
INSERT INTO `pms_product_image` VALUES ('124', '57', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFvSyQeAECBwAACnL2DEmZI360.jpg');
INSERT INTO `pms_product_image` VALUES ('125', '57', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFvSyQiARDy6AABGlNSsc8k804.jpg');
INSERT INTO `pms_product_image` VALUES ('126', '59', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVKb2AABGOuGpu5s269.jpg');
INSERT INTO `pms_product_image` VALUES ('127', '60', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVKb2AABGOuGpu5s269.jpg');
INSERT INTO `pms_product_image` VALUES ('128', '59', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAcMexAABLvWYyykI946.jpg');
INSERT INTO `pms_product_image` VALUES ('129', '60', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAcMexAABLvWYyykI946.jpg');
INSERT INTO `pms_product_image` VALUES ('130', '59', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAJqDBAAB9_p5yd_4998.jpg');
INSERT INTO `pms_product_image` VALUES ('131', '60', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAJqDBAAB9_p5yd_4998.jpg');
INSERT INTO `pms_product_image` VALUES ('132', '59', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVNBaAABQITqS23s774.jpg');
INSERT INTO `pms_product_image` VALUES ('133', '60', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVNBaAABQITqS23s774.jpg');
INSERT INTO `pms_product_image` VALUES ('134', '59', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAZLfGAACQ33CNBgI915.jpg');
INSERT INTO `pms_product_image` VALUES ('135', '60', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAZLfGAACQ33CNBgI915.jpg');
INSERT INTO `pms_product_image` VALUES ('136', '61', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVKb2AABGOuGpu5s269.jpg');
INSERT INTO `pms_product_image` VALUES ('137', '61', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAcMexAABLvWYyykI946.jpg');
INSERT INTO `pms_product_image` VALUES ('138', '61', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAJqDBAAB9_p5yd_4998.jpg');
INSERT INTO `pms_product_image` VALUES ('139', '61', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVNBaAABQITqS23s774.jpg');
INSERT INTO `pms_product_image` VALUES ('140', '61', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAZLfGAACQ33CNBgI915.jpg');
INSERT INTO `pms_product_image` VALUES ('141', '62', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eAaSYEAAA2oBvXGRY401.jpg');
INSERT INTO `pms_product_image` VALUES ('142', '62', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eAdFQvAAAjTcYpOHA003.jpg');
INSERT INTO `pms_product_image` VALUES ('143', '62', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eABtqcAACQ33CNBgI768.jpg');
INSERT INTO `pms_product_image` VALUES ('144', '62', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eAAo2gAABQITqS23s583.jpg');
INSERT INTO `pms_product_image` VALUES ('145', '62', 'u=1780590834,74343091&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eAA68tAAAbekxUTwU639.jpg');
INSERT INTO `pms_product_image` VALUES ('146', '63', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWACoy4AACnL2DEmZI102.jpg');
INSERT INTO `pms_product_image` VALUES ('147', '63', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAfb40AAB9_p5yd_4956.jpg');
INSERT INTO `pms_product_image` VALUES ('148', '63', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAEvBGAABGlNSsc8k780.jpg');
INSERT INTO `pms_product_image` VALUES ('149', '63', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAJoNKAAAqaC4JyRU792.jpg');
INSERT INTO `pms_product_image` VALUES ('150', '63', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAMaUQAABGlNSsc8k628.jpg');
INSERT INTO `pms_product_image` VALUES ('151', '65', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAcDhdAABGOuGpu5s589.jpg');
INSERT INTO `pms_product_image` VALUES ('152', '65', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAQ_irAACnL2DEmZI499.jpg');
INSERT INTO `pms_product_image` VALUES ('153', '65', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAYYSfAABLvWYyykI766.jpg');
INSERT INTO `pms_product_image` VALUES ('154', '65', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAYyjjAAB9_p5yd_4003.jpg');
INSERT INTO `pms_product_image` VALUES ('155', '65', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAHVayAAAqaC4JyRU135.jpg');
INSERT INTO `pms_product_image` VALUES ('156', '67', '1b8b7adc44077012.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QjpqAfTrmAAWDML5OryE262.jpg');
INSERT INTO `pms_product_image` VALUES ('157', '67', '4e9924f5f9a516b4.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QjtCAaVGlAAOduv80spo875.jpg');
INSERT INTO `pms_product_image` VALUES ('158', '67', '6c51d90f7af6df1e.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QjtOAf7wMAAWWpWLFlK8226.jpg');
INSERT INTO `pms_product_image` VALUES ('159', '67', '8d5b5d9f05b511c6.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QjteAZAvvAAP3QwZJ49E665.jpg');
INSERT INTO `pms_product_image` VALUES ('160', '67', '8fe6389dc26d92c3.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6Qjt-AC086AAegWcR4Uns339.jpg');
INSERT INTO `pms_product_image` VALUES ('161', '67', '92a508ee721879d5.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QjuKARNpNAAt4tcEgVtQ479.jpg');
INSERT INTO `pms_product_image` VALUES ('162', '67', '0096c51a4f8287b8.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QjuSASA0xAAKBJt6QOQQ467.jpg');
INSERT INTO `pms_product_image` VALUES ('163', '67', 'ad95ec7acbec8e24.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QjuaAZZPjAAVT4zj6xjw669.jpg');
INSERT INTO `pms_product_image` VALUES ('164', '67', 'b7e505db2f240837.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QjumAQAYjAAP7KGHle6k018.jpg');
INSERT INTO `pms_product_image` VALUES ('165', '67', 'd199d46cf4f987cf.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QjuuAFqrcAANqaGBseIg100.jpg');
INSERT INTO `pms_product_image` VALUES ('166', '68', '2263ace0dec986cb.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoVWAV9rgAAEg6tY5TWQ561.jpg');
INSERT INTO `pms_product_image` VALUES ('167', '68', '6c6541ea663d3790.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoVWAeAnnAAKs3iO7aEI476.jpg');
INSERT INTO `pms_product_image` VALUES ('168', '68', 'a1b36814393b295f.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoVWAd-lAAAF7QQBIXuU993.jpg');
INSERT INTO `pms_product_image` VALUES ('169', '68', '81694e4b4a1da8aa.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoVWAIj0_AAH87Lap010610.jpg');
INSERT INTO `pms_product_image` VALUES ('170', '68', '8b7bd59c268decd6.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoVWAWEGLAAGmYHqwC4U938.jpg');
INSERT INTO `pms_product_image` VALUES ('171', '68', '117bbec127b5193b.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoVWAK5BdAAXuTtZ0usk700.jpg');
INSERT INTO `pms_product_image` VALUES ('172', '68', '6a3c5baf47aec7d7.png', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoVWADgPkAAYMbdfvOpc912.png');
INSERT INTO `pms_product_image` VALUES ('173', '69', '2f63d53828761609.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg');
INSERT INTO `pms_product_image` VALUES ('174', '69', '93ac3e51e65e4058.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAYAJAAADxHhrWGek412.jpg');
INSERT INTO `pms_product_image` VALUES ('175', '69', '98e92fd374f80591.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuACWHEAAE2oopE404661.jpg');
INSERT INTO `pms_product_image` VALUES ('176', '69', '707e9b920ef8d97f.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAcTzgAADwoyf0uBo521.jpg');
INSERT INTO `pms_product_image` VALUES ('177', '69', '95c466bf55123b4c.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFcZ1AAK8X_B46QA917.jpg');
INSERT INTO `pms_product_image` VALUES ('178', '69', '936bfc7036257aca.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAGbOnAAHtrWBC-gY515.jpg');
INSERT INTO `pms_product_image` VALUES ('179', '69', '61f65ac6aae3146b.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAIWZrAAdGruigDZs562.jpg');
INSERT INTO `pms_product_image` VALUES ('180', '69', '8593bb926e2fa1ea.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuABu06AAMy6xI8ljs330.jpg');
INSERT INTO `pms_product_image` VALUES ('181', '70', '80c05c1914a6aa92 (1).jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOABlzsAANkkyc3rIg895.jpg');
INSERT INTO `pms_product_image` VALUES ('182', '70', '801a0f54f2e21580.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOALSeAAAHG5NpN_9M133.jpg');
INSERT INTO `pms_product_image` VALUES ('183', '70', '80c05c1914a6aa92.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAeHfOAANkkyc3rIg077.jpg');
INSERT INTO `pms_product_image` VALUES ('184', '70', '801a0f54f2e21580 (1).jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAQHmEAAHG5NpN_9M960.jpg');
INSERT INTO `pms_product_image` VALUES ('185', '70', 'ad078902888a8a75.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAdWUuAAM1VjldK8c206.jpg');
INSERT INTO `pms_product_image` VALUES ('186', '70', 'c3935cb7e2017f6c.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAcj2tAAM1VjldK8c189.jpg');
INSERT INTO `pms_product_image` VALUES ('187', '70', 'b8116bbbc2e4e731.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOALtbnAAIbO5uH5xk974.jpg');
INSERT INTO `pms_product_image` VALUES ('188', '70', '68bbfe6f9d3ccb4c (1).jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAAUl1AAMh04qlip0511.jpg');
INSERT INTO `pms_product_image` VALUES ('189', '70', '1547dc8a371330fc.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAT3H9AAFU1ohvSUo007.jpg');
INSERT INTO `pms_product_image` VALUES ('190', '70', '9bca664ff863a1a4.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAYrcjAATE5rZEXkU173.jpg');
INSERT INTO `pms_product_image` VALUES ('191', '70', '68bbfe6f9d3ccb4c.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAXY4JAAMh04qlip0275.jpg');
INSERT INTO `pms_product_image` VALUES ('192', '70', '18106ce3d8bb593a.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAd33TAANTQTjaVjQ527.jpg');
INSERT INTO `pms_product_image` VALUES ('193', '70', 'dd6f142f583663bb.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAfag6AAOT2MVegzo895.jpg');
INSERT INTO `pms_product_image` VALUES ('194', '70', 'ff57b3d2436d705f.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAb3QsAAFyUHUJwfA466.jpg');
INSERT INTO `pms_product_image` VALUES ('195', '70', 'eae52491289f4569.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAS2kbAAM1Vow6zNE734.jpg');
INSERT INTO `pms_product_image` VALUES ('196', '70', '3d3fd1f8aceb3c73.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAQ7YlAAMjfPL4Ww0296.jpg');
INSERT INTO `pms_product_image` VALUES ('197', '70', '2f2ca5de28c6ed56.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAA0QwAAQ_OUORm1Q588.jpg');
INSERT INTO `pms_product_image` VALUES ('198', '70', '752c121d28917650.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAbbG-AAJLlrZtO5k007.jpg');
INSERT INTO `pms_product_image` VALUES ('199', '70', 'abd88adcaa54018e.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAHMGIAAHSeeR4e2Y238.jpg');
INSERT INTO `pms_product_image` VALUES ('200', '70', '8a3b41a10259aa84.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAS1UkAAKT3mXV0cU443.jpg');
INSERT INTO `pms_product_image` VALUES ('201', '70', '2f63d53828761609.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAKn4CAARDAkbMoEI429.jpg');

-- ----------------------------
-- Table structure for `pms_product_info`
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_info`;
CREATE TABLE `pms_product_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `product_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `description` varchar(1000) DEFAULT NULL COMMENT '商品描述(后台简述）',
  `catalog3_id` bigint(20) DEFAULT NULL COMMENT '三级分类id',
  `tm_id` bigint(20) DEFAULT NULL COMMENT '品牌id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pms_product_info
-- ----------------------------
INSERT INTO `pms_product_info` VALUES ('24', '小米6', '小米6变焦双摄！5.15”屏幕，四曲面机身，骁龙835处理器！', '61', null);
INSERT INTO `pms_product_info` VALUES ('25', '小米硅谷测试双摄像头AI系列', '硅谷测试双摄像头宽屏幕手机A1系列硅谷测试双摄像头宽屏幕手机A1系列', '61', null);
INSERT INTO `pms_product_info` VALUES ('26', 'Apple iPhone 6s Plus (A1699)', 'Apple iPhone 6s Plus (A1699)Apple iPhone 6s Plus (A1699)Apple iPhone 6s Plus (A1699)Apple iPhone 6s Plus (A1699)', '61', null);
INSERT INTO `pms_product_info` VALUES ('27', 'Apple iPhone 8s Plus (A1699)', 'Apple iPhone 8s Plus (A1699)Apple iPhone 8s Plus (A1699)Apple iPhone 8s Plus (A1699)Apple iPhone 8s Plus (A1699)', '61', null);
INSERT INTO `pms_product_info` VALUES ('28', ' Apple iPhone 8 (A1863)黑糊糊', ' Apple iPhone 8 (A1863) Apple iPhone 8 (A1863) Apple iPhone 8 (A1863)', '61', null);
INSERT INTO `pms_product_info` VALUES ('30', 'asdfasdfsf', 'sdfsaf', '61', null);
INSERT INTO `pms_product_info` VALUES ('31', '测试100', '测试100', '61', null);
INSERT INTO `pms_product_info` VALUES ('32', 'spu的信息', 'spu的信息', '61', null);
INSERT INTO `pms_product_info` VALUES ('33', 'spu测试10000', 'spu测试10000', '61', null);
INSERT INTO `pms_product_info` VALUES ('34', '华为 畅享6', '华为 畅享6', '61', null);
INSERT INTO `pms_product_info` VALUES ('35', '小米 红米 4A', '小米 红米 4A', '61', null);
INSERT INTO `pms_product_info` VALUES ('36', '测试商品234', '测试商品234', '61', null);
INSERT INTO `pms_product_info` VALUES ('37', '测试商品56', '测试商品56', '61', null);
INSERT INTO `pms_product_info` VALUES ('38', '测试商品88', '测试商品88', '61', null);
INSERT INTO `pms_product_info` VALUES ('39', '测试商品89', '测试商品89', '61', null);
INSERT INTO `pms_product_info` VALUES ('40', '测试商品99', '测试商品99', '61', null);
INSERT INTO `pms_product_info` VALUES ('41', '荣耀10 全面屏AI摄影手机', '荣耀10 全面屏AI摄影手机', '61', null);
INSERT INTO `pms_product_info` VALUES ('42', '荣耀10 全面屏AI摄影手机', '荣耀10 全面屏AI摄影手机', '61', null);
INSERT INTO `pms_product_info` VALUES ('43', '123123', '123123', '61', null);
INSERT INTO `pms_product_info` VALUES ('44', 'apple 1 ', 'apple 1 ', '61', null);
INSERT INTO `pms_product_info` VALUES ('45', '测试销售属性spu', '测试销售属性spu', '61', null);
INSERT INTO `pms_product_info` VALUES ('47', 'Apple iPhone 7 (A1660)', 'Apple iPhone 7 (A1660)', '61', null);
INSERT INTO `pms_product_info` VALUES ('48', '硅谷无限充电无人机操控黑科技版apple10', '硅谷无限充电无人机操控黑科技版apple10', '61', null);
INSERT INTO `pms_product_info` VALUES ('49', '硅谷无限充电无人机操控黑科技版apple11', '硅谷无限充电无人机操控黑科技版apple11', '61', null);
INSERT INTO `pms_product_info` VALUES ('50', '新型ai容错手机', '新型ai手机', '61', null);
INSERT INTO `pms_product_info` VALUES ('52', '测试手机0000001', '测试手机0000001测试手机0000001测试手机0000001', '61', null);
INSERT INTO `pms_product_info` VALUES ('53', '尚硅谷超长待机系列A', '尚硅谷超长待机系列A尚硅谷超长待机系列A尚硅谷超长待机系列A', '61', null);
INSERT INTO `pms_product_info` VALUES ('54', '尚硅谷无人驾驶手机R720拯救者系列', '尚硅谷无人驾驶手机R720拯救者系列', '61', null);
INSERT INTO `pms_product_info` VALUES ('55', '硅谷深圳智能手机I系列', '硅谷深圳智能手机I系列', '61', null);
INSERT INTO `pms_product_info` VALUES ('56', '硅谷手机系列3', '硅谷手机系列3', '61', null);
INSERT INTO `pms_product_info` VALUES ('57', '硅谷手机测试4', '硅谷手机测试4', '61', null);
INSERT INTO `pms_product_info` VALUES ('58', '硅谷电商手机0725型', '硅谷电商手机0725型硅谷电商手机0725型硅谷电商手机0725型硅谷电商手机0725型66666666666666666666666666666', '61', null);
INSERT INTO `pms_product_info` VALUES ('59', '尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB', '小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB', '61', null);
INSERT INTO `pms_product_info` VALUES ('60', '尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB', '小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB', '61', null);
INSERT INTO `pms_product_info` VALUES ('61', '尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB', '小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB小米8 全面屏游戏智能手机 6GB+64GB', '61', null);
INSERT INTO `pms_product_info` VALUES ('62', '尚硅谷0725测试游戏手机(n系列)', '尚硅谷0725测试游戏手机(n系列)尚硅谷0725测试游戏手机(n系列)尚硅谷0725测试游戏手机(n系列)尚硅谷0725测试游戏手机(n系列)尚硅谷0725测试游戏手机(n系列)尚硅谷0725测试游戏手机(n系列)尚硅谷0725测试游戏手机(n系列)', '61', null);
INSERT INTO `pms_product_info` VALUES ('63', '尚硅谷课堂测试手机0906系列', '尚硅谷课堂测试手机0906系列', '61', null);
INSERT INTO `pms_product_info` VALUES ('64', 'Apple iPhone 8 Plus (A1864) ', 'Apple iPhone 8 Plus (A1864) 非常不好，贵', '61', null);
INSERT INTO `pms_product_info` VALUES ('65', '黑鲨游戏手机Gmall1015系列', '黑鲨游戏手机Gmall1015系列黑鲨游戏手机Gmall1015系列黑鲨游戏手机Gmall1015系列黑鲨游戏手机Gmall1015系列', '61', null);
INSERT INTO `pms_product_info` VALUES ('67', '华为 HUAWEI Mate 30 5G', '麒麟990 4000万超感光徕卡影像双超级快充8GB+128GB丹霞橙5G全网通游戏手机 ', '61', null);
INSERT INTO `pms_product_info` VALUES ('68', '华为nova6手机', '全网通5G手机 亮黑色 5G版 8G+128 ', '61', null);
INSERT INTO `pms_product_info` VALUES ('69', '荣耀9X', '麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB ', '61', null);
INSERT INTO `pms_product_info` VALUES ('70', 'Apple iPhone 11 (A2223)', 'Apple iPhone 11 (A2223)  移动联通电信4G手机 双卡双待', '61', null);

-- ----------------------------
-- Table structure for `pms_product_sale_attr`
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_sale_attr`;
CREATE TABLE `pms_product_sale_attr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `sale_attr_id` bigint(20) DEFAULT NULL COMMENT '销售属性id',
  `sale_attr_name` varchar(20) DEFAULT NULL COMMENT '销售属性名称(冗余)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pms_product_sale_attr
-- ----------------------------
INSERT INTO `pms_product_sale_attr` VALUES ('23', '11', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('24', '24', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('25', '24', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('30', '25', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('31', '25', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('32', '25', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('33', '25', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('34', '26', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('35', '26', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('36', '27', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('37', '27', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('38', '28', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('39', '29', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('40', '30', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('41', '30', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('42', '31', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('43', '32', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('44', '32', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('45', '33', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('46', '34', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('47', '34', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('48', '35', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('49', '35', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('50', '36', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('51', '37', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('52', '38', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('53', '39', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('54', '40', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('55', '41', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('56', '42', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('57', '43', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('58', '44', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('59', '44', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('60', '45', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('61', '45', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('62', '45', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('63', '46', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('64', '46', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('65', '46', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('66', '47', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('67', '47', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('68', '47', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('69', '48', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('70', '49', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('71', '50', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('72', '50', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('73', '52', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('74', '52', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('75', '53', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('76', '53', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('77', '54', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('78', '54', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('79', '55', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('80', '55', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('81', '56', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('82', '56', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('83', '57', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('84', '58', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('85', '58', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('86', '59', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('87', '60', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('88', '59', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('89', '60', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('90', '61', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('91', '61', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('92', '62', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('93', '62', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('94', '63', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('95', '63', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('96', '64', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('97', '64', '2', '尺寸');
INSERT INTO `pms_product_sale_attr` VALUES ('98', '64', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('99', '65', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('100', '65', '4', '容量');
INSERT INTO `pms_product_sale_attr` VALUES ('101', '67', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('102', '67', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('103', '68', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('104', '68', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('105', '69', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('106', '69', '3', '版本');
INSERT INTO `pms_product_sale_attr` VALUES ('107', '70', '1', '颜色');
INSERT INTO `pms_product_sale_attr` VALUES ('108', '70', '4', '容量');

-- ----------------------------
-- Table structure for `pms_product_sale_attr_value`
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_sale_attr_value`;
CREATE TABLE `pms_product_sale_attr_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `sale_attr_id` bigint(20) DEFAULT NULL COMMENT '销售属性id',
  `sale_attr_value_name` varchar(20) DEFAULT NULL COMMENT '销售属性值名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8 COMMENT='spu销售属性值';

-- ----------------------------
-- Records of pms_product_sale_attr_value
-- ----------------------------
INSERT INTO `pms_product_sale_attr_value` VALUES ('1', '10', '1', 'rrr');
INSERT INTO `pms_product_sale_attr_value` VALUES ('2', '10', '1', 'bbb');
INSERT INTO `pms_product_sale_attr_value` VALUES ('3', '10', '2', 'xxx');
INSERT INTO `pms_product_sale_attr_value` VALUES ('4', '10', '2', 'lll');
INSERT INTO `pms_product_sale_attr_value` VALUES ('10', '21', '1', '蓝色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('11', '21', '1', '太空银');
INSERT INTO `pms_product_sale_attr_value` VALUES ('12', '22', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('13', '22', '1', '绿色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('14', '22', '1', '紫色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('15', '23', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('16', '23', '1', '绿色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('17', '23', '1', '紫色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('18', '23', '2', '大');
INSERT INTO `pms_product_sale_attr_value` VALUES ('19', '23', '2', '小');
INSERT INTO `pms_product_sale_attr_value` VALUES ('44', '11', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('45', '11', '1', '蓝色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('46', '24', '1', '陶瓷黑');
INSERT INTO `pms_product_sale_attr_value` VALUES ('47', '24', '1', '亮黑');
INSERT INTO `pms_product_sale_attr_value` VALUES ('48', '24', '1', '亮蓝');
INSERT INTO `pms_product_sale_attr_value` VALUES ('49', '24', '4', '4G+64G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('50', '24', '4', '6G+128G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('63', '25', '2', '1尺');
INSERT INTO `pms_product_sale_attr_value` VALUES ('64', '25', '2', '2尺');
INSERT INTO `pms_product_sale_attr_value` VALUES ('65', '25', '2', '3尺');
INSERT INTO `pms_product_sale_attr_value` VALUES ('66', '25', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('67', '25', '1', '蓝色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('68', '25', '1', '白色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('69', '25', '3', 'A版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('70', '25', '3', 'B版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('71', '25', '3', 'C版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('72', '25', '4', '10G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('73', '25', '4', '11G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('74', '25', '4', '12G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('75', '26', '1', '蓝色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('76', '26', '1', '紫色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('77', '26', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('78', '26', '1', '绿色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('79', '26', '3', '牛版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('80', '26', '3', '盗版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('81', '26', '3', '次版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('82', '26', '3', '山寨版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('83', '27', '3', '1');
INSERT INTO `pms_product_sale_attr_value` VALUES ('84', '27', '3', '2');
INSERT INTO `pms_product_sale_attr_value` VALUES ('85', '27', '3', '3');
INSERT INTO `pms_product_sale_attr_value` VALUES ('86', '27', '2', '11');
INSERT INTO `pms_product_sale_attr_value` VALUES ('87', '27', '2', '12');
INSERT INTO `pms_product_sale_attr_value` VALUES ('88', '27', '2', '13');
INSERT INTO `pms_product_sale_attr_value` VALUES ('89', '28', '4', '100');
INSERT INTO `pms_product_sale_attr_value` VALUES ('90', '28', '4', '200');
INSERT INTO `pms_product_sale_attr_value` VALUES ('91', '28', '4', '300');
INSERT INTO `pms_product_sale_attr_value` VALUES ('92', '29', '1', '444');
INSERT INTO `pms_product_sale_attr_value` VALUES ('93', '30', '1', '123123');
INSERT INTO `pms_product_sale_attr_value` VALUES ('94', '30', '2', 'qwewqeqe');
INSERT INTO `pms_product_sale_attr_value` VALUES ('95', '31', '3', '版本1');
INSERT INTO `pms_product_sale_attr_value` VALUES ('96', '32', '3', 'a版本');
INSERT INTO `pms_product_sale_attr_value` VALUES ('97', '32', '3', 'b版本');
INSERT INTO `pms_product_sale_attr_value` VALUES ('98', '32', '4', '10');
INSERT INTO `pms_product_sale_attr_value` VALUES ('99', '32', '4', '20');
INSERT INTO `pms_product_sale_attr_value` VALUES ('100', '33', '3', '1版本');
INSERT INTO `pms_product_sale_attr_value` VALUES ('101', '34', '1', '12');
INSERT INTO `pms_product_sale_attr_value` VALUES ('102', '34', '1', '13');
INSERT INTO `pms_product_sale_attr_value` VALUES ('103', '34', '2', '1G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('104', '34', '2', '2G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('105', '35', '1', '绿色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('106', '35', '1', '花色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('107', '35', '3', '盗版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('108', '35', '3', '高仿');
INSERT INTO `pms_product_sale_attr_value` VALUES ('109', '36', '3', '22');
INSERT INTO `pms_product_sale_attr_value` VALUES ('110', '36', '3', '23');
INSERT INTO `pms_product_sale_attr_value` VALUES ('111', '37', '1', '111');
INSERT INTO `pms_product_sale_attr_value` VALUES ('112', '37', '1', '112');
INSERT INTO `pms_product_sale_attr_value` VALUES ('113', '38', '4', '234');
INSERT INTO `pms_product_sale_attr_value` VALUES ('114', '38', '4', '235');
INSERT INTO `pms_product_sale_attr_value` VALUES ('115', '39', '2', '1尺');
INSERT INTO `pms_product_sale_attr_value` VALUES ('116', '39', '2', '2尺');
INSERT INTO `pms_product_sale_attr_value` VALUES ('117', '40', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('118', '40', '1', '蓝色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('119', '41', '3', 'a版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('120', '41', '3', 'b版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('121', '42', '3', 'a版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('122', '42', '3', 'b版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('123', '43', '2', '111');
INSERT INTO `pms_product_sale_attr_value` VALUES ('124', '43', '2', '222');
INSERT INTO `pms_product_sale_attr_value` VALUES ('125', '43', '2', '333');
INSERT INTO `pms_product_sale_attr_value` VALUES ('126', '44', '4', '100');
INSERT INTO `pms_product_sale_attr_value` VALUES ('127', '44', '4', '200');
INSERT INTO `pms_product_sale_attr_value` VALUES ('128', '44', '2', '1');
INSERT INTO `pms_product_sale_attr_value` VALUES ('129', '44', '2', '2');
INSERT INTO `pms_product_sale_attr_value` VALUES ('130', '45', '1', '测试色1');
INSERT INTO `pms_product_sale_attr_value` VALUES ('131', '45', '1', '测试色2');
INSERT INTO `pms_product_sale_attr_value` VALUES ('132', '45', '1', '测试色3');
INSERT INTO `pms_product_sale_attr_value` VALUES ('133', '45', '2', '测试1寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('134', '45', '2', '测试2寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('135', '45', '2', '测试3寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('136', '45', '3', '测试1版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('137', '45', '3', '测试2版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('138', '45', '3', '测试3版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('139', '46', '1', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('140', '46', '1', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('141', '46', '1', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('142', '46', '3', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('143', '46', '3', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('144', '46', '3', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('145', '46', '4', '1g');
INSERT INTO `pms_product_sale_attr_value` VALUES ('146', '46', '4', '2g');
INSERT INTO `pms_product_sale_attr_value` VALUES ('147', '46', '4', '3g');
INSERT INTO `pms_product_sale_attr_value` VALUES ('148', '47', '2', '1cun');
INSERT INTO `pms_product_sale_attr_value` VALUES ('149', '47', '2', '2cun');
INSERT INTO `pms_product_sale_attr_value` VALUES ('150', '47', '1', '红');
INSERT INTO `pms_product_sale_attr_value` VALUES ('151', '47', '1', '黄');
INSERT INTO `pms_product_sale_attr_value` VALUES ('152', '47', '1', '蓝');
INSERT INTO `pms_product_sale_attr_value` VALUES ('153', '47', '4', '1g');
INSERT INTO `pms_product_sale_attr_value` VALUES ('154', '47', '4', '2g');
INSERT INTO `pms_product_sale_attr_value` VALUES ('155', '48', '3', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('156', '48', '3', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('157', '48', '3', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('158', '49', '3', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('159', '49', '3', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('160', '49', '3', '默认销售属性值名称');
INSERT INTO `pms_product_sale_attr_value` VALUES ('161', '50', '3', 'A1');
INSERT INTO `pms_product_sale_attr_value` VALUES ('162', '50', '3', 'B2');
INSERT INTO `pms_product_sale_attr_value` VALUES ('163', '50', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('164', '50', '1', '黑色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('165', '52', '2', '1');
INSERT INTO `pms_product_sale_attr_value` VALUES ('166', '52', '2', '2');
INSERT INTO `pms_product_sale_attr_value` VALUES ('167', '52', '1', '红');
INSERT INTO `pms_product_sale_attr_value` VALUES ('168', '52', '1', '蓝');
INSERT INTO `pms_product_sale_attr_value` VALUES ('169', '53', '3', '两天版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('170', '53', '3', '三天版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('171', '53', '3', '一年版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('172', '53', '1', '迷彩');
INSERT INTO `pms_product_sale_attr_value` VALUES ('173', '53', '1', '绿色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('174', '53', '1', '土黄');
INSERT INTO `pms_product_sale_attr_value` VALUES ('175', '53', '1', '灰色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('176', '54', '3', 'A版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('177', '54', '3', 'B版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('178', '54', '3', 'C版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('179', '54', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('180', '54', '1', '硅谷蓝');
INSERT INTO `pms_product_sale_attr_value` VALUES ('181', '55', '4', '10');
INSERT INTO `pms_product_sale_attr_value` VALUES ('182', '55', '4', '20');
INSERT INTO `pms_product_sale_attr_value` VALUES ('183', '55', '1', '硅谷绿');
INSERT INTO `pms_product_sale_attr_value` VALUES ('184', '55', '1', '王者绿');
INSERT INTO `pms_product_sale_attr_value` VALUES ('185', '56', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('186', '56', '1', '黑色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('187', '56', '3', 'b');
INSERT INTO `pms_product_sale_attr_value` VALUES ('188', '56', '3', 'c');
INSERT INTO `pms_product_sale_attr_value` VALUES ('189', '56', '3', 'd');
INSERT INTO `pms_product_sale_attr_value` VALUES ('190', '57', '3', 'aaa');
INSERT INTO `pms_product_sale_attr_value` VALUES ('191', '57', '3', 'bbb');
INSERT INTO `pms_product_sale_attr_value` VALUES ('192', '58', '1', '绿色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('193', '58', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('194', '58', '1', '银色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('195', '58', '2', '4寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('196', '58', '2', '5寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('197', '58', '2', '7寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('198', '59', '1', '花色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('199', '59', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('200', '60', '1', '花色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('201', '60', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('202', '59', '2', '4寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('203', '59', '2', '5寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('204', '60', '2', '4寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('205', '59', '2', '6寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('206', '60', '2', '5寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('207', '60', '2', '6寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('208', '61', '1', '花色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('209', '61', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('210', '61', '2', '4寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('211', '61', '2', '5寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('212', '61', '2', '6寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('213', '62', '2', '5寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('214', '62', '2', '6寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('215', '62', '2', '7寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('216', '62', '4', '8G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('217', '62', '4', '16G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('218', '63', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('219', '63', '1', '蓝色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('220', '63', '3', 'a版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('221', '63', '3', 'b版');
INSERT INTO `pms_product_sale_attr_value` VALUES ('222', '64', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('223', '64', '1', '白色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('224', '64', '2', '5寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('225', '64', '2', '5.5寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('226', '64', '2', '7寸');
INSERT INTO `pms_product_sale_attr_value` VALUES ('227', '64', '3', 'A');
INSERT INTO `pms_product_sale_attr_value` VALUES ('228', '64', '3', 'B');
INSERT INTO `pms_product_sale_attr_value` VALUES ('229', '64', '3', 'C');
INSERT INTO `pms_product_sale_attr_value` VALUES ('230', '65', '1', '绿色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('231', '65', '1', '黑色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('232', '65', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('233', '65', '1', '白色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('234', '65', '1', '无色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('235', '65', '1', '变色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('236', '65', '4', '1T');
INSERT INTO `pms_product_sale_attr_value` VALUES ('237', '65', '4', '3T');
INSERT INTO `pms_product_sale_attr_value` VALUES ('238', '65', '4', '5T');
INSERT INTO `pms_product_sale_attr_value` VALUES ('239', '67', '1', '亮黑');
INSERT INTO `pms_product_sale_attr_value` VALUES ('240', '67', '1', '翡翠银');
INSERT INTO `pms_product_sale_attr_value` VALUES ('241', '67', '1', '罗兰紫');
INSERT INTO `pms_product_sale_attr_value` VALUES ('242', '67', '1', '青山黛');
INSERT INTO `pms_product_sale_attr_value` VALUES ('243', '67', '1', '丹霞橙');
INSERT INTO `pms_product_sale_attr_value` VALUES ('244', '67', '3', '8g+128g');
INSERT INTO `pms_product_sale_attr_value` VALUES ('245', '67', '3', '8g+256g');
INSERT INTO `pms_product_sale_attr_value` VALUES ('246', '68', '1', '亮黑5g');
INSERT INTO `pms_product_sale_attr_value` VALUES ('247', '68', '1', '普罗旺斯5g');
INSERT INTO `pms_product_sale_attr_value` VALUES ('248', '68', '1', '苏音蓝5G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('249', '68', '1', '密语红5G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('250', '68', '3', '8G+128G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('251', '68', '3', '8G+256G');
INSERT INTO `pms_product_sale_attr_value` VALUES ('252', '69', '1', '魅海蓝');
INSERT INTO `pms_product_sale_attr_value` VALUES ('253', '69', '1', '幻夜黑');
INSERT INTO `pms_product_sale_attr_value` VALUES ('254', '69', '1', '魅焰红');
INSERT INTO `pms_product_sale_attr_value` VALUES ('255', '69', '1', '冰岛白');
INSERT INTO `pms_product_sale_attr_value` VALUES ('256', '69', '3', '全网通(4G+64G)');
INSERT INTO `pms_product_sale_attr_value` VALUES ('257', '69', '3', '全网通(6G+64G)');
INSERT INTO `pms_product_sale_attr_value` VALUES ('258', '69', '3', '全网通(6G+128G)');
INSERT INTO `pms_product_sale_attr_value` VALUES ('259', '69', '3', '全网通(8G+128G)');
INSERT INTO `pms_product_sale_attr_value` VALUES ('260', '70', '1', '黑色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('261', '70', '1', '白色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('262', '70', '1', '红色');
INSERT INTO `pms_product_sale_attr_value` VALUES ('263', '70', '4', '64GB');
INSERT INTO `pms_product_sale_attr_value` VALUES ('264', '70', '4', '128GB');
INSERT INTO `pms_product_sale_attr_value` VALUES ('265', '70', '4', '256GB');

-- ----------------------------
-- Table structure for `pms_product_vertify_record`
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_vertify_record`;
CREATE TABLE `pms_product_vertify_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `vertify_man` varchar(64) DEFAULT NULL COMMENT '审核人',
  `status` int(1) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL COMMENT '反馈详情',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商品审核记录';

-- ----------------------------
-- Records of pms_product_vertify_record
-- ----------------------------
INSERT INTO `pms_product_vertify_record` VALUES ('1', '1', '2018-04-27 16:36:41', 'test', '1', '验证通过');
INSERT INTO `pms_product_vertify_record` VALUES ('2', '2', '2018-04-27 16:36:41', 'test', '1', '验证通过');

-- ----------------------------
-- Table structure for `pms_sku_attr_value`
-- ----------------------------
DROP TABLE IF EXISTS `pms_sku_attr_value`;
CREATE TABLE `pms_sku_attr_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `attr_id` bigint(20) DEFAULT NULL COMMENT '属性id（冗余)',
  `value_id` bigint(20) DEFAULT NULL COMMENT '属性值id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'skuid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=902 DEFAULT CHARSET=utf8 COMMENT='sku平台属性值关联表';

-- ----------------------------
-- Records of pms_sku_attr_value
-- ----------------------------
INSERT INTO `pms_sku_attr_value` VALUES ('57', '25', '41', '13');
INSERT INTO `pms_sku_attr_value` VALUES ('58', '26', '45', '13');
INSERT INTO `pms_sku_attr_value` VALUES ('61', '25', '41', '11');
INSERT INTO `pms_sku_attr_value` VALUES ('62', '26', '45', '11');
INSERT INTO `pms_sku_attr_value` VALUES ('63', '25', '41', '14');
INSERT INTO `pms_sku_attr_value` VALUES ('64', '26', '46', '14');
INSERT INTO `pms_sku_attr_value` VALUES ('65', '25', '41', '12');
INSERT INTO `pms_sku_attr_value` VALUES ('66', '26', '45', '12');
INSERT INTO `pms_sku_attr_value` VALUES ('67', '25', '40', '15');
INSERT INTO `pms_sku_attr_value` VALUES ('68', '26', '45', '15');
INSERT INTO `pms_sku_attr_value` VALUES ('69', '12', '50', '15');
INSERT INTO `pms_sku_attr_value` VALUES ('70', '13', '52', '15');
INSERT INTO `pms_sku_attr_value` VALUES ('79', '25', '41', '20');
INSERT INTO `pms_sku_attr_value` VALUES ('80', '26', '44', '20');
INSERT INTO `pms_sku_attr_value` VALUES ('81', '12', '50', '20');
INSERT INTO `pms_sku_attr_value` VALUES ('82', '13', '52', '20');
INSERT INTO `pms_sku_attr_value` VALUES ('83', '25', '41', '21');
INSERT INTO `pms_sku_attr_value` VALUES ('84', '26', '44', '21');
INSERT INTO `pms_sku_attr_value` VALUES ('85', '12', '50', '21');
INSERT INTO `pms_sku_attr_value` VALUES ('86', '13', '52', '21');
INSERT INTO `pms_sku_attr_value` VALUES ('91', '25', '39', '23');
INSERT INTO `pms_sku_attr_value` VALUES ('92', '26', '43', '23');
INSERT INTO `pms_sku_attr_value` VALUES ('93', '12', '48', '23');
INSERT INTO `pms_sku_attr_value` VALUES ('94', '13', '51', '23');
INSERT INTO `pms_sku_attr_value` VALUES ('103', '25', '39', '26');
INSERT INTO `pms_sku_attr_value` VALUES ('104', '26', '45', '26');
INSERT INTO `pms_sku_attr_value` VALUES ('105', '12', '48', '26');
INSERT INTO `pms_sku_attr_value` VALUES ('106', '13', '51', '26');
INSERT INTO `pms_sku_attr_value` VALUES ('107', '25', '39', '27');
INSERT INTO `pms_sku_attr_value` VALUES ('108', '26', '43', '27');
INSERT INTO `pms_sku_attr_value` VALUES ('109', '12', '48', '27');
INSERT INTO `pms_sku_attr_value` VALUES ('110', '13', '51', '27');
INSERT INTO `pms_sku_attr_value` VALUES ('111', '25', '39', '28');
INSERT INTO `pms_sku_attr_value` VALUES ('112', '26', '43', '28');
INSERT INTO `pms_sku_attr_value` VALUES ('113', '12', '48', '28');
INSERT INTO `pms_sku_attr_value` VALUES ('114', '13', '51', '28');
INSERT INTO `pms_sku_attr_value` VALUES ('115', '25', '39', '29');
INSERT INTO `pms_sku_attr_value` VALUES ('116', '26', '43', '29');
INSERT INTO `pms_sku_attr_value` VALUES ('117', '12', '48', '29');
INSERT INTO `pms_sku_attr_value` VALUES ('118', '13', '51', '29');
INSERT INTO `pms_sku_attr_value` VALUES ('119', '25', '39', '30');
INSERT INTO `pms_sku_attr_value` VALUES ('120', '26', '43', '30');
INSERT INTO `pms_sku_attr_value` VALUES ('121', '12', '48', '30');
INSERT INTO `pms_sku_attr_value` VALUES ('122', '13', '51', '30');
INSERT INTO `pms_sku_attr_value` VALUES ('123', '25', '39', '31');
INSERT INTO `pms_sku_attr_value` VALUES ('124', '26', '43', '31');
INSERT INTO `pms_sku_attr_value` VALUES ('125', '12', '48', '31');
INSERT INTO `pms_sku_attr_value` VALUES ('126', '13', '51', '31');
INSERT INTO `pms_sku_attr_value` VALUES ('127', '25', '39', '32');
INSERT INTO `pms_sku_attr_value` VALUES ('128', '26', '43', '32');
INSERT INTO `pms_sku_attr_value` VALUES ('129', '12', '48', '32');
INSERT INTO `pms_sku_attr_value` VALUES ('130', '13', '51', '32');
INSERT INTO `pms_sku_attr_value` VALUES ('131', '25', '39', '33');
INSERT INTO `pms_sku_attr_value` VALUES ('132', '26', '43', '33');
INSERT INTO `pms_sku_attr_value` VALUES ('133', '12', '48', '33');
INSERT INTO `pms_sku_attr_value` VALUES ('134', '13', '51', '33');
INSERT INTO `pms_sku_attr_value` VALUES ('135', '25', '39', '34');
INSERT INTO `pms_sku_attr_value` VALUES ('136', '26', '43', '34');
INSERT INTO `pms_sku_attr_value` VALUES ('137', '12', '48', '34');
INSERT INTO `pms_sku_attr_value` VALUES ('138', '13', '51', '34');
INSERT INTO `pms_sku_attr_value` VALUES ('139', '25', '41', '35');
INSERT INTO `pms_sku_attr_value` VALUES ('140', '26', '44', '35');
INSERT INTO `pms_sku_attr_value` VALUES ('141', '12', '49', '35');
INSERT INTO `pms_sku_attr_value` VALUES ('142', '13', '52', '35');
INSERT INTO `pms_sku_attr_value` VALUES ('143', '25', '39', '36');
INSERT INTO `pms_sku_attr_value` VALUES ('144', '26', '43', '36');
INSERT INTO `pms_sku_attr_value` VALUES ('145', '12', '48', '36');
INSERT INTO `pms_sku_attr_value` VALUES ('146', '13', '51', '36');
INSERT INTO `pms_sku_attr_value` VALUES ('147', '25', '39', '37');
INSERT INTO `pms_sku_attr_value` VALUES ('148', '26', '43', '37');
INSERT INTO `pms_sku_attr_value` VALUES ('149', '12', '48', '37');
INSERT INTO `pms_sku_attr_value` VALUES ('150', '13', '51', '37');
INSERT INTO `pms_sku_attr_value` VALUES ('151', '25', '39', '38');
INSERT INTO `pms_sku_attr_value` VALUES ('152', '26', '43', '38');
INSERT INTO `pms_sku_attr_value` VALUES ('153', '12', '48', '38');
INSERT INTO `pms_sku_attr_value` VALUES ('154', '13', '51', '38');
INSERT INTO `pms_sku_attr_value` VALUES ('155', '25', '39', '39');
INSERT INTO `pms_sku_attr_value` VALUES ('156', '26', '43', '39');
INSERT INTO `pms_sku_attr_value` VALUES ('157', '12', '48', '39');
INSERT INTO `pms_sku_attr_value` VALUES ('158', '13', '51', '39');
INSERT INTO `pms_sku_attr_value` VALUES ('159', '25', '39', '40');
INSERT INTO `pms_sku_attr_value` VALUES ('160', '26', '43', '40');
INSERT INTO `pms_sku_attr_value` VALUES ('161', '12', '48', '40');
INSERT INTO `pms_sku_attr_value` VALUES ('162', '13', '51', '40');
INSERT INTO `pms_sku_attr_value` VALUES ('163', '25', '39', '41');
INSERT INTO `pms_sku_attr_value` VALUES ('164', '26', '43', '41');
INSERT INTO `pms_sku_attr_value` VALUES ('165', '12', '48', '41');
INSERT INTO `pms_sku_attr_value` VALUES ('166', '13', '51', '41');
INSERT INTO `pms_sku_attr_value` VALUES ('167', '25', '39', '42');
INSERT INTO `pms_sku_attr_value` VALUES ('168', '26', '43', '42');
INSERT INTO `pms_sku_attr_value` VALUES ('169', '12', '48', '42');
INSERT INTO `pms_sku_attr_value` VALUES ('170', '13', '51', '42');
INSERT INTO `pms_sku_attr_value` VALUES ('171', '25', '39', '43');
INSERT INTO `pms_sku_attr_value` VALUES ('172', '26', '43', '43');
INSERT INTO `pms_sku_attr_value` VALUES ('173', '12', '48', '43');
INSERT INTO `pms_sku_attr_value` VALUES ('174', '13', '51', '43');
INSERT INTO `pms_sku_attr_value` VALUES ('175', '25', '39', '44');
INSERT INTO `pms_sku_attr_value` VALUES ('176', '26', '43', '44');
INSERT INTO `pms_sku_attr_value` VALUES ('177', '12', '48', '44');
INSERT INTO `pms_sku_attr_value` VALUES ('178', '13', '51', '44');
INSERT INTO `pms_sku_attr_value` VALUES ('179', '25', '39', '45');
INSERT INTO `pms_sku_attr_value` VALUES ('180', '26', '43', '45');
INSERT INTO `pms_sku_attr_value` VALUES ('181', '12', '48', '45');
INSERT INTO `pms_sku_attr_value` VALUES ('182', '13', '51', '45');
INSERT INTO `pms_sku_attr_value` VALUES ('183', '25', '39', '46');
INSERT INTO `pms_sku_attr_value` VALUES ('184', '25', '39', '47');
INSERT INTO `pms_sku_attr_value` VALUES ('185', '26', '43', '46');
INSERT INTO `pms_sku_attr_value` VALUES ('186', '25', '39', '48');
INSERT INTO `pms_sku_attr_value` VALUES ('187', '26', '43', '47');
INSERT INTO `pms_sku_attr_value` VALUES ('188', '26', '43', '48');
INSERT INTO `pms_sku_attr_value` VALUES ('189', '12', '48', '46');
INSERT INTO `pms_sku_attr_value` VALUES ('190', '12', '48', '47');
INSERT INTO `pms_sku_attr_value` VALUES ('191', '12', '48', '48');
INSERT INTO `pms_sku_attr_value` VALUES ('192', '13', '51', '46');
INSERT INTO `pms_sku_attr_value` VALUES ('193', '13', '51', '47');
INSERT INTO `pms_sku_attr_value` VALUES ('194', '13', '51', '48');
INSERT INTO `pms_sku_attr_value` VALUES ('195', '25', '39', '49');
INSERT INTO `pms_sku_attr_value` VALUES ('196', '26', '43', '49');
INSERT INTO `pms_sku_attr_value` VALUES ('197', '12', '48', '49');
INSERT INTO `pms_sku_attr_value` VALUES ('198', '13', '51', '49');
INSERT INTO `pms_sku_attr_value` VALUES ('199', '25', '39', '50');
INSERT INTO `pms_sku_attr_value` VALUES ('200', '26', '43', '50');
INSERT INTO `pms_sku_attr_value` VALUES ('201', '12', '48', '50');
INSERT INTO `pms_sku_attr_value` VALUES ('202', '13', '51', '50');
INSERT INTO `pms_sku_attr_value` VALUES ('203', '25', '39', '52');
INSERT INTO `pms_sku_attr_value` VALUES ('204', '26', '43', '52');
INSERT INTO `pms_sku_attr_value` VALUES ('205', '12', '48', '52');
INSERT INTO `pms_sku_attr_value` VALUES ('206', '25', '39', '53');
INSERT INTO `pms_sku_attr_value` VALUES ('207', '13', '51', '52');
INSERT INTO `pms_sku_attr_value` VALUES ('208', '26', '43', '53');
INSERT INTO `pms_sku_attr_value` VALUES ('209', '12', '48', '53');
INSERT INTO `pms_sku_attr_value` VALUES ('210', '13', '51', '53');
INSERT INTO `pms_sku_attr_value` VALUES ('211', '25', '39', '51');
INSERT INTO `pms_sku_attr_value` VALUES ('212', '26', '43', '51');
INSERT INTO `pms_sku_attr_value` VALUES ('213', '12', '48', '51');
INSERT INTO `pms_sku_attr_value` VALUES ('214', '13', '51', '51');
INSERT INTO `pms_sku_attr_value` VALUES ('215', '25', '39', '54');
INSERT INTO `pms_sku_attr_value` VALUES ('216', '26', '43', '54');
INSERT INTO `pms_sku_attr_value` VALUES ('217', '12', '48', '54');
INSERT INTO `pms_sku_attr_value` VALUES ('218', '13', '51', '54');
INSERT INTO `pms_sku_attr_value` VALUES ('219', '25', '39', '55');
INSERT INTO `pms_sku_attr_value` VALUES ('220', '26', '43', '55');
INSERT INTO `pms_sku_attr_value` VALUES ('221', '12', '48', '55');
INSERT INTO `pms_sku_attr_value` VALUES ('222', '13', '51', '55');
INSERT INTO `pms_sku_attr_value` VALUES ('223', '25', '39', '56');
INSERT INTO `pms_sku_attr_value` VALUES ('224', '26', '43', '56');
INSERT INTO `pms_sku_attr_value` VALUES ('225', '12', '48', '56');
INSERT INTO `pms_sku_attr_value` VALUES ('226', '13', '51', '56');
INSERT INTO `pms_sku_attr_value` VALUES ('227', '25', '39', '57');
INSERT INTO `pms_sku_attr_value` VALUES ('228', '26', '43', '57');
INSERT INTO `pms_sku_attr_value` VALUES ('229', '12', '48', '57');
INSERT INTO `pms_sku_attr_value` VALUES ('230', '13', '51', '57');
INSERT INTO `pms_sku_attr_value` VALUES ('231', '25', '39', '58');
INSERT INTO `pms_sku_attr_value` VALUES ('232', '26', '43', '58');
INSERT INTO `pms_sku_attr_value` VALUES ('233', '12', '48', '58');
INSERT INTO `pms_sku_attr_value` VALUES ('234', '13', '51', '58');
INSERT INTO `pms_sku_attr_value` VALUES ('235', '25', '39', '59');
INSERT INTO `pms_sku_attr_value` VALUES ('236', '26', '43', '59');
INSERT INTO `pms_sku_attr_value` VALUES ('237', '12', '48', '59');
INSERT INTO `pms_sku_attr_value` VALUES ('238', '13', '51', '59');
INSERT INTO `pms_sku_attr_value` VALUES ('239', '25', '39', '60');
INSERT INTO `pms_sku_attr_value` VALUES ('240', '26', '43', '60');
INSERT INTO `pms_sku_attr_value` VALUES ('241', '12', '48', '60');
INSERT INTO `pms_sku_attr_value` VALUES ('242', '13', '51', '60');
INSERT INTO `pms_sku_attr_value` VALUES ('243', '25', '39', '61');
INSERT INTO `pms_sku_attr_value` VALUES ('244', '26', '43', '61');
INSERT INTO `pms_sku_attr_value` VALUES ('245', '12', '48', '61');
INSERT INTO `pms_sku_attr_value` VALUES ('246', '13', '51', '61');
INSERT INTO `pms_sku_attr_value` VALUES ('247', '25', '39', '62');
INSERT INTO `pms_sku_attr_value` VALUES ('248', '26', '43', '62');
INSERT INTO `pms_sku_attr_value` VALUES ('249', '12', '48', '62');
INSERT INTO `pms_sku_attr_value` VALUES ('250', '13', '51', '62');
INSERT INTO `pms_sku_attr_value` VALUES ('251', '25', '39', '64');
INSERT INTO `pms_sku_attr_value` VALUES ('252', '26', '43', '64');
INSERT INTO `pms_sku_attr_value` VALUES ('253', '12', '48', '64');
INSERT INTO `pms_sku_attr_value` VALUES ('254', '13', '51', '64');
INSERT INTO `pms_sku_attr_value` VALUES ('255', '25', '39', '65');
INSERT INTO `pms_sku_attr_value` VALUES ('256', '26', '43', '65');
INSERT INTO `pms_sku_attr_value` VALUES ('257', '12', '48', '65');
INSERT INTO `pms_sku_attr_value` VALUES ('258', '13', '51', '65');
INSERT INTO `pms_sku_attr_value` VALUES ('259', '25', '39', '63');
INSERT INTO `pms_sku_attr_value` VALUES ('260', '26', '43', '63');
INSERT INTO `pms_sku_attr_value` VALUES ('261', '12', '48', '63');
INSERT INTO `pms_sku_attr_value` VALUES ('262', '13', '51', '63');
INSERT INTO `pms_sku_attr_value` VALUES ('263', '25', '39', '66');
INSERT INTO `pms_sku_attr_value` VALUES ('264', '26', '43', '66');
INSERT INTO `pms_sku_attr_value` VALUES ('265', '25', '39', '67');
INSERT INTO `pms_sku_attr_value` VALUES ('266', '26', '43', '67');
INSERT INTO `pms_sku_attr_value` VALUES ('267', '12', '48', '67');
INSERT INTO `pms_sku_attr_value` VALUES ('268', '13', '51', '67');
INSERT INTO `pms_sku_attr_value` VALUES ('269', '12', '48', '66');
INSERT INTO `pms_sku_attr_value` VALUES ('270', '13', '51', '66');
INSERT INTO `pms_sku_attr_value` VALUES ('271', '25', '39', '68');
INSERT INTO `pms_sku_attr_value` VALUES ('272', '26', '43', '68');
INSERT INTO `pms_sku_attr_value` VALUES ('273', '12', '48', '68');
INSERT INTO `pms_sku_attr_value` VALUES ('274', '13', '51', '68');
INSERT INTO `pms_sku_attr_value` VALUES ('275', '25', '39', '69');
INSERT INTO `pms_sku_attr_value` VALUES ('276', '26', '43', '69');
INSERT INTO `pms_sku_attr_value` VALUES ('277', '12', '48', '69');
INSERT INTO `pms_sku_attr_value` VALUES ('278', '13', '51', '69');
INSERT INTO `pms_sku_attr_value` VALUES ('279', '25', '39', '70');
INSERT INTO `pms_sku_attr_value` VALUES ('280', '26', '43', '70');
INSERT INTO `pms_sku_attr_value` VALUES ('281', '12', '48', '70');
INSERT INTO `pms_sku_attr_value` VALUES ('282', '13', '51', '70');
INSERT INTO `pms_sku_attr_value` VALUES ('283', '25', '39', '71');
INSERT INTO `pms_sku_attr_value` VALUES ('284', '26', '43', '71');
INSERT INTO `pms_sku_attr_value` VALUES ('285', '12', '48', '71');
INSERT INTO `pms_sku_attr_value` VALUES ('286', '13', '51', '71');
INSERT INTO `pms_sku_attr_value` VALUES ('287', '25', '39', '72');
INSERT INTO `pms_sku_attr_value` VALUES ('288', '26', '43', '72');
INSERT INTO `pms_sku_attr_value` VALUES ('289', '12', '48', '72');
INSERT INTO `pms_sku_attr_value` VALUES ('290', '13', '51', '72');
INSERT INTO `pms_sku_attr_value` VALUES ('291', '25', '42', '73');
INSERT INTO `pms_sku_attr_value` VALUES ('292', '26', '43', '73');
INSERT INTO `pms_sku_attr_value` VALUES ('293', '12', '50', '73');
INSERT INTO `pms_sku_attr_value` VALUES ('294', '13', '51', '73');
INSERT INTO `pms_sku_attr_value` VALUES ('295', '25', '41', '74');
INSERT INTO `pms_sku_attr_value` VALUES ('296', '26', '44', '74');
INSERT INTO `pms_sku_attr_value` VALUES ('297', '12', '48', '74');
INSERT INTO `pms_sku_attr_value` VALUES ('298', '13', '51', '74');
INSERT INTO `pms_sku_attr_value` VALUES ('299', '25', '39', '75');
INSERT INTO `pms_sku_attr_value` VALUES ('300', '26', '43', '75');
INSERT INTO `pms_sku_attr_value` VALUES ('301', '12', '48', '75');
INSERT INTO `pms_sku_attr_value` VALUES ('302', '13', '51', '75');
INSERT INTO `pms_sku_attr_value` VALUES ('303', '25', '39', '76');
INSERT INTO `pms_sku_attr_value` VALUES ('304', '26', '43', '76');
INSERT INTO `pms_sku_attr_value` VALUES ('305', '12', '48', '76');
INSERT INTO `pms_sku_attr_value` VALUES ('306', '13', '51', '76');
INSERT INTO `pms_sku_attr_value` VALUES ('307', '25', '39', '77');
INSERT INTO `pms_sku_attr_value` VALUES ('308', '26', '43', '77');
INSERT INTO `pms_sku_attr_value` VALUES ('309', '12', '48', '77');
INSERT INTO `pms_sku_attr_value` VALUES ('310', '13', '51', '77');
INSERT INTO `pms_sku_attr_value` VALUES ('311', '27', '54', '77');
INSERT INTO `pms_sku_attr_value` VALUES ('312', '25', '39', '78');
INSERT INTO `pms_sku_attr_value` VALUES ('313', '26', '43', '78');
INSERT INTO `pms_sku_attr_value` VALUES ('314', '12', '48', '78');
INSERT INTO `pms_sku_attr_value` VALUES ('315', '13', '51', '78');
INSERT INTO `pms_sku_attr_value` VALUES ('316', '27', '54', '78');
INSERT INTO `pms_sku_attr_value` VALUES ('357', '25', '41', '86');
INSERT INTO `pms_sku_attr_value` VALUES ('358', '26', '44', '86');
INSERT INTO `pms_sku_attr_value` VALUES ('359', '12', '50', '86');
INSERT INTO `pms_sku_attr_value` VALUES ('360', '13', '53', '86');
INSERT INTO `pms_sku_attr_value` VALUES ('361', '27', '56', '86');
INSERT INTO `pms_sku_attr_value` VALUES ('362', '25', '41', '10');
INSERT INTO `pms_sku_attr_value` VALUES ('363', '26', '46', '10');
INSERT INTO `pms_sku_attr_value` VALUES ('364', '12', '48', '10');
INSERT INTO `pms_sku_attr_value` VALUES ('365', '13', '51', '10');
INSERT INTO `pms_sku_attr_value` VALUES ('366', '27', '54', '10');
INSERT INTO `pms_sku_attr_value` VALUES ('379', '25', '39', '22');
INSERT INTO `pms_sku_attr_value` VALUES ('380', '26', '43', '22');
INSERT INTO `pms_sku_attr_value` VALUES ('381', '12', '48', '22');
INSERT INTO `pms_sku_attr_value` VALUES ('382', '13', '51', '22');
INSERT INTO `pms_sku_attr_value` VALUES ('383', '27', '54', '22');
INSERT INTO `pms_sku_attr_value` VALUES ('384', '28', '59', '22');
INSERT INTO `pms_sku_attr_value` VALUES ('385', '25', '42', '25');
INSERT INTO `pms_sku_attr_value` VALUES ('386', '26', '46', '25');
INSERT INTO `pms_sku_attr_value` VALUES ('387', '12', '49', '25');
INSERT INTO `pms_sku_attr_value` VALUES ('388', '13', '51', '25');
INSERT INTO `pms_sku_attr_value` VALUES ('389', '27', '56', '25');
INSERT INTO `pms_sku_attr_value` VALUES ('390', '28', '59', '25');
INSERT INTO `pms_sku_attr_value` VALUES ('403', '25', '39', '17');
INSERT INTO `pms_sku_attr_value` VALUES ('404', '26', '43', '17');
INSERT INTO `pms_sku_attr_value` VALUES ('405', '12', '48', '17');
INSERT INTO `pms_sku_attr_value` VALUES ('406', '13', '51', '17');
INSERT INTO `pms_sku_attr_value` VALUES ('407', '27', '54', '17');
INSERT INTO `pms_sku_attr_value` VALUES ('408', '28', '59', '17');
INSERT INTO `pms_sku_attr_value` VALUES ('409', '25', '41', '24');
INSERT INTO `pms_sku_attr_value` VALUES ('410', '26', '43', '24');
INSERT INTO `pms_sku_attr_value` VALUES ('411', '12', '49', '24');
INSERT INTO `pms_sku_attr_value` VALUES ('412', '13', '52', '24');
INSERT INTO `pms_sku_attr_value` VALUES ('413', '27', '54', '24');
INSERT INTO `pms_sku_attr_value` VALUES ('414', '28', '59', '24');
INSERT INTO `pms_sku_attr_value` VALUES ('439', '25', '41', '19');
INSERT INTO `pms_sku_attr_value` VALUES ('440', '26', '45', '19');
INSERT INTO `pms_sku_attr_value` VALUES ('441', '12', '50', '19');
INSERT INTO `pms_sku_attr_value` VALUES ('442', '13', '51', '19');
INSERT INTO `pms_sku_attr_value` VALUES ('443', '27', '54', '19');
INSERT INTO `pms_sku_attr_value` VALUES ('444', '28', '59', '19');
INSERT INTO `pms_sku_attr_value` VALUES ('469', '25', '39', '83');
INSERT INTO `pms_sku_attr_value` VALUES ('470', '26', '43', '83');
INSERT INTO `pms_sku_attr_value` VALUES ('471', '12', '48', '83');
INSERT INTO `pms_sku_attr_value` VALUES ('472', '13', '51', '83');
INSERT INTO `pms_sku_attr_value` VALUES ('473', '27', '54', '83');
INSERT INTO `pms_sku_attr_value` VALUES ('474', '28', '59', '83');
INSERT INTO `pms_sku_attr_value` VALUES ('481', '25', '39', '18');
INSERT INTO `pms_sku_attr_value` VALUES ('482', '26', '43', '18');
INSERT INTO `pms_sku_attr_value` VALUES ('483', '12', '48', '18');
INSERT INTO `pms_sku_attr_value` VALUES ('484', '13', '51', '18');
INSERT INTO `pms_sku_attr_value` VALUES ('485', '27', '54', '18');
INSERT INTO `pms_sku_attr_value` VALUES ('486', '28', '59', '18');
INSERT INTO `pms_sku_attr_value` VALUES ('505', '25', '39', '81');
INSERT INTO `pms_sku_attr_value` VALUES ('506', '26', '43', '81');
INSERT INTO `pms_sku_attr_value` VALUES ('507', '12', '48', '81');
INSERT INTO `pms_sku_attr_value` VALUES ('508', '13', '51', '81');
INSERT INTO `pms_sku_attr_value` VALUES ('509', '27', '54', '81');
INSERT INTO `pms_sku_attr_value` VALUES ('510', '28', '59', '81');
INSERT INTO `pms_sku_attr_value` VALUES ('541', '25', '41', '79');
INSERT INTO `pms_sku_attr_value` VALUES ('542', '26', '45', '79');
INSERT INTO `pms_sku_attr_value` VALUES ('543', '12', '49', '79');
INSERT INTO `pms_sku_attr_value` VALUES ('544', '13', '52', '79');
INSERT INTO `pms_sku_attr_value` VALUES ('545', '27', '55', '79');
INSERT INTO `pms_sku_attr_value` VALUES ('546', '28', '60', '79');
INSERT INTO `pms_sku_attr_value` VALUES ('573', '25', '42', '85');
INSERT INTO `pms_sku_attr_value` VALUES ('574', '26', '45', '85');
INSERT INTO `pms_sku_attr_value` VALUES ('575', '12', '50', '85');
INSERT INTO `pms_sku_attr_value` VALUES ('576', '13', '53', '85');
INSERT INTO `pms_sku_attr_value` VALUES ('577', '27', '55', '85');
INSERT INTO `pms_sku_attr_value` VALUES ('578', '28', '60', '85');
INSERT INTO `pms_sku_attr_value` VALUES ('579', '29', '64', '85');
INSERT INTO `pms_sku_attr_value` VALUES ('587', '25', '39', '82');
INSERT INTO `pms_sku_attr_value` VALUES ('588', '26', '43', '82');
INSERT INTO `pms_sku_attr_value` VALUES ('589', '12', '48', '82');
INSERT INTO `pms_sku_attr_value` VALUES ('590', '13', '51', '82');
INSERT INTO `pms_sku_attr_value` VALUES ('591', '27', '54', '82');
INSERT INTO `pms_sku_attr_value` VALUES ('592', '28', '59', '82');
INSERT INTO `pms_sku_attr_value` VALUES ('593', '29', '62', '82');
INSERT INTO `pms_sku_attr_value` VALUES ('594', '25', '39', '80');
INSERT INTO `pms_sku_attr_value` VALUES ('595', '26', '43', '80');
INSERT INTO `pms_sku_attr_value` VALUES ('596', '12', '48', '80');
INSERT INTO `pms_sku_attr_value` VALUES ('597', '13', '51', '80');
INSERT INTO `pms_sku_attr_value` VALUES ('598', '27', '54', '80');
INSERT INTO `pms_sku_attr_value` VALUES ('599', '28', '59', '80');
INSERT INTO `pms_sku_attr_value` VALUES ('600', '29', '62', '80');
INSERT INTO `pms_sku_attr_value` VALUES ('601', '25', '41', '84');
INSERT INTO `pms_sku_attr_value` VALUES ('602', '26', '45', '84');
INSERT INTO `pms_sku_attr_value` VALUES ('603', '12', '50', '84');
INSERT INTO `pms_sku_attr_value` VALUES ('604', '13', '52', '84');
INSERT INTO `pms_sku_attr_value` VALUES ('605', '27', '55', '84');
INSERT INTO `pms_sku_attr_value` VALUES ('606', '28', '60', '84');
INSERT INTO `pms_sku_attr_value` VALUES ('607', '29', '62', '84');
INSERT INTO `pms_sku_attr_value` VALUES ('622', '25', '39', '87');
INSERT INTO `pms_sku_attr_value` VALUES ('623', '26', '43', '87');
INSERT INTO `pms_sku_attr_value` VALUES ('624', '12', '48', '87');
INSERT INTO `pms_sku_attr_value` VALUES ('625', '13', '51', '87');
INSERT INTO `pms_sku_attr_value` VALUES ('626', '27', '54', '87');
INSERT INTO `pms_sku_attr_value` VALUES ('627', '28', '59', '87');
INSERT INTO `pms_sku_attr_value` VALUES ('628', '29', '62', '87');
INSERT INTO `pms_sku_attr_value` VALUES ('636', '25', '39', '88');
INSERT INTO `pms_sku_attr_value` VALUES ('637', '26', '43', '88');
INSERT INTO `pms_sku_attr_value` VALUES ('638', '12', '48', '88');
INSERT INTO `pms_sku_attr_value` VALUES ('639', '13', '51', '88');
INSERT INTO `pms_sku_attr_value` VALUES ('640', '27', '54', '88');
INSERT INTO `pms_sku_attr_value` VALUES ('641', '28', '59', '88');
INSERT INTO `pms_sku_attr_value` VALUES ('642', '29', '62', '88');
INSERT INTO `pms_sku_attr_value` VALUES ('643', '25', '39', '89');
INSERT INTO `pms_sku_attr_value` VALUES ('644', '26', '43', '89');
INSERT INTO `pms_sku_attr_value` VALUES ('645', '12', '48', '89');
INSERT INTO `pms_sku_attr_value` VALUES ('646', '13', '51', '89');
INSERT INTO `pms_sku_attr_value` VALUES ('647', '27', '54', '89');
INSERT INTO `pms_sku_attr_value` VALUES ('648', '28', '59', '89');
INSERT INTO `pms_sku_attr_value` VALUES ('649', '29', '62', '89');
INSERT INTO `pms_sku_attr_value` VALUES ('650', '12', '49', '92');
INSERT INTO `pms_sku_attr_value` VALUES ('651', '13', '52', '92');
INSERT INTO `pms_sku_attr_value` VALUES ('652', '25', '39', '92');
INSERT INTO `pms_sku_attr_value` VALUES ('653', '26', '43', '92');
INSERT INTO `pms_sku_attr_value` VALUES ('654', '27', '54', '92');
INSERT INTO `pms_sku_attr_value` VALUES ('655', '28', '59', '92');
INSERT INTO `pms_sku_attr_value` VALUES ('656', '29', '62', '92');
INSERT INTO `pms_sku_attr_value` VALUES ('657', '31', '68', '92');
INSERT INTO `pms_sku_attr_value` VALUES ('658', '12', '48', '93');
INSERT INTO `pms_sku_attr_value` VALUES ('659', '13', '51', '93');
INSERT INTO `pms_sku_attr_value` VALUES ('660', '25', '39', '93');
INSERT INTO `pms_sku_attr_value` VALUES ('661', '26', '43', '93');
INSERT INTO `pms_sku_attr_value` VALUES ('662', '27', '54', '93');
INSERT INTO `pms_sku_attr_value` VALUES ('663', '28', '59', '93');
INSERT INTO `pms_sku_attr_value` VALUES ('664', '29', '62', '93');
INSERT INTO `pms_sku_attr_value` VALUES ('665', '31', '68', '93');
INSERT INTO `pms_sku_attr_value` VALUES ('666', '32', '66', '93');
INSERT INTO `pms_sku_attr_value` VALUES ('667', '12', '48', '94');
INSERT INTO `pms_sku_attr_value` VALUES ('668', '13', '51', '94');
INSERT INTO `pms_sku_attr_value` VALUES ('669', '25', '39', '94');
INSERT INTO `pms_sku_attr_value` VALUES ('670', '26', '43', '94');
INSERT INTO `pms_sku_attr_value` VALUES ('671', '27', '54', '94');
INSERT INTO `pms_sku_attr_value` VALUES ('672', '28', '59', '94');
INSERT INTO `pms_sku_attr_value` VALUES ('673', '29', '62', '94');
INSERT INTO `pms_sku_attr_value` VALUES ('674', '31', '67', '94');
INSERT INTO `pms_sku_attr_value` VALUES ('675', '32', '65', '94');
INSERT INTO `pms_sku_attr_value` VALUES ('676', '33', '72', '94');
INSERT INTO `pms_sku_attr_value` VALUES ('677', '12', '48', '95');
INSERT INTO `pms_sku_attr_value` VALUES ('678', '13', '51', '95');
INSERT INTO `pms_sku_attr_value` VALUES ('679', '25', '40', '95');
INSERT INTO `pms_sku_attr_value` VALUES ('680', '26', '44', '95');
INSERT INTO `pms_sku_attr_value` VALUES ('681', '27', '54', '95');
INSERT INTO `pms_sku_attr_value` VALUES ('682', '28', '59', '95');
INSERT INTO `pms_sku_attr_value` VALUES ('683', '29', '62', '95');
INSERT INTO `pms_sku_attr_value` VALUES ('684', '31', '67', '95');
INSERT INTO `pms_sku_attr_value` VALUES ('685', '32', '65', '95');
INSERT INTO `pms_sku_attr_value` VALUES ('686', '33', '72', '95');
INSERT INTO `pms_sku_attr_value` VALUES ('687', '12', '48', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('688', '13', '51', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('689', '25', '42', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('690', '26', '46', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('691', '27', '54', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('692', '28', '59', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('693', '29', '63', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('694', '31', '68', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('695', '32', '66', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('696', '33', '72', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('697', '34', '77', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('698', '35', '80', '96');
INSERT INTO `pms_sku_attr_value` VALUES ('699', '12', '48', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('700', '13', '51', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('701', '25', '42', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('702', '26', '46', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('703', '27', '54', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('704', '28', '59', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('705', '29', '63', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('706', '31', '68', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('707', '32', '66', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('708', '33', '72', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('709', '34', '77', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('710', '35', '80', '97');
INSERT INTO `pms_sku_attr_value` VALUES ('711', '12', '48', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('712', '13', '51', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('713', '25', '39', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('714', '26', '43', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('715', '27', '54', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('716', '28', '59', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('717', '29', '62', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('718', '31', '67', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('719', '32', '71', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('720', '33', '73', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('721', '34', '76', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('722', '35', '80', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('723', '36', '81', '98');
INSERT INTO `pms_sku_attr_value` VALUES ('724', '12', '48', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('725', '13', '51', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('726', '25', '39', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('727', '26', '43', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('728', '27', '54', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('729', '28', '59', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('730', '29', '62', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('731', '31', '67', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('732', '32', '65', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('733', '33', '72', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('734', '34', '75', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('735', '35', '78', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('736', '36', '81', '99');
INSERT INTO `pms_sku_attr_value` VALUES ('737', '12', '49', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('738', '13', '52', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('739', '25', '39', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('740', '26', '43', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('741', '27', '55', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('742', '28', '59', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('743', '29', '62', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('744', '31', '67', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('745', '32', '69', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('746', '33', '73', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('747', '34', '76', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('748', '35', '80', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('749', '36', '82', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('750', '37', '86', '100');
INSERT INTO `pms_sku_attr_value` VALUES ('751', '12', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('752', '13', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('753', '25', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('754', '26', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('755', '27', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('756', '28', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('757', '29', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('758', '31', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('759', '32', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('760', '33', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('761', '34', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('762', '35', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('763', '36', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('764', '37', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('765', '38', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('766', '40', '48', '101');
INSERT INTO `pms_sku_attr_value` VALUES ('767', '12', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('768', '13', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('769', '25', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('770', '26', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('771', '27', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('772', '28', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('773', '29', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('774', '31', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('775', '32', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('776', '33', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('777', '34', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('778', '35', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('779', '36', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('780', '37', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('781', '38', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('782', '40', '48', '102');
INSERT INTO `pms_sku_attr_value` VALUES ('783', '12', '48', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('784', '13', '51', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('785', '25', '39', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('786', '26', '43', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('787', '27', '54', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('788', '28', '59', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('789', '29', '62', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('790', '31', '67', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('791', '32', '65', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('792', '33', '72', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('793', '34', '75', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('794', '35', '78', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('795', '36', '81', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('796', '37', '84', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('797', '38', '87', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('798', '40', '92', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('799', '41', '94', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('800', '42', '97', '103');
INSERT INTO `pms_sku_attr_value` VALUES ('801', '12', '48', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('802', '13', '51', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('803', '25', '39', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('804', '26', '43', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('805', '27', '54', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('806', '28', '59', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('807', '29', '62', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('808', '31', '67', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('809', '32', '65', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('810', '33', '72', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('811', '34', '75', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('812', '35', '78', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('813', '36', '81', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('814', '37', '84', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('815', '38', '87', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('816', '40', '92', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('817', '41', '94', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('818', '42', '97', '104');
INSERT INTO `pms_sku_attr_value` VALUES ('819', '12', '48', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('820', '13', '51', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('821', '25', '39', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('822', '26', '43', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('823', '27', '54', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('824', '28', '59', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('825', '29', '62', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('826', '31', '67', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('827', '32', '65', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('828', '33', '72', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('829', '34', '75', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('830', '35', '78', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('831', '36', '81', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('832', '37', '84', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('833', '38', '87', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('834', '40', '92', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('835', '41', '94', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('836', '42', '97', '105');
INSERT INTO `pms_sku_attr_value` VALUES ('837', '12', '48', '107');
INSERT INTO `pms_sku_attr_value` VALUES ('838', '25', '42', '107');
INSERT INTO `pms_sku_attr_value` VALUES ('839', '26', '43', '107');
INSERT INTO `pms_sku_attr_value` VALUES ('840', '27', '55', '107');
INSERT INTO `pms_sku_attr_value` VALUES ('841', '36', '81', '107');
INSERT INTO `pms_sku_attr_value` VALUES ('842', '40', '93', '107');
INSERT INTO `pms_sku_attr_value` VALUES ('843', '25', '42', '108');
INSERT INTO `pms_sku_attr_value` VALUES ('844', '26', '45', '108');
INSERT INTO `pms_sku_attr_value` VALUES ('845', '36', '83', '108');
INSERT INTO `pms_sku_attr_value` VALUES ('846', '40', '93', '108');
INSERT INTO `pms_sku_attr_value` VALUES ('847', '44', '104', '108');
INSERT INTO `pms_sku_attr_value` VALUES ('848', '25', '42', '109');
INSERT INTO `pms_sku_attr_value` VALUES ('849', '26', '45', '109');
INSERT INTO `pms_sku_attr_value` VALUES ('850', '36', '83', '109');
INSERT INTO `pms_sku_attr_value` VALUES ('851', '40', '93', '109');
INSERT INTO `pms_sku_attr_value` VALUES ('852', '44', '104', '109');
INSERT INTO `pms_sku_attr_value` VALUES ('853', '12', '48', '110');
INSERT INTO `pms_sku_attr_value` VALUES ('854', '13', '51', '110');
INSERT INTO `pms_sku_attr_value` VALUES ('855', '26', '46', '110');
INSERT INTO `pms_sku_attr_value` VALUES ('856', '29', '62', '110');
INSERT INTO `pms_sku_attr_value` VALUES ('857', '38', '89', '110');
INSERT INTO `pms_sku_attr_value` VALUES ('858', '40', '93', '110');
INSERT INTO `pms_sku_attr_value` VALUES ('859', '44', '105', '110');
INSERT INTO `pms_sku_attr_value` VALUES ('860', '12', '48', '111');
INSERT INTO `pms_sku_attr_value` VALUES ('861', '13', '51', '111');
INSERT INTO `pms_sku_attr_value` VALUES ('862', '26', '47', '111');
INSERT INTO `pms_sku_attr_value` VALUES ('863', '29', '62', '111');
INSERT INTO `pms_sku_attr_value` VALUES ('864', '38', '89', '111');
INSERT INTO `pms_sku_attr_value` VALUES ('865', '40', '93', '111');
INSERT INTO `pms_sku_attr_value` VALUES ('866', '44', '106', '111');
INSERT INTO `pms_sku_attr_value` VALUES ('867', '12', '48', '112');
INSERT INTO `pms_sku_attr_value` VALUES ('868', '13', '51', '112');
INSERT INTO `pms_sku_attr_value` VALUES ('869', '26', '46', '112');
INSERT INTO `pms_sku_attr_value` VALUES ('870', '29', '62', '112');
INSERT INTO `pms_sku_attr_value` VALUES ('871', '38', '89', '112');
INSERT INTO `pms_sku_attr_value` VALUES ('872', '40', '93', '112');
INSERT INTO `pms_sku_attr_value` VALUES ('873', '44', '105', '112');
INSERT INTO `pms_sku_attr_value` VALUES ('874', '12', '48', '113');
INSERT INTO `pms_sku_attr_value` VALUES ('875', '13', '51', '113');
INSERT INTO `pms_sku_attr_value` VALUES ('876', '26', '47', '113');
INSERT INTO `pms_sku_attr_value` VALUES ('877', '29', '62', '113');
INSERT INTO `pms_sku_attr_value` VALUES ('878', '38', '89', '113');
INSERT INTO `pms_sku_attr_value` VALUES ('879', '40', '93', '113');
INSERT INTO `pms_sku_attr_value` VALUES ('880', '44', '106', '113');
INSERT INTO `pms_sku_attr_value` VALUES ('881', '12', '48', '114');
INSERT INTO `pms_sku_attr_value` VALUES ('882', '13', '51', '114');
INSERT INTO `pms_sku_attr_value` VALUES ('883', '26', '45', '114');
INSERT INTO `pms_sku_attr_value` VALUES ('884', '29', '62', '114');
INSERT INTO `pms_sku_attr_value` VALUES ('885', '38', '89', '114');
INSERT INTO `pms_sku_attr_value` VALUES ('886', '40', '93', '114');
INSERT INTO `pms_sku_attr_value` VALUES ('887', '44', '104', '114');
INSERT INTO `pms_sku_attr_value` VALUES ('888', '12', '48', '115');
INSERT INTO `pms_sku_attr_value` VALUES ('889', '13', '51', '115');
INSERT INTO `pms_sku_attr_value` VALUES ('890', '26', '46', '115');
INSERT INTO `pms_sku_attr_value` VALUES ('891', '29', '62', '115');
INSERT INTO `pms_sku_attr_value` VALUES ('892', '38', '89', '115');
INSERT INTO `pms_sku_attr_value` VALUES ('893', '40', '93', '115');
INSERT INTO `pms_sku_attr_value` VALUES ('894', '44', '105', '115');
INSERT INTO `pms_sku_attr_value` VALUES ('895', '12', '48', '116');
INSERT INTO `pms_sku_attr_value` VALUES ('896', '13', '51', '116');
INSERT INTO `pms_sku_attr_value` VALUES ('897', '26', '47', '116');
INSERT INTO `pms_sku_attr_value` VALUES ('898', '29', '62', '116');
INSERT INTO `pms_sku_attr_value` VALUES ('899', '38', '89', '116');
INSERT INTO `pms_sku_attr_value` VALUES ('900', '40', '93', '116');
INSERT INTO `pms_sku_attr_value` VALUES ('901', '44', '106', '116');

-- ----------------------------
-- Table structure for `pms_sku_image`
-- ----------------------------
DROP TABLE IF EXISTS `pms_sku_image`;
CREATE TABLE `pms_sku_image` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `img_name` varchar(200) DEFAULT NULL COMMENT '图片名称（冗余）',
  `img_url` varchar(200) DEFAULT NULL COMMENT '图片路径(冗余)',
  `spu_img_id` bigint(20) DEFAULT NULL COMMENT '商品图片id',
  `is_default` varchar(4000) DEFAULT '0' COMMENT '是否默认',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1073 DEFAULT CHARSET=utf8 COMMENT='库存单元图片表';

-- ----------------------------
-- Records of pms_sku_image
-- ----------------------------
INSERT INTO `pms_sku_image` VALUES ('144', '13', '黑正面.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAZUeyAABl-Gcmj6Q266.jpg', '40', '1');
INSERT INTO `pms_sku_image` VALUES ('145', '13', '黑正2.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAEi7GAAAoCdAcm0Q483.jpg', '41', '0');
INSERT INTO `pms_sku_image` VALUES ('146', '13', '黑侧.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAaNHoAAASDgWlJKA341.jpg', '42', '0');
INSERT INTO `pms_sku_image` VALUES ('147', '13', '黑角.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJNobAABchtkLSZ4079.jpg', '43', '0');
INSERT INTO `pms_sku_image` VALUES ('148', '13', '充电器', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAahD_AAAoTYXCz4M337.jpg', '44', '0');
INSERT INTO `pms_sku_image` VALUES ('155', '11', '黑正面.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAZUeyAABl-Gcmj6Q266.jpg', '40', '1');
INSERT INTO `pms_sku_image` VALUES ('156', '11', '黑正2.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAEi7GAAAoCdAcm0Q483.jpg', '41', '0');
INSERT INTO `pms_sku_image` VALUES ('157', '11', '黑侧.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAaNHoAAASDgWlJKA341.jpg', '42', '0');
INSERT INTO `pms_sku_image` VALUES ('158', '11', '黑角.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJNobAABchtkLSZ4079.jpg', '43', '0');
INSERT INTO `pms_sku_image` VALUES ('159', '11', '充电器', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAahD_AAAoTYXCz4M337.jpg', '44', '0');
INSERT INTO `pms_sku_image` VALUES ('160', '14', '全家福', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAYBe7AACAQkIGrK0125.jpg', '45', '0');
INSERT INTO `pms_sku_image` VALUES ('161', '14', '蓝正', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAPBi4AABzDHfHIis984.jpg', '46', '1');
INSERT INTO `pms_sku_image` VALUES ('162', '14', '蓝全', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaATE04AABTFiuk_fQ924.jpg', '47', '0');
INSERT INTO `pms_sku_image` VALUES ('163', '14', '蓝背', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaABfJ3AAAxq41Xmt8702.jpg', '48', '0');
INSERT INTO `pms_sku_image` VALUES ('164', '14', '蓝底', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJ6nTAAA6Ol3Q8DA559.jpg', '49', '0');
INSERT INTO `pms_sku_image` VALUES ('165', '12', '充电器', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAahD_AAAoTYXCz4M337.jpg', '44', '0');
INSERT INTO `pms_sku_image` VALUES ('166', '12', '全家福', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAYBe7AACAQkIGrK0125.jpg', '45', '0');
INSERT INTO `pms_sku_image` VALUES ('167', '12', '蓝正', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAPBi4AABzDHfHIis984.jpg', '46', '1');
INSERT INTO `pms_sku_image` VALUES ('168', '12', '蓝全', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaATE04AABTFiuk_fQ924.jpg', '47', '0');
INSERT INTO `pms_sku_image` VALUES ('169', '12', '蓝背', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaABfJ3AAAxq41Xmt8702.jpg', '48', '0');
INSERT INTO `pms_sku_image` VALUES ('170', '12', '蓝底', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJ6nTAAA6Ol3Q8DA559.jpg', '49', '0');
INSERT INTO `pms_sku_image` VALUES ('171', '15', '黑正面.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAZUeyAABl-Gcmj6Q266.jpg', '40', '1');
INSERT INTO `pms_sku_image` VALUES ('172', '15', '黑正2.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAEi7GAAAoCdAcm0Q483.jpg', '41', '0');
INSERT INTO `pms_sku_image` VALUES ('173', '15', '黑侧.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAaNHoAAASDgWlJKA341.jpg', '42', '0');
INSERT INTO `pms_sku_image` VALUES ('174', '15', '黑角.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJNobAABchtkLSZ4079.jpg', '43', '0');
INSERT INTO `pms_sku_image` VALUES ('175', '15', '充电器', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAahD_AAAoTYXCz4M337.jpg', '44', '0');
INSERT INTO `pms_sku_image` VALUES ('176', '15', '全家福', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAYBe7AACAQkIGrK0125.jpg', '45', '0');
INSERT INTO `pms_sku_image` VALUES ('177', '15', '蓝正', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAPBi4AABzDHfHIis984.jpg', '46', '0');
INSERT INTO `pms_sku_image` VALUES ('178', '15', '蓝全', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaATE04AABTFiuk_fQ924.jpg', '47', '0');
INSERT INTO `pms_sku_image` VALUES ('179', '15', '蓝背', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaABfJ3AAAxq41Xmt8702.jpg', '48', '0');
INSERT INTO `pms_sku_image` VALUES ('180', '15', '蓝底', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJ6nTAAA6Ol3Q8DA559.jpg', '49', '0');
INSERT INTO `pms_sku_image` VALUES ('195', '20', '黑正面.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAZUeyAABl-Gcmj6Q266.jpg', '40', '1');
INSERT INTO `pms_sku_image` VALUES ('196', '20', '黑正2.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAEi7GAAAoCdAcm0Q483.jpg', '41', '0');
INSERT INTO `pms_sku_image` VALUES ('197', '20', '黑侧.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAaNHoAAASDgWlJKA341.jpg', '42', '0');
INSERT INTO `pms_sku_image` VALUES ('198', '20', '黑角.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJNobAABchtkLSZ4079.jpg', '43', '0');
INSERT INTO `pms_sku_image` VALUES ('199', '20', '充电器', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAahD_AAAoTYXCz4M337.jpg', '44', '0');
INSERT INTO `pms_sku_image` VALUES ('200', '20', '全家福', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAYBe7AACAQkIGrK0125.jpg', '45', '0');
INSERT INTO `pms_sku_image` VALUES ('201', '20', '蓝正', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAPBi4AABzDHfHIis984.jpg', '46', '0');
INSERT INTO `pms_sku_image` VALUES ('202', '20', '蓝全', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaATE04AABTFiuk_fQ924.jpg', '47', '0');
INSERT INTO `pms_sku_image` VALUES ('203', '20', '蓝背', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaABfJ3AAAxq41Xmt8702.jpg', '48', '0');
INSERT INTO `pms_sku_image` VALUES ('204', '20', '蓝底', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJ6nTAAA6Ol3Q8DA559.jpg', '49', '0');
INSERT INTO `pms_sku_image` VALUES ('205', '21', '黑正面.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAZUeyAABl-Gcmj6Q266.jpg', '40', '1');
INSERT INTO `pms_sku_image` VALUES ('206', '21', '黑正2.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAEi7GAAAoCdAcm0Q483.jpg', '41', '0');
INSERT INTO `pms_sku_image` VALUES ('207', '21', '黑侧.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAaNHoAAASDgWlJKA341.jpg', '42', '0');
INSERT INTO `pms_sku_image` VALUES ('208', '21', '黑角.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJNobAABchtkLSZ4079.jpg', '43', '0');
INSERT INTO `pms_sku_image` VALUES ('209', '21', '充电器', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAahD_AAAoTYXCz4M337.jpg', '44', '0');
INSERT INTO `pms_sku_image` VALUES ('210', '21', '全家福', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAYBe7AACAQkIGrK0125.jpg', '45', '0');
INSERT INTO `pms_sku_image` VALUES ('211', '21', '蓝正', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAPBi4AABzDHfHIis984.jpg', '46', '0');
INSERT INTO `pms_sku_image` VALUES ('219', '23', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('220', '23', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('221', '23', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('222', '23', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('223', '23', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('224', '23', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('225', '23', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('240', '26', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('241', '26', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('242', '26', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('243', '26', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '1');
INSERT INTO `pms_sku_image` VALUES ('244', '26', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('245', '26', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('246', '26', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('247', '27', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('248', '27', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('249', '27', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('250', '27', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('251', '27', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('252', '27', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '1');
INSERT INTO `pms_sku_image` VALUES ('253', '27', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('254', '28', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('255', '28', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('256', '28', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '1');
INSERT INTO `pms_sku_image` VALUES ('257', '28', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('258', '28', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('259', '28', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('260', '28', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('261', '29', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('262', '29', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('263', '29', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('264', '29', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('265', '29', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('266', '29', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('267', '29', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('268', '30', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('269', '30', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('270', '30', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('271', '30', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('272', '30', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('273', '30', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('274', '30', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('275', '31', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('276', '31', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('277', '31', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('278', '31', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('279', '31', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('280', '31', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('281', '31', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('282', '32', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('283', '32', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('284', '32', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('285', '32', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('286', '32', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('287', '32', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('288', '32', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('289', '33', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('290', '33', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('291', '33', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('292', '33', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('293', '33', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('294', '33', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('295', '33', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('296', '34', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('297', '34', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('298', '34', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('299', '34', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('300', '34', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('301', '34', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('302', '34', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('303', '35', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('304', '35', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('305', '35', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('306', '35', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('307', '35', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('308', '35', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('309', '35', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('310', '36', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('311', '36', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('312', '36', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('313', '36', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('314', '36', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('315', '36', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('316', '36', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('317', '37', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('318', '37', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('319', '37', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('320', '37', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('321', '37', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('322', '37', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('323', '37', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('324', '38', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('325', '38', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('326', '38', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('327', '38', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('328', '38', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('329', '38', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('330', '38', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('331', '39', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('332', '39', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('333', '39', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('334', '39', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('335', '39', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('336', '39', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('337', '39', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('338', '40', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('339', '40', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('340', '40', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('341', '40', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('342', '40', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('343', '40', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('344', '40', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('345', '41', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('346', '41', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('347', '41', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('348', '41', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('349', '41', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('350', '41', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('351', '41', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('352', '42', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('353', '42', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('354', '42', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('355', '42', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('356', '42', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('357', '42', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('358', '42', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('359', '43', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('360', '43', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('361', '43', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('362', '43', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('363', '43', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('364', '43', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('365', '43', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('366', '44', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('367', '44', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('368', '44', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('369', '44', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('370', '44', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('371', '44', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('372', '44', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('373', '45', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('374', '45', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('375', '45', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('376', '45', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('377', '45', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('378', '45', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('379', '45', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('380', '46', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('381', '47', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('382', '46', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('383', '48', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('384', '47', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('385', '46', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('386', '48', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('387', '47', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('388', '46', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('389', '48', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('390', '47', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('391', '48', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('392', '46', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('393', '47', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('394', '46', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('395', '48', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('396', '47', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('397', '48', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('398', '46', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('399', '47', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('400', '48', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('401', '49', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('402', '49', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('403', '49', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('404', '49', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('405', '49', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('406', '49', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('407', '49', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('408', '50', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('409', '50', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('410', '50', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('411', '50', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('412', '50', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('413', '50', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('414', '50', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('415', '52', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('416', '53', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('417', '52', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('418', '52', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('419', '53', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('420', '52', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('421', '53', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('422', '53', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('423', '52', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('424', '52', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('425', '53', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('426', '52', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('427', '53', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('428', '51', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('429', '53', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('430', '51', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('431', '51', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('432', '51', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('433', '51', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('434', '51', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('435', '51', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('436', '54', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('437', '54', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('438', '54', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('439', '54', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('440', '54', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('441', '54', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('442', '54', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('443', '55', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('444', '55', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('445', '55', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('446', '55', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('447', '55', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('448', '55', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('449', '55', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('450', '56', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('451', '56', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('452', '56', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('453', '56', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('454', '56', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('455', '56', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('456', '56', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('457', '57', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('458', '57', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('459', '57', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('460', '57', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('461', '57', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('462', '57', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('463', '57', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('464', '58', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('465', '58', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('466', '58', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('467', '58', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('468', '58', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('469', '58', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('470', '58', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('471', '59', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('472', '59', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('473', '59', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('474', '59', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('475', '59', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('476', '59', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('477', '59', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('478', '60', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('479', '60', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('480', '60', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('481', '60', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('482', '60', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('483', '60', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('484', '60', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('485', '61', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('486', '61', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('487', '61', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('488', '61', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('489', '61', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('490', '61', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('491', '61', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('492', '62', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('493', '62', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('494', '62', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('495', '62', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('496', '62', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('497', '62', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('498', '62', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('499', '64', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('500', '64', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('501', '64', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('502', '64', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('503', '64', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('504', '64', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('505', '63', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('506', '64', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('507', '65', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('508', '63', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('509', '65', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('510', '65', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('511', '65', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('512', '65', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('513', '65', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('514', '65', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('515', '63', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('516', '63', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('517', '63', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('518', '63', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('519', '63', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('520', '66', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('521', '66', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('522', '66', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('523', '66', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('524', '66', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('525', '66', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('526', '66', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('527', '67', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('528', '67', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('529', '67', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('530', '67', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('531', '67', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('532', '67', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('533', '67', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('534', '68', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('535', '68', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('536', '68', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('537', '68', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('538', '68', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('539', '68', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('540', '68', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('541', '69', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('542', '69', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('543', '69', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('544', '69', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('545', '69', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('546', '69', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('547', '69', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('548', '70', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('549', '70', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('550', '70', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('551', '70', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('552', '70', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('553', '70', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('554', '70', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('555', '71', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('556', '71', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('557', '71', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('558', '71', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('559', '71', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('560', '71', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('561', '71', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('562', '72', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('563', '72', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('564', '72', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('565', '72', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('566', '72', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('567', '72', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('568', '72', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('569', '73', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('570', '73', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('571', '73', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '1');
INSERT INTO `pms_sku_image` VALUES ('572', '73', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('573', '73', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('574', '73', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('575', '73', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('576', '74', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('577', '74', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('578', '74', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('579', '74', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('580', '74', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('581', '74', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '1');
INSERT INTO `pms_sku_image` VALUES ('582', '74', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('583', '75', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('584', '75', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('585', '75', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('586', '75', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('587', '75', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('588', '75', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('589', '75', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '1');
INSERT INTO `pms_sku_image` VALUES ('590', '76', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('591', '76', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('592', '76', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('593', '76', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '1');
INSERT INTO `pms_sku_image` VALUES ('594', '76', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('595', '76', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('596', '76', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('597', '77', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('598', '77', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('599', '77', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('600', '77', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('601', '77', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('602', '77', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('603', '77', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('604', '78', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('605', '78', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('606', '78', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('607', '78', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('608', '78', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('609', '78', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('610', '78', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('656', '86', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdHWAUgY1AABGlNSsc8k337.jpg', '64', '0');
INSERT INTO `pms_sku_image` VALUES ('657', '86', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AdVB5AACQ33CNBgI849.jpg', '65', '0');
INSERT INTO `pms_sku_image` VALUES ('658', '86', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-Af4jjAACnL2DEmZI759.jpg', '66', '1');
INSERT INTO `pms_sku_image` VALUES ('659', '86', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-ASvcIAABLvWYyykI760.jpg', '67', '0');
INSERT INTO `pms_sku_image` VALUES ('660', '86', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AF-iIAAAzpeBWucQ529.jpg', '68', '0');
INSERT INTO `pms_sku_image` VALUES ('661', '10', '黑正面.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAZUeyAABl-Gcmj6Q266.jpg', '40', '1');
INSERT INTO `pms_sku_image` VALUES ('662', '10', '黑正2.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAEi7GAAAoCdAcm0Q483.jpg', '41', '0');
INSERT INTO `pms_sku_image` VALUES ('663', '10', '黑侧.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAaNHoAAASDgWlJKA341.jpg', '42', '0');
INSERT INTO `pms_sku_image` VALUES ('664', '10', '黑角.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJNobAABchtkLSZ4079.jpg', '43', '0');
INSERT INTO `pms_sku_image` VALUES ('665', '10', '充电器', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAahD_AAAoTYXCz4M337.jpg', '44', '0');
INSERT INTO `pms_sku_image` VALUES ('666', '10', '蓝全', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaATE04AABTFiuk_fQ924.jpg', '47', '0');
INSERT INTO `pms_sku_image` VALUES ('681', '22', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('682', '22', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('683', '22', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('684', '22', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('685', '22', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('686', '22', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('687', '22', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('688', '25', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('689', '25', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '1');
INSERT INTO `pms_sku_image` VALUES ('690', '25', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('691', '25', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('692', '25', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('693', '25', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('694', '25', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('709', '17', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('710', '17', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('711', '17', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '0');
INSERT INTO `pms_sku_image` VALUES ('712', '17', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('713', '17', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('714', '17', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('715', '17', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('716', '24', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '0');
INSERT INTO `pms_sku_image` VALUES ('717', '24', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', '0');
INSERT INTO `pms_sku_image` VALUES ('718', '24', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', '1');
INSERT INTO `pms_sku_image` VALUES ('719', '24', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', '0');
INSERT INTO `pms_sku_image` VALUES ('720', '24', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', '0');
INSERT INTO `pms_sku_image` VALUES ('721', '24', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', '0');
INSERT INTO `pms_sku_image` VALUES ('722', '24', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', '0');
INSERT INTO `pms_sku_image` VALUES ('747', '19', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', null);
INSERT INTO `pms_sku_image` VALUES ('748', '19', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', null);
INSERT INTO `pms_sku_image` VALUES ('749', '19', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', null);
INSERT INTO `pms_sku_image` VALUES ('750', '19', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', null);
INSERT INTO `pms_sku_image` VALUES ('751', '19', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', null);
INSERT INTO `pms_sku_image` VALUES ('752', '19', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', null);
INSERT INTO `pms_sku_image` VALUES ('753', '19', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', null);
INSERT INTO `pms_sku_image` VALUES ('775', '83', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdHWAUgY1AABGlNSsc8k337.jpg', '64', null);
INSERT INTO `pms_sku_image` VALUES ('776', '83', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AdVB5AACQ33CNBgI849.jpg', '65', null);
INSERT INTO `pms_sku_image` VALUES ('777', '83', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-Af4jjAACnL2DEmZI759.jpg', '66', null);
INSERT INTO `pms_sku_image` VALUES ('778', '83', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-ASvcIAABLvWYyykI760.jpg', '67', null);
INSERT INTO `pms_sku_image` VALUES ('779', '83', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AF-iIAAAzpeBWucQ529.jpg', '68', null);
INSERT INTO `pms_sku_image` VALUES ('786', '18', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', null);
INSERT INTO `pms_sku_image` VALUES ('787', '18', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', null);
INSERT INTO `pms_sku_image` VALUES ('788', '18', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', null);
INSERT INTO `pms_sku_image` VALUES ('789', '18', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', null);
INSERT INTO `pms_sku_image` VALUES ('790', '18', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', null);
INSERT INTO `pms_sku_image` VALUES ('791', '18', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', null);
INSERT INTO `pms_sku_image` VALUES ('792', '18', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', null);
INSERT INTO `pms_sku_image` VALUES ('810', '81', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuANqf7AAAzpeBWucQ738.jpg', '69', null);
INSERT INTO `pms_sku_image` VALUES ('811', '81', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAKGYbAACQ33CNBgI202.jpg', '70', null);
INSERT INTO `pms_sku_image` VALUES ('812', '81', 'u=1780590834,74343091&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAJZLuAAAbekxUTwU917.jpg', '71', null);
INSERT INTO `pms_sku_image` VALUES ('813', '81', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAbM11AABUx6Stpu8094.jpg', '72', null);
INSERT INTO `pms_sku_image` VALUES ('814', '81', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuABXVvAAA2oBvXGRY799.jpg', '73', null);
INSERT INTO `pms_sku_image` VALUES ('815', '81', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAOy_6AAAqaC4JyRU137.jpg', '74', null);
INSERT INTO `pms_sku_image` VALUES ('845', '79', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdHWAUgY1AABGlNSsc8k337.jpg', '64', null);
INSERT INTO `pms_sku_image` VALUES ('846', '79', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AdVB5AACQ33CNBgI849.jpg', '65', null);
INSERT INTO `pms_sku_image` VALUES ('847', '79', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-Af4jjAACnL2DEmZI759.jpg', '66', null);
INSERT INTO `pms_sku_image` VALUES ('848', '79', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-ASvcIAABLvWYyykI760.jpg', '67', null);
INSERT INTO `pms_sku_image` VALUES ('849', '79', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AF-iIAAAzpeBWucQ529.jpg', '68', null);
INSERT INTO `pms_sku_image` VALUES ('874', '85', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOAanCWAABKCGOfKjM751.jpg', '75', null);
INSERT INTO `pms_sku_image` VALUES ('875', '85', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOAFlzvAAB9_p5yd_4645.jpg', '76', null);
INSERT INTO `pms_sku_image` VALUES ('876', '85', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOAHCncAABQITqS23s031.jpg', '77', null);
INSERT INTO `pms_sku_image` VALUES ('877', '85', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOAU2uAAABUx6Stpu8185.jpg', '78', null);
INSERT INTO `pms_sku_image` VALUES ('878', '85', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOANzwpAABGOuGpu5s702.jpg', '79', null);
INSERT INTO `pms_sku_image` VALUES ('879', '85', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOATT9kAAAjTcYpOHA300.jpg', '80', null);
INSERT INTO `pms_sku_image` VALUES ('886', '82', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuANqf7AAAzpeBWucQ738.jpg', '69', null);
INSERT INTO `pms_sku_image` VALUES ('887', '82', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAKGYbAACQ33CNBgI202.jpg', '70', null);
INSERT INTO `pms_sku_image` VALUES ('888', '82', 'u=1780590834,74343091&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAJZLuAAAbekxUTwU917.jpg', '71', null);
INSERT INTO `pms_sku_image` VALUES ('889', '82', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAbM11AABUx6Stpu8094.jpg', '72', null);
INSERT INTO `pms_sku_image` VALUES ('890', '82', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuABXVvAAA2oBvXGRY799.jpg', '73', null);
INSERT INTO `pms_sku_image` VALUES ('891', '82', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAOy_6AAAqaC4JyRU137.jpg', '74', null);
INSERT INTO `pms_sku_image` VALUES ('892', '80', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdHWAUgY1AABGlNSsc8k337.jpg', '64', null);
INSERT INTO `pms_sku_image` VALUES ('893', '80', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AdVB5AACQ33CNBgI849.jpg', '65', null);
INSERT INTO `pms_sku_image` VALUES ('894', '80', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-Af4jjAACnL2DEmZI759.jpg', '66', null);
INSERT INTO `pms_sku_image` VALUES ('895', '80', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-ASvcIAABLvWYyykI760.jpg', '67', null);
INSERT INTO `pms_sku_image` VALUES ('896', '80', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AF-iIAAAzpeBWucQ529.jpg', '68', null);
INSERT INTO `pms_sku_image` VALUES ('897', '84', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuANqf7AAAzpeBWucQ738.jpg', '69', null);
INSERT INTO `pms_sku_image` VALUES ('898', '84', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAKGYbAACQ33CNBgI202.jpg', '70', null);
INSERT INTO `pms_sku_image` VALUES ('899', '84', 'u=1780590834,74343091&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAJZLuAAAbekxUTwU917.jpg', '71', null);
INSERT INTO `pms_sku_image` VALUES ('900', '84', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAbM11AABUx6Stpu8094.jpg', '72', null);
INSERT INTO `pms_sku_image` VALUES ('901', '84', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuABXVvAAA2oBvXGRY799.jpg', '73', null);
INSERT INTO `pms_sku_image` VALUES ('902', '84', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAOy_6AAAqaC4JyRU137.jpg', '74', null);
INSERT INTO `pms_sku_image` VALUES ('909', '87', 'qq.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AOANHAADvM9t8a8k653.jpg', '91', '1');
INSERT INTO `pms_sku_image` VALUES ('910', '87', 'google.png', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AcGfjAAAkRcqoM4I236.png', '92', '0');
INSERT INTO `pms_sku_image` VALUES ('911', '87', 'a.gif', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AK5PgAAEEvUoMWYY866.gif', '93', '1');
INSERT INTO `pms_sku_image` VALUES ('915', '88', 'qq.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AOANHAADvM9t8a8k653.jpg', '91', null);
INSERT INTO `pms_sku_image` VALUES ('916', '88', 'google.png', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AcGfjAAAkRcqoM4I236.png', '92', null);
INSERT INTO `pms_sku_image` VALUES ('917', '88', 'a.gif', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AK5PgAAEEvUoMWYY866.gif', '93', null);
INSERT INTO `pms_sku_image` VALUES ('918', '89', '黑正面.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAZUeyAABl-Gcmj6Q266.jpg', '40', '0');
INSERT INTO `pms_sku_image` VALUES ('919', '89', '黑正2.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAEi7GAAAoCdAcm0Q483.jpg', '41', '0');
INSERT INTO `pms_sku_image` VALUES ('920', '89', '黑侧.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAaNHoAAASDgWlJKA341.jpg', '42', '0');
INSERT INTO `pms_sku_image` VALUES ('921', '89', '黑角.jpg', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJNobAABchtkLSZ4079.jpg', '43', '1');
INSERT INTO `pms_sku_image` VALUES ('922', '89', '充电器', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAahD_AAAoTYXCz4M337.jpg', '44', '0');
INSERT INTO `pms_sku_image` VALUES ('923', '89', '全家福', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAYBe7AACAQkIGrK0125.jpg', '45', '0');
INSERT INTO `pms_sku_image` VALUES ('924', '89', '蓝正', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAPBi4AABzDHfHIis984.jpg', '46', '0');
INSERT INTO `pms_sku_image` VALUES ('925', '89', '蓝全', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaATE04AABTFiuk_fQ924.jpg', '47', '0');
INSERT INTO `pms_sku_image` VALUES ('926', '89', '蓝背', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaABfJ3AAAxq41Xmt8702.jpg', '48', '0');
INSERT INTO `pms_sku_image` VALUES ('927', '89', '蓝底', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJ6nTAAA6Ol3Q8DA559.jpg', '49', '0');
INSERT INTO `pms_sku_image` VALUES ('928', '90', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AHIQrAAB9_p5yd_4967.jpg', '105', null);
INSERT INTO `pms_sku_image` VALUES ('929', '90', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AFwIqAABLvWYyykI463.jpg', '106', null);
INSERT INTO `pms_sku_image` VALUES ('930', '90', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2Ae8JQAABGOuGpu5s305.jpg', '107', null);
INSERT INTO `pms_sku_image` VALUES ('931', '91', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AHIQrAAB9_p5yd_4967.jpg', '105', null);
INSERT INTO `pms_sku_image` VALUES ('932', '91', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AFwIqAABLvWYyykI463.jpg', '106', null);
INSERT INTO `pms_sku_image` VALUES ('933', '91', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2Ae8JQAABGOuGpu5s305.jpg', '107', null);
INSERT INTO `pms_sku_image` VALUES ('934', '92', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AHIQrAAB9_p5yd_4967.jpg', '105', null);
INSERT INTO `pms_sku_image` VALUES ('935', '92', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AFwIqAABLvWYyykI463.jpg', '106', null);
INSERT INTO `pms_sku_image` VALUES ('936', '92', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2Ae8JQAABGOuGpu5s305.jpg', '107', null);
INSERT INTO `pms_sku_image` VALUES ('937', '93', 'u=1593153634,1616724234&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuANqf7AAAzpeBWucQ738.jpg', '69', '1');
INSERT INTO `pms_sku_image` VALUES ('938', '93', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAKGYbAACQ33CNBgI202.jpg', '70', '0');
INSERT INTO `pms_sku_image` VALUES ('939', '93', 'u=1780590834,74343091&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAJZLuAAAbekxUTwU917.jpg', '71', '0');
INSERT INTO `pms_sku_image` VALUES ('940', '93', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAbM11AABUx6Stpu8094.jpg', '72', '0');
INSERT INTO `pms_sku_image` VALUES ('941', '93', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuABXVvAAA2oBvXGRY799.jpg', '73', '0');
INSERT INTO `pms_sku_image` VALUES ('942', '93', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAOy_6AAAqaC4JyRU137.jpg', '74', '0');
INSERT INTO `pms_sku_image` VALUES ('943', '94', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ2AaFK9AACQ33CNBgI041.jpg', '111', '0');
INSERT INTO `pms_sku_image` VALUES ('944', '94', 'u=1780590834,74343091&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ2AeWKOAAAbekxUTwU697.jpg', '112', '0');
INSERT INTO `pms_sku_image` VALUES ('945', '94', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ2AQXzoAABQITqS23s283.jpg', '113', '0');
INSERT INTO `pms_sku_image` VALUES ('946', '94', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ6AMBKmAABGlNSsc8k506.jpg', '114', '1');
INSERT INTO `pms_sku_image` VALUES ('947', '94', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ6AKJbhAAB9_p5yd_4702.jpg', '115', '0');
INSERT INTO `pms_sku_image` VALUES ('948', '95', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKnaAIeu3AACnL2DEmZI636.jpg', '116', '0');
INSERT INTO `pms_sku_image` VALUES ('949', '95', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKniAbY-aAABGlNSsc8k152.jpg', '117', '0');
INSERT INTO `pms_sku_image` VALUES ('950', '95', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKnuARNVPAACQ33CNBgI197.jpg', '118', '0');
INSERT INTO `pms_sku_image` VALUES ('951', '95', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKn6AfKNyAAA2oBvXGRY513.jpg', '119', '0');
INSERT INTO `pms_sku_image` VALUES ('952', '95', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKoKAdFhTAABQITqS23s208.jpg', '120', '1');
INSERT INTO `pms_sku_image` VALUES ('953', '96', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('954', '96', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', null);
INSERT INTO `pms_sku_image` VALUES ('955', '96', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', null);
INSERT INTO `pms_sku_image` VALUES ('956', '96', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', null);
INSERT INTO `pms_sku_image` VALUES ('957', '96', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', null);
INSERT INTO `pms_sku_image` VALUES ('958', '96', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', null);
INSERT INTO `pms_sku_image` VALUES ('959', '96', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', null);
INSERT INTO `pms_sku_image` VALUES ('960', '97', 'u=1859076143,617953825&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg', '57', '1');
INSERT INTO `pms_sku_image` VALUES ('961', '97', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg', '58', null);
INSERT INTO `pms_sku_image` VALUES ('962', '97', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg', '59', null);
INSERT INTO `pms_sku_image` VALUES ('963', '97', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg', '60', null);
INSERT INTO `pms_sku_image` VALUES ('964', '97', 'u=3751071606,1905516954&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAdwrxAABUx6Stpu8553.jpg', '61', null);
INSERT INTO `pms_sku_image` VALUES ('965', '97', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg', '62', null);
INSERT INTO `pms_sku_image` VALUES ('966', '97', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg', '63', null);
INSERT INTO `pms_sku_image` VALUES ('967', '98', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVKb2AABGOuGpu5s269.jpg', '136', '1');
INSERT INTO `pms_sku_image` VALUES ('968', '98', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAcMexAABLvWYyykI946.jpg', '137', '0');
INSERT INTO `pms_sku_image` VALUES ('969', '98', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAJqDBAAB9_p5yd_4998.jpg', '138', '0');
INSERT INTO `pms_sku_image` VALUES ('970', '98', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVNBaAABQITqS23s774.jpg', '139', '0');
INSERT INTO `pms_sku_image` VALUES ('971', '98', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAZLfGAACQ33CNBgI915.jpg', '140', '0');
INSERT INTO `pms_sku_image` VALUES ('972', '99', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVKb2AABGOuGpu5s269.jpg', '136', '0');
INSERT INTO `pms_sku_image` VALUES ('973', '99', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAcMexAABLvWYyykI946.jpg', '137', '1');
INSERT INTO `pms_sku_image` VALUES ('974', '99', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAJqDBAAB9_p5yd_4998.jpg', '138', '0');
INSERT INTO `pms_sku_image` VALUES ('975', '99', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVNBaAABQITqS23s774.jpg', '139', '0');
INSERT INTO `pms_sku_image` VALUES ('976', '99', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAZLfGAACQ33CNBgI915.jpg', '140', '0');
INSERT INTO `pms_sku_image` VALUES ('977', '100', 'u=773170730,2334764817&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eAaSYEAAA2oBvXGRY401.jpg', '141', '1');
INSERT INTO `pms_sku_image` VALUES ('978', '100', 'u=3284569222,2784595507&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eAdFQvAAAjTcYpOHA003.jpg', '142', '0');
INSERT INTO `pms_sku_image` VALUES ('979', '100', 'u=3724014468,2337485034&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eABtqcAACQ33CNBgI768.jpg', '143', '0');
INSERT INTO `pms_sku_image` VALUES ('980', '100', 'u=1419195310,1747442793&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eAAo2gAABQITqS23s583.jpg', '144', '0');
INSERT INTO `pms_sku_image` VALUES ('981', '100', 'u=1780590834,74343091&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eAA68tAAAbekxUTwU639.jpg', '145', '0');
INSERT INTO `pms_sku_image` VALUES ('982', '101', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWACoy4AACnL2DEmZI102.jpg', '146', '1');
INSERT INTO `pms_sku_image` VALUES ('983', '101', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAfb40AAB9_p5yd_4956.jpg', '147', '0');
INSERT INTO `pms_sku_image` VALUES ('984', '101', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAEvBGAABGlNSsc8k780.jpg', '148', '0');
INSERT INTO `pms_sku_image` VALUES ('985', '101', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAJoNKAAAqaC4JyRU792.jpg', '149', '0');
INSERT INTO `pms_sku_image` VALUES ('986', '101', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAMaUQAABGlNSsc8k628.jpg', '150', '0');
INSERT INTO `pms_sku_image` VALUES ('987', '102', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWACoy4AACnL2DEmZI102.jpg', '146', '1');
INSERT INTO `pms_sku_image` VALUES ('988', '102', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAfb40AAB9_p5yd_4956.jpg', '147', '0');
INSERT INTO `pms_sku_image` VALUES ('989', '102', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAEvBGAABGlNSsc8k780.jpg', '148', '0');
INSERT INTO `pms_sku_image` VALUES ('990', '102', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAJoNKAAAqaC4JyRU792.jpg', '149', '0');
INSERT INTO `pms_sku_image` VALUES ('991', '102', 'u=3382825266,1684795340&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWAMaUQAABGlNSsc8k628.jpg', '150', '0');
INSERT INTO `pms_sku_image` VALUES ('992', '103', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAcDhdAABGOuGpu5s589.jpg', '151', '0');
INSERT INTO `pms_sku_image` VALUES ('993', '103', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAQ_irAACnL2DEmZI499.jpg', '152', '0');
INSERT INTO `pms_sku_image` VALUES ('994', '103', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAYYSfAABLvWYyykI766.jpg', '153', '1');
INSERT INTO `pms_sku_image` VALUES ('995', '103', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAYyjjAAB9_p5yd_4003.jpg', '154', '0');
INSERT INTO `pms_sku_image` VALUES ('996', '103', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAHVayAAAqaC4JyRU135.jpg', '155', '0');
INSERT INTO `pms_sku_image` VALUES ('997', '104', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAcDhdAABGOuGpu5s589.jpg', '151', '0');
INSERT INTO `pms_sku_image` VALUES ('998', '104', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAQ_irAACnL2DEmZI499.jpg', '152', '0');
INSERT INTO `pms_sku_image` VALUES ('999', '104', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAYYSfAABLvWYyykI766.jpg', '153', '0');
INSERT INTO `pms_sku_image` VALUES ('1000', '104', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAYyjjAAB9_p5yd_4003.jpg', '154', '0');
INSERT INTO `pms_sku_image` VALUES ('1001', '104', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAHVayAAAqaC4JyRU135.jpg', '155', '1');
INSERT INTO `pms_sku_image` VALUES ('1002', '105', 'u=3792980304,3312035227&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAcDhdAABGOuGpu5s589.jpg', '151', '1');
INSERT INTO `pms_sku_image` VALUES ('1003', '105', 'u=971215194,559285787&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAQ_irAACnL2DEmZI499.jpg', '152', '0');
INSERT INTO `pms_sku_image` VALUES ('1004', '105', 'u=1007169883,3607425998&fm=21&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAYYSfAABLvWYyykI766.jpg', '153', '0');
INSERT INTO `pms_sku_image` VALUES ('1005', '105', 'u=787077068,365624572&fm=11&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAYyjjAAB9_p5yd_4003.jpg', '154', '0');
INSERT INTO `pms_sku_image` VALUES ('1006', '105', 'u=20245988,584105805&fm=23&gp=0.jpg', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAHVayAAAqaC4JyRU135.jpg', '155', '0');
INSERT INTO `pms_sku_image` VALUES ('1007', '107', '2f63d53828761609.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg', '173', '1');
INSERT INTO `pms_sku_image` VALUES ('1008', '107', '93ac3e51e65e4058.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAYAJAAADxHhrWGek412.jpg', '174', '0');
INSERT INTO `pms_sku_image` VALUES ('1009', '107', '98e92fd374f80591.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuACWHEAAE2oopE404661.jpg', '175', '0');
INSERT INTO `pms_sku_image` VALUES ('1010', '107', '707e9b920ef8d97f.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAcTzgAADwoyf0uBo521.jpg', '176', '0');
INSERT INTO `pms_sku_image` VALUES ('1011', '107', '95c466bf55123b4c.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFcZ1AAK8X_B46QA917.jpg', '177', '0');
INSERT INTO `pms_sku_image` VALUES ('1012', '107', '936bfc7036257aca.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAGbOnAAHtrWBC-gY515.jpg', '178', '0');
INSERT INTO `pms_sku_image` VALUES ('1013', '107', '61f65ac6aae3146b.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAIWZrAAdGruigDZs562.jpg', '179', '0');
INSERT INTO `pms_sku_image` VALUES ('1014', '107', '8593bb926e2fa1ea.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuABu06AAMy6xI8ljs330.jpg', '180', '0');
INSERT INTO `pms_sku_image` VALUES ('1015', '108', '68bbfe6f9d3ccb4c (1).jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAAUl1AAMh04qlip0511.jpg', '188', '0');
INSERT INTO `pms_sku_image` VALUES ('1016', '108', '1547dc8a371330fc.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAT3H9AAFU1ohvSUo007.jpg', '189', '0');
INSERT INTO `pms_sku_image` VALUES ('1017', '108', '68bbfe6f9d3ccb4c.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAXY4JAAMh04qlip0275.jpg', '191', '0');
INSERT INTO `pms_sku_image` VALUES ('1018', '108', 'dd6f142f583663bb.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAfag6AAOT2MVegzo895.jpg', '193', '0');
INSERT INTO `pms_sku_image` VALUES ('1019', '108', 'eae52491289f4569.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAS2kbAAM1Vow6zNE734.jpg', '195', '0');
INSERT INTO `pms_sku_image` VALUES ('1020', '108', '2f2ca5de28c6ed56.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAA0QwAAQ_OUORm1Q588.jpg', '197', '1');
INSERT INTO `pms_sku_image` VALUES ('1021', '108', 'ad078902888a8a75.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAdWUuAAM1VjldK8c206.jpg', '185', '0');
INSERT INTO `pms_sku_image` VALUES ('1022', '108', 'b8116bbbc2e4e731.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOALtbnAAIbO5uH5xk974.jpg', '187', '0');
INSERT INTO `pms_sku_image` VALUES ('1023', '109', 'ad078902888a8a75.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAdWUuAAM1VjldK8c206.jpg', '185', '0');
INSERT INTO `pms_sku_image` VALUES ('1024', '109', 'ff57b3d2436d705f.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAb3QsAAFyUHUJwfA466.jpg', '194', '0');
INSERT INTO `pms_sku_image` VALUES ('1025', '109', '3d3fd1f8aceb3c73.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAQ7YlAAMjfPL4Ww0296.jpg', '196', '0');
INSERT INTO `pms_sku_image` VALUES ('1026', '109', '752c121d28917650.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAbbG-AAJLlrZtO5k007.jpg', '198', '0');
INSERT INTO `pms_sku_image` VALUES ('1027', '109', 'abd88adcaa54018e.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAHMGIAAHSeeR4e2Y238.jpg', '199', '0');
INSERT INTO `pms_sku_image` VALUES ('1028', '109', '8a3b41a10259aa84.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAS1UkAAKT3mXV0cU443.jpg', '200', '0');
INSERT INTO `pms_sku_image` VALUES ('1029', '109', '2f63d53828761609.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAKn4CAARDAkbMoEI429.jpg', '201', '1');
INSERT INTO `pms_sku_image` VALUES ('1030', '110', 'ad078902888a8a75.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAdWUuAAM1VjldK8c206.jpg', '185', '0');
INSERT INTO `pms_sku_image` VALUES ('1031', '110', 'b8116bbbc2e4e731.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOALtbnAAIbO5uH5xk974.jpg', '187', '0');
INSERT INTO `pms_sku_image` VALUES ('1032', '110', '68bbfe6f9d3ccb4c (1).jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAAUl1AAMh04qlip0511.jpg', '188', '0');
INSERT INTO `pms_sku_image` VALUES ('1033', '110', '1547dc8a371330fc.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAT3H9AAFU1ohvSUo007.jpg', '189', '0');
INSERT INTO `pms_sku_image` VALUES ('1034', '110', '68bbfe6f9d3ccb4c.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAXY4JAAMh04qlip0275.jpg', '191', '0');
INSERT INTO `pms_sku_image` VALUES ('1035', '110', 'dd6f142f583663bb.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAfag6AAOT2MVegzo895.jpg', '193', '0');
INSERT INTO `pms_sku_image` VALUES ('1036', '110', '2f2ca5de28c6ed56.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAA0QwAAQ_OUORm1Q588.jpg', '197', '1');
INSERT INTO `pms_sku_image` VALUES ('1037', '111', 'ad078902888a8a75.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAdWUuAAM1VjldK8c206.jpg', '185', '0');
INSERT INTO `pms_sku_image` VALUES ('1038', '111', 'b8116bbbc2e4e731.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOALtbnAAIbO5uH5xk974.jpg', '187', '0');
INSERT INTO `pms_sku_image` VALUES ('1039', '111', '68bbfe6f9d3ccb4c (1).jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAAUl1AAMh04qlip0511.jpg', '188', '0');
INSERT INTO `pms_sku_image` VALUES ('1040', '111', '1547dc8a371330fc.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAT3H9AAFU1ohvSUo007.jpg', '189', '0');
INSERT INTO `pms_sku_image` VALUES ('1041', '111', '68bbfe6f9d3ccb4c.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAXY4JAAMh04qlip0275.jpg', '191', '0');
INSERT INTO `pms_sku_image` VALUES ('1042', '111', 'dd6f142f583663bb.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAfag6AAOT2MVegzo895.jpg', '193', '0');
INSERT INTO `pms_sku_image` VALUES ('1043', '111', '2f2ca5de28c6ed56.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAA0QwAAQ_OUORm1Q588.jpg', '197', '1');
INSERT INTO `pms_sku_image` VALUES ('1044', '112', 'c3935cb7e2017f6c.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAcj2tAAM1VjldK8c189.jpg', '186', '0');
INSERT INTO `pms_sku_image` VALUES ('1045', '112', 'ff57b3d2436d705f.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAb3QsAAFyUHUJwfA466.jpg', '194', '0');
INSERT INTO `pms_sku_image` VALUES ('1046', '112', '3d3fd1f8aceb3c73.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAQ7YlAAMjfPL4Ww0296.jpg', '196', '0');
INSERT INTO `pms_sku_image` VALUES ('1047', '112', '752c121d28917650.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAbbG-AAJLlrZtO5k007.jpg', '198', '0');
INSERT INTO `pms_sku_image` VALUES ('1048', '112', 'abd88adcaa54018e.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAHMGIAAHSeeR4e2Y238.jpg', '199', '0');
INSERT INTO `pms_sku_image` VALUES ('1049', '112', '8a3b41a10259aa84.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAS1UkAAKT3mXV0cU443.jpg', '200', '0');
INSERT INTO `pms_sku_image` VALUES ('1050', '112', '2f63d53828761609.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAKn4CAARDAkbMoEI429.jpg', '201', '1');
INSERT INTO `pms_sku_image` VALUES ('1051', '113', '2f63d53828761609.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAKn4CAARDAkbMoEI429.jpg', '201', '1');
INSERT INTO `pms_sku_image` VALUES ('1052', '113', '8a3b41a10259aa84.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAS1UkAAKT3mXV0cU443.jpg', '200', '0');
INSERT INTO `pms_sku_image` VALUES ('1053', '113', 'abd88adcaa54018e.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAHMGIAAHSeeR4e2Y238.jpg', '199', '0');
INSERT INTO `pms_sku_image` VALUES ('1054', '113', '752c121d28917650.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAbbG-AAJLlrZtO5k007.jpg', '198', '0');
INSERT INTO `pms_sku_image` VALUES ('1055', '113', '3d3fd1f8aceb3c73.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAQ7YlAAMjfPL4Ww0296.jpg', '196', '0');
INSERT INTO `pms_sku_image` VALUES ('1056', '113', 'eae52491289f4569.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAS2kbAAM1Vow6zNE734.jpg', '195', '0');
INSERT INTO `pms_sku_image` VALUES ('1057', '113', 'ff57b3d2436d705f.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAb3QsAAFyUHUJwfA466.jpg', '194', '0');
INSERT INTO `pms_sku_image` VALUES ('1058', '114', '80c05c1914a6aa92 (1).jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOABlzsAANkkyc3rIg895.jpg', '181', '0');
INSERT INTO `pms_sku_image` VALUES ('1059', '114', '801a0f54f2e21580.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOALSeAAAHG5NpN_9M133.jpg', '182', '0');
INSERT INTO `pms_sku_image` VALUES ('1060', '114', 'ad078902888a8a75.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAdWUuAAM1VjldK8c206.jpg', '185', '0');
INSERT INTO `pms_sku_image` VALUES ('1061', '114', '9bca664ff863a1a4.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAYrcjAATE5rZEXkU173.jpg', '190', '1');
INSERT INTO `pms_sku_image` VALUES ('1062', '114', '18106ce3d8bb593a.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAd33TAANTQTjaVjQ527.jpg', '192', '0');
INSERT INTO `pms_sku_image` VALUES ('1063', '115', '80c05c1914a6aa92 (1).jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOABlzsAANkkyc3rIg895.jpg', '181', '0');
INSERT INTO `pms_sku_image` VALUES ('1064', '115', '801a0f54f2e21580.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOALSeAAAHG5NpN_9M133.jpg', '182', '0');
INSERT INTO `pms_sku_image` VALUES ('1065', '115', 'c3935cb7e2017f6c.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAcj2tAAM1VjldK8c189.jpg', '186', '0');
INSERT INTO `pms_sku_image` VALUES ('1066', '115', '9bca664ff863a1a4.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAYrcjAATE5rZEXkU173.jpg', '190', '1');
INSERT INTO `pms_sku_image` VALUES ('1067', '115', 'dd6f142f583663bb.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAfag6AAOT2MVegzo895.jpg', '193', '0');
INSERT INTO `pms_sku_image` VALUES ('1068', '116', '80c05c1914a6aa92 (1).jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOABlzsAANkkyc3rIg895.jpg', '181', '0');
INSERT INTO `pms_sku_image` VALUES ('1069', '116', '801a0f54f2e21580.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOALSeAAAHG5NpN_9M133.jpg', '182', '0');
INSERT INTO `pms_sku_image` VALUES ('1070', '116', 'ad078902888a8a75.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAdWUuAAM1VjldK8c206.jpg', '185', '0');
INSERT INTO `pms_sku_image` VALUES ('1071', '116', '9bca664ff863a1a4.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAYrcjAATE5rZEXkU173.jpg', '190', '1');
INSERT INTO `pms_sku_image` VALUES ('1072', '116', '18106ce3d8bb593a.jpg', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAd33TAANTQTjaVjQ527.jpg', '192', '0');

-- ----------------------------
-- Table structure for `pms_sku_info`
-- ----------------------------
DROP TABLE IF EXISTS `pms_sku_info`;
CREATE TABLE `pms_sku_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '库存id(itemID)',
  `spu_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `price` double DEFAULT NULL COMMENT '价格',
  `sku_name` varchar(200) DEFAULT NULL COMMENT 'sku名称',
  `sku_desc` varchar(2000) DEFAULT NULL COMMENT '商品规格描述',
  `weight` double DEFAULT NULL,
  `tm_id` bigint(20) DEFAULT NULL COMMENT '品牌(冗余)',
  `catalog3_id` bigint(20) DEFAULT NULL COMMENT '三级分类id（冗余)',
  `sku_default_img` varchar(200) DEFAULT NULL COMMENT '默认显示图片(冗余)',
  PRIMARY KEY (`id`),
  KEY `idx_sku_info_sku_name` (`sku_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COMMENT='库存单元表';

-- ----------------------------
-- Records of pms_sku_info
-- ----------------------------
INSERT INTO `pms_sku_info` VALUES ('11', '24', '2299', '小米6 全网通 4GB+64GB 亮黑色 移动联通电信4G手机 双卡双待', '商品名称：小米 小米6商品编号：4230919商品毛重：400.00g商品产地：中国大陆系统：安卓（Android）机身厚度：薄（7mm-8.5mm）拍照特点：光学变焦，后置双摄像头电池容量：3000mAh-3999mAh机身颜色：黑色系热点：快速充电运行内存：4GB前置摄像头像素：800万-1599万游戏配置：MIMO技术后置摄像头像素：1200万-1999万机身内存：64GB屏幕配置：全高清 FHD', '0.4', null, '61', 'https://img13.360buyimg.com/n7/jfs/t4177/323/133450331/58871/8754fee4/58afc7b7Nd5208ecc.jpg');
INSERT INTO `pms_sku_info` VALUES ('12', '24', '2299', '小米6 全网通 4GB+64GB 亮蓝色 移动联通电信4G手机 双卡双待', '商品名称：小米 小米6商品编号：5159264商品毛重：400.00g商品产地：中国大陆系统：安卓（Android）机身厚度：薄（7mm-8.5mm）拍照特点：光学变焦，后置双摄像头电池容量：3000mAh-3999mAh机身颜色：浅蓝色系热点：快速充电运行内存：4GB前置摄像头像素：800万-1599万游戏配置：MIMO技术后置摄像头像素：1200万-19', '0.4', null, '61', 'https://img13.360buyimg.com/n7/jfs/t4177/323/133450331/58871/8754fee4/58afc7b7Nd5208ecc.jpg');
INSERT INTO `pms_sku_info` VALUES ('13', '24', '2899', '小米6 全网通 6GB+128GB 亮黑色 移动联通电信4G手机 双卡双待', '品牌： 小米（MI）商品名称：小米小米6商品编号：4919520商品毛重：410.00g商品产地：中国大陆系统：安卓（Android）机身厚度：薄（7mm-8.5mm）拍照特点：光学变焦，后置双摄像头电池容量：3000mAh-3999mAh机身颜色：黑色系热点：快速充电运行内存：6GB前置摄像头像素：800万-1599万游戏配置：MIMO技术后置摄像头像素：1200万-1999万机身内存：128GB屏幕配置：全高清 FHD', '0.4', null, '61', 'https://img13.360buyimg.com/n7/jfs/t4177/323/133450331/58871/8754fee4/58afc7b7Nd5208ecc.jpg');
INSERT INTO `pms_sku_info` VALUES ('14', '24', '2888', '小米6 全网通 6GB+128GB 亮蓝色 移动联通电信4G手机 双卡双待', '小米6 全网通 6GB+128GB 亮蓝色 移动联通电信4G手机 双卡双待', '0.12', null, '61', 'https://img13.360buyimg.com/n7/jfs/t4177/323/133450331/58871/8754fee4/58afc7b7Nd5208ecc.jpg');
INSERT INTO `pms_sku_info` VALUES ('15', '24', '1000', '测试手机1', '商品 很轻', '10', null, '61', 'https://img13.360buyimg.com/n7/jfs/t4177/323/133450331/58871/8754fee4/58afc7b7Nd5208ecc.jpg');
INSERT INTO `pms_sku_info` VALUES ('16', '25', '1000', '硅谷测试双摄像头宽屏幕手机A1系列红色水军', '硅谷测试双摄像头宽屏幕手机A1系列红色水军硅谷测试双摄像头宽屏幕手机A1系列红色水军', '10', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('17', '25', '1000', '硅谷测试双摄像头宽屏幕手机A1系列红色水军', '硅谷测试双摄像头宽屏幕手机A1系列红色水军硅谷测试双摄像头宽屏幕手机A1系列红色水军', '100', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('18', '25', '1000', '硅谷测试双摄像头宽屏幕手机A1系列红色水军', '硅谷测试双摄像头宽屏幕手机A1系列红色水军硅谷测试双摄像头宽屏幕手机A1系列红色水军', '10', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('19', '25', '1', '硅谷水军系列手机A', '1', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg');
INSERT INTO `pms_sku_info` VALUES ('20', '24', '2000', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待 ', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待  小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待 ', '22', null, '61', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAZUeyAABl-Gcmj6Q266.jpg');
INSERT INTO `pms_sku_info` VALUES ('21', '24', '2000', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待 ', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待  小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待 ', '22', null, '61', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmKAZUeyAABl-Gcmj6Q266.jpg');
INSERT INTO `pms_sku_info` VALUES ('22', '25', '1000', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待 ', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待 ', '12', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('23', '25', '1500', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待 ', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待  小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待 ', '15', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('24', '25', '2333', '小米Note3 全网通 6GB 128GB 黑色 移动联通电信4G手机 双卡双待', '小米Note3 全网通 6GB 128GB 黑色 移动联通电信4G手机 双卡双待', '11', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg');
INSERT INTO `pms_sku_info` VALUES ('25', '25', '2200', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 蓝色 全网通4G手机 双卡双待 ', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 蓝色 全网通4G手机 双卡双待 ', '22', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('26', '25', '2300', '小米 红米Note5A 全网通版 3GB+32GB 香槟金 移动联通电信4G手机 双卡双待 ', '小米 红米Note5A 全网通版 3GB+32GB 香槟金 移动联通电信4G手机 双卡双待 ', '33', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg');
INSERT INTO `pms_sku_info` VALUES ('27', '25', '6000', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '50', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg');
INSERT INTO `pms_sku_info` VALUES ('28', '25', '1231445', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg');
INSERT INTO `pms_sku_info` VALUES ('29', '25', '1000', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '23333', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('30', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '323', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('31', '25', '122222223', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '12313', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('32', '25', '1111', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '22', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('33', '25', '54444', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '12', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('34', '25', '222', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '222', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('35', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '23', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('36', '25', '1234', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '14', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('37', '25', '1232333', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123333', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('38', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('39', '25', '12323232', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('40', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('41', '25', '123333', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '222', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('42', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('43', '25', '12', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('44', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '213', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('45', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('46', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('47', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('48', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('49', '25', '12312', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('50', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('51', '25', '23123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('52', '25', '23123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('53', '25', '23123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('54', '25', '23123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('55', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '12313', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('56', '25', '1231', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '231', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('57', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('58', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123132', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('59', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123132', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('60', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('61', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '12313', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('62', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('63', '25', '12312', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '3123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('64', '25', '12312', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '3123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('65', '25', '12312', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '3123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('66', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('67', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('68', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('69', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('70', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('71', '25', '123', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', ' 小米5 全网通 尊享陶瓷 4GB内存 128GB ROM 黑色 移动联通电信4G手机 ', '123', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('72', '25', '123', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待 ', ' 小米Note3 美颜双摄拍照手机 6GB+64GB 黑色 全网通4G手机 双卡双待 ', '32', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAXVwTAAAjTcYpOHA109.jpg');
INSERT INTO `pms_sku_info` VALUES ('73', '25', '33333', ' 当季新品 小米MIX2全面屏游戏手机 6GB+64GB 黑色 全网通4G 陶瓷手机 ', ' 当季新品 小米MIX2S 全面屏游戏手机 6GB+64GB 黑色 全网通4G 陶瓷手机 ', '22', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUZZ_AACQ33CNBgI122.jpg');
INSERT INTO `pms_sku_info` VALUES ('74', '25', '7000', '当季新品 小米MIX2全面屏游戏手机 6GB+64GB 白色 全网通4G 陶瓷手机 ', ' 当季新品 小米MIX2S 全面屏游戏手机 6GB+64GB 白色 全网通4G 陶瓷手机 ', '45', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAEtNCAABGOuGpu5s437.jpg');
INSERT INTO `pms_sku_info` VALUES ('75', '25', '4', '华为 HUAWEI P10 Plus 6GB+128GB 钻雕金 移动联通电信4G手机 双卡双待', '华为 HUAWEI P10 Plus 6GB+128GB 钻雕金 移动联通电信4G手机 双卡双待', '222', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGmAdTUfAABGlNSsc8k430.jpg');
INSERT INTO `pms_sku_info` VALUES ('76', '25', '5111', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机 ', 'Apple iPhone 7 Plus (A1661) 128G 玫瑰金色 移动联通电信4G手机 ', '22', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkGiAUzd8AACnL2DEmZI162.jpg');
INSERT INTO `pms_sku_info` VALUES ('77', '25', '100', '测试添加sku1', '测试添加sku1', '10', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('78', '25', '111', '测试sku111', '2323233233', '11', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('79', '26', '5', '玫瑰金色 移动联通电信4G手机 ', 'Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 ', '3', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('80', '26', '5000', 'Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 ', 'Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 ', '34', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-AdVB5AACQ33CNBgI849.jpg');
INSERT INTO `pms_sku_info` VALUES ('81', '27', '6000', ' Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 ', ' Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机  Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机  Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 ', '60', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('82', '27', '8', ' Apple iPhone 6s Plus (A1699) 8G 玫瑰金色 移动联通电信4G手机 ', ' Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机  Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机  Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机  Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 ', '8', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuANqf7AAAzpeBWucQ738.jpg');
INSERT INTO `pms_sku_info` VALUES ('83', '26', '700', ' Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 ', ' Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机  Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机  Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机  Apple iPhone 6s Plus (A1699) 32G 玫瑰金色 移动联通电信4G手机 ', '78', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdHWAUgY1AABGlNSsc8k337.jpg');
INSERT INTO `pms_sku_info` VALUES ('84', '27', '10', '64GB 金色 移动联通电信4G手机 ', '10', '10', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuAKGYbAACQ33CNBgI202.jpg');
INSERT INTO `pms_sku_info` VALUES ('85', '28', '7', 'Apple iPhone 8 (A1863) 64GB 金色 移动联通电信4G手机 ', '  Apple iPhone 8 (A1863) 64GB 金色 移动联通电信4G手机  Apple iPhone 8 (A1863) 64GB 金色 移动联通电信4G手机  Apple iPhone 8 (A1863) 64GB 金色 移动联通电信4G手机  Apple iPhone 8 (A1863) 64GB 金色 移动联通电信4G手机 Apple iPhone 8 (A1863) 64GB 金色 移动联通电信4G手机  Apple iPhone 8 (A1863) 64GB 金色 移动联通电信4G手机  Apple iPhone 8 (A1863) 64GB 金色 移动联通电信4G手机  Apple iPhone 8 (A1863) 64GB 金色 移动联通电信4G手机 ', '3', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtfcOAanCWAABKCGOfKjM751.jpg');
INSERT INTO `pms_sku_info` VALUES ('86', '26', '100', 'bogetest1', 'aeedasddsd', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrtdS-Af4jjAACnL2DEmZI759.jpg');
INSERT INTO `pms_sku_info` VALUES ('87', '45', '2', '测试销售属性手机2', '测试1版测试销售属性手机2', '2', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AK5PgAAEEvUoMWYY866.gif');
INSERT INTO `pms_sku_info` VALUES ('88', '45', '1', '测试销售属性手机1', '测试1版测试销售属性手机1', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVr-kT6AOANHAADvM9t8a8k653.jpg');
INSERT INTO `pms_sku_info` VALUES ('89', '24', '666', '小米6666', '666', '666', null, '61', 'http://192.168.67.163/group1/M00/00/00/wKhDo1qmZmaAJNobAABchtkLSZ4079.jpg');
INSERT INTO `pms_sku_info` VALUES ('90', '50', '100', '硅谷容错ai1系列测试版A001', '是的发声方法', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AFwIqAABLvWYyykI463.jpg');
INSERT INTO `pms_sku_info` VALUES ('91', '50', '100', '硅谷容错ai1系列测试版A001', '是的发声方法', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AFwIqAABLvWYyykI463.jpg');
INSERT INTO `pms_sku_info` VALUES ('92', '50', '10000', '尚硅谷ai容错测试版手机A001', '123123', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFFs1jZ2AFwIqAABLvWYyykI463.jpg');
INSERT INTO `pms_sku_info` VALUES ('93', '27', '11', '苹果8X系列红色128G内存新款手机', '苹果8X系列红色128G内存新款手机苹果8X系列红色128G内存新款手机苹果8X系列红色128G内存新款手机', '22', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrteJuANqf7AAAzpeBWucQ738.jpg');
INSERT INTO `pms_sku_info` VALUES ('94', '53', '1000', '尚硅谷超长待机系列A型号小屏幕版大内存', '尚硅谷超长待机系列A型号小屏幕版大内存', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFFt6KZ6AMBKmAABGlNSsc8k506.jpg');
INSERT INTO `pms_sku_info` VALUES ('95', '54', '1', '尚硅谷无人驾驶手机R720大屏幕低配版', '尚硅谷无人驾驶手机R720大屏幕低配版尚硅谷无人驾驶手机R720大屏幕低配版尚硅谷无人驾驶手机R720大屏幕低配版尚硅谷无人驾驶手机R720大屏幕低配版', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFFuTKoKAdFhTAABQITqS23s208.jpg');
INSERT INTO `pms_sku_info` VALUES ('96', '25', '1000', '小米硅谷测试双摄像头AI(8G)', '尚硅谷测试手机智能I(8G)', '10', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('97', '25', '1000', '小米硅谷测试双摄像头AI(8G)', '尚硅谷测试手机智能I(8G)', '10', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFVrMkFmALbd9AABKCGOfKjM371.jpg');
INSERT INTO `pms_sku_info` VALUES ('98', '61', '10000', '尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 红色 硅谷纪念限量版', '尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 黑色 硅谷纪念限量版尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 黑色 硅谷纪念限量版尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 黑色 硅谷纪念限量版尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 黑色 硅谷纪念限量版尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 黑色 硅谷纪念限量版', '0.5', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAVKb2AABGOuGpu5s269.jpg');
INSERT INTO `pms_sku_info` VALUES ('99', '61', '9000', '尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 花色4寸 纪念版', '尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 花色4寸 纪念版尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 花色4寸 纪念版尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 花色4寸 纪念版尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 花色4寸 纪念版尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 花色4寸 纪念版尚硅谷gmall0725全面屏游戏智能手机 6GB+64GB 花色4寸 纪念版', '0.4', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwF32OAcMexAABLvWYyykI946.jpg');
INSERT INTO `pms_sku_info` VALUES ('100', '62', '10000', '尚硅谷0725测试游戏手机(n系列) 16G 高配版', '尚硅谷0725测试游戏手机(n系列) 16G 高配版尚硅谷0725测试游戏手机(n系列) 16G 高配版尚硅谷0725测试游戏手机(n系列) 16G 高配版尚硅谷0725测试游戏手机(n系列) 16G 高配版尚硅谷0725测试游戏手机(n系列) 16G 高配版尚硅谷0725测试游戏手机(n系列) 16G 高配版尚硅谷0725测试游戏手机(n系列) 16G 高配版尚硅谷0725测试游戏手机(n系列) 16G 高配版', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFFwcg1eAaSYEAAA2oBvXGRY401.jpg');
INSERT INTO `pms_sku_info` VALUES ('101', '63', '500', '尚硅谷课堂测试系列手机0906系列64G小内存容量版', '尚硅谷课堂测试系列手机0906系列256G大内存容量版', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWACoy4AACnL2DEmZI102.jpg');
INSERT INTO `pms_sku_info` VALUES ('102', '63', '100', '尚硅谷课堂测试系列手机0906系列256G大内存容量版', '尚硅谷课堂测试系列手机0906系列256G大内存容量版', '1', null, '61', 'http://192.168.222.20/group1/M00/00/00/wKjeFFw76NWACoy4AACnL2DEmZI102.jpg');
INSERT INTO `pms_sku_info` VALUES ('103', '65', '10001', '黑鲨游戏手机Gmall1015系列低配双核版', '黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版', '10', null, '61', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAYYSfAABLvWYyykI766.jpg');
INSERT INTO `pms_sku_info` VALUES ('104', '65', '5000', '黑鲨游戏手机Gmall1015系列纪念版1T存储', '黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版', '10', null, '61', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAHVayAAAqaC4JyRU135.jpg');
INSERT INTO `pms_sku_info` VALUES ('105', '65', '2000', '黑鲨游戏手机Gmall1015系列加长版大硬盘5T', '黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版黑鲨游戏手机Gmall1015系列低配双核版', '10', null, '61', 'http://192.168.222.20/group1/M00/00/01/wKjeFFx_M_iAcDhdAABGOuGpu5s589.jpg');
INSERT INTO `pms_sku_info` VALUES ('107', '69', '1299', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '0.24', null, '61', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6QoyuAFTrWAALsJ3lkjbo738.jpg');
INSERT INTO `pms_sku_info` VALUES ('108', '70', '5499', 'Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待', 'Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待', '0.47', null, '61', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAA0QwAAQ_OUORm1Q588.jpg');
INSERT INTO `pms_sku_info` VALUES ('109', '70', '5499', 'Apple iPhone 11 (A2223) 64GB 白色 移动联通电信4G手机 双卡双待', 'Apple iPhone 11 (A2223) 64GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 白色 移动联通电信4G手机 双卡双待', '0.47', null, '61', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAKn4CAARDAkbMoEI429.jpg');
INSERT INTO `pms_sku_info` VALUES ('110', '70', '5499', 'Apple iPhone 11 (A2223) 128GB 黑色 移动联通电信4G手机 双卡双待', 'Apple iPhone 11 (A2223) 128GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 黑色 移动联通电信4G手机 双卡双待', '0.47', null, '61', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAA0QwAAQ_OUORm1Q588.jpg');
INSERT INTO `pms_sku_info` VALUES ('111', '70', '5499', 'Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待', 'Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 黑色 移动联通电信4G手机 双卡双待', '0.47', null, '61', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAA0QwAAQ_OUORm1Q588.jpg');
INSERT INTO `pms_sku_info` VALUES ('112', '70', '5499', 'Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待', 'Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 白色移动联通电信4G手机 双卡双待', '0.47', null, '61', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAKn4CAARDAkbMoEI429.jpg');
INSERT INTO `pms_sku_info` VALUES ('113', '70', '5499', 'Apple iPhone 11 (A2223) 256GB 白色 移动联通电信4G手机 双卡双待', 'Apple iPhone 11 (A2223) 256GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 白色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 白色 移动联通电信4G手机 双卡双待', '0.47', null, '61', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAKn4CAARDAkbMoEI429.jpg');
INSERT INTO `pms_sku_info` VALUES ('114', '70', '5499', 'Apple iPhone 11 (A2223) 64GB 红色 移动联通电信4G手机 双卡双待', 'Apple iPhone 11 (A2223) 64GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 64GB 红色 移动联通电信4G手机 双卡双待', '0.47', null, '61', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAYrcjAATE5rZEXkU173.jpg');
INSERT INTO `pms_sku_info` VALUES ('115', '70', '5499', 'Apple iPhone 11 (A2223) 128GB 红色 移动联通电信4G手机 双卡双待', 'Apple iPhone 11 (A2223) 128GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 128GB 红色 移动联通电信4G手机 双卡双待', '0.47', null, '61', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAYrcjAATE5rZEXkU173.jpg');
INSERT INTO `pms_sku_info` VALUES ('116', '70', '5499', 'Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待', 'Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待Apple iPhone 11 (A2223) 256GB 红色 移动联通电信4G手机 双卡双待', '0.47', null, '61', 'http://192.168.184.130/group1/M00/00/00/wKi4gl6TWxOAYrcjAATE5rZEXkU173.jpg');

-- ----------------------------
-- Table structure for `pms_sku_sale_attr_value`
-- ----------------------------
DROP TABLE IF EXISTS `pms_sku_sale_attr_value`;
CREATE TABLE `pms_sku_sale_attr_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '库存单元id',
  `sale_attr_id` bigint(20) DEFAULT NULL COMMENT '销售属性id（冗余)',
  `sale_attr_value_id` bigint(20) DEFAULT NULL COMMENT '销售属性值id',
  `sale_attr_name` varchar(20) DEFAULT NULL COMMENT '销售属性名称(冗余)',
  `sale_attr_value_name` varchar(20) DEFAULT NULL COMMENT '销售属性值名称(冗余)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=484 DEFAULT CHARSET=utf8 COMMENT='sku销售属性值';

-- ----------------------------
-- Records of pms_sku_sale_attr_value
-- ----------------------------
INSERT INTO `pms_sku_sale_attr_value` VALUES ('48', '13', '1', '47', '颜色', '亮黑');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('49', '13', '4', '50', '容量', '6G+128G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('52', '11', '1', '47', '颜色', '亮黑');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('53', '11', '4', '49', '容量', '4G+64G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('54', '14', '1', '48', '颜色', '亮蓝');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('55', '14', '4', '50', '容量', '6G+128G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('56', '12', '1', '48', '颜色', '亮蓝');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('57', '12', '4', '49', '容量', '4G+64G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('58', '15', '1', '47', '颜色', '亮黑');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('59', '15', '4', '50', '容量', '6G+128G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('68', '20', '1', '47', '颜色', '亮黑');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('69', '20', '4', '50', '容量', '6G+128G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('70', '21', '1', '47', '颜色', '亮黑');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('71', '21', '4', '50', '容量', '6G+128G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('76', '23', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('77', '23', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('78', '23', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('79', '23', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('88', '26', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('89', '26', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('90', '26', '3', '71', '版本', 'C版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('91', '26', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('92', '27', '2', '65', '尺寸', '3尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('93', '27', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('94', '27', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('95', '27', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('96', '28', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('97', '28', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('98', '28', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('99', '28', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('100', '29', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('101', '29', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('102', '29', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('103', '29', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('104', '30', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('105', '30', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('106', '30', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('107', '30', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('108', '31', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('109', '31', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('110', '31', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('111', '31', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('112', '32', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('113', '32', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('114', '32', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('115', '32', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('116', '33', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('117', '33', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('118', '33', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('119', '33', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('120', '34', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('121', '34', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('122', '34', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('123', '34', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('124', '35', '2', '65', '尺寸', '3尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('125', '35', '1', '68', '颜色', '白色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('126', '35', '3', '70', '版本', 'B版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('127', '35', '4', '73', '容量', '11G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('128', '36', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('129', '36', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('130', '36', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('131', '36', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('132', '37', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('133', '37', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('134', '37', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('135', '37', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('136', '38', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('137', '38', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('138', '38', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('139', '38', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('140', '39', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('141', '39', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('142', '39', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('143', '39', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('144', '40', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('145', '40', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('146', '40', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('147', '40', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('148', '41', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('149', '41', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('150', '41', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('151', '41', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('152', '42', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('153', '42', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('154', '42', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('155', '42', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('156', '43', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('157', '43', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('158', '43', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('159', '43', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('160', '44', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('161', '44', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('162', '44', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('163', '44', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('164', '45', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('165', '45', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('166', '45', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('167', '45', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('168', '46', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('169', '47', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('170', '46', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('171', '48', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('172', '47', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('173', '46', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('174', '48', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('175', '47', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('176', '46', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('177', '48', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('178', '47', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('179', '48', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('180', '49', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('181', '49', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('182', '49', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('183', '49', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('184', '50', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('185', '50', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('186', '50', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('187', '50', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('188', '52', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('189', '52', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('190', '52', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('191', '53', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('192', '52', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('193', '53', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('194', '53', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('195', '53', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('196', '51', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('197', '51', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('198', '51', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('199', '51', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('200', '54', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('201', '54', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('202', '54', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('203', '54', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('204', '55', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('205', '55', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('206', '55', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('207', '55', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('208', '56', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('209', '56', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('210', '56', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('211', '56', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('212', '57', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('213', '57', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('214', '57', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('215', '57', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('216', '58', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('217', '58', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('218', '58', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('219', '58', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('220', '59', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('221', '59', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('222', '59', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('223', '59', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('224', '60', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('225', '60', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('226', '60', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('227', '60', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('228', '61', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('229', '61', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('230', '61', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('231', '61', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('232', '62', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('233', '62', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('234', '62', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('235', '62', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('236', '64', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('237', '64', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('238', '64', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('239', '64', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('240', '65', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('241', '65', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('242', '65', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('243', '65', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('244', '63', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('245', '63', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('246', '63', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('247', '63', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('248', '67', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('249', '67', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('250', '67', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('251', '67', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('252', '66', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('253', '66', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('254', '66', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('255', '66', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('256', '68', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('257', '68', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('258', '68', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('259', '68', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('260', '69', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('261', '69', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('262', '69', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('263', '69', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('264', '70', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('265', '70', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('266', '70', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('267', '70', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('268', '71', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('269', '71', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('270', '71', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('271', '71', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('272', '72', '2', '65', '尺寸', '3尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('273', '72', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('274', '72', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('275', '72', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('276', '73', '2', '64', '尺寸', '2尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('277', '73', '1', '68', '颜色', '白色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('278', '73', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('279', '73', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('280', '74', '2', '64', '尺寸', '2尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('281', '74', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('282', '74', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('283', '74', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('284', '75', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('285', '75', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('286', '75', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('287', '75', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('288', '76', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('289', '76', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('290', '76', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('291', '76', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('292', '77', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('293', '77', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('294', '77', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('295', '77', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('296', '78', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('297', '78', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('298', '78', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('299', '78', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('315', '86', '1', '77', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('316', '86', '3', '81', '版本', '次版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('317', '10', '1', '46', '颜色', '陶瓷黑');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('318', '10', '4', '50', '容量', '6G+128G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('327', '22', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('328', '22', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('329', '22', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('330', '22', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('331', '25', '2', '65', '尺寸', '3尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('332', '25', '1', '68', '颜色', '白色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('333', '25', '3', '70', '版本', 'B版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('334', '25', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('343', '17', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('344', '17', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('345', '17', '3', '70', '版本', 'B版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('346', '17', '4', '74', '容量', '12G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('347', '24', '2', '64', '尺寸', '2尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('348', '24', '1', '67', '颜色', '蓝色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('349', '24', '3', '71', '版本', 'C版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('350', '24', '4', '73', '容量', '11G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('363', '19', '2', '65', '尺寸', '3尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('364', '19', '1', '68', '颜色', '白色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('365', '19', '3', '71', '版本', 'C版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('366', '19', '4', '74', '容量', '12G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('375', '83', '1', '75', '颜色', '蓝色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('376', '83', '3', '81', '版本', '次版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('379', '18', '2', '63', '尺寸', '1尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('380', '18', '1', '66', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('381', '18', '3', '69', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('382', '18', '4', '72', '容量', '10G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('387', '81', '3', '85', '版本', '123');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('388', '81', '2', '88', '尺寸', '111213');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('399', '79', '1', '77', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('400', '79', '3', '80', '版本', '盗版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('406', '85', '4', '91', '容量', '300');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('409', '82', '3', '83', '版本', '1');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('410', '82', '2', '86', '尺寸', '11');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('411', '80', '1', '75', '颜色', '蓝色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('412', '80', '3', '79', '版本', '牛版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('413', '84', '3', '84', '版本', '2');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('414', '84', '2', '88', '尺寸', '13');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('421', '87', '1', '130', '颜色', '测试色1');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('422', '87', '2', '134', '尺寸', '测试2寸');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('423', '87', '3', '138', '版本', '测试3版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('427', '88', '1', '131', '颜色', '测试色2');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('428', '88', '2', '134', '尺寸', '测试2寸');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('429', '88', '3', '137', '版本', '测试2版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('430', '89', '1', '46', '颜色', '陶瓷黑');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('431', '89', '4', '49', '容量', '4G+64G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('432', '92', '3', '162', '版本', 'B2');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('433', '92', '1', '164', '颜色', '黑色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('434', '93', '3', '84', '版本', '2');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('435', '93', '2', '87', '尺寸', '12');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('436', '94', '3', '171', '版本', '一年版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('437', '94', '1', '174', '颜色', '土黄');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('438', '95', '3', '176', '版本', 'A版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('439', '95', '1', '180', '颜色', '硅谷蓝');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('440', '96', '2', '64', '尺寸', '2尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('441', '96', '1', '67', '颜色', '蓝色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('442', '96', '3', '70', '版本', 'B版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('443', '96', '4', '73', '容量', '11G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('444', '97', '2', '64', '尺寸', '2尺');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('445', '97', '1', '67', '颜色', '蓝色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('446', '97', '3', '70', '版本', 'B版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('447', '97', '4', '73', '容量', '11G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('448', '98', '1', '209', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('449', '98', '2', '211', '尺寸', '5寸');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('450', '99', '1', '208', '颜色', '花色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('451', '99', '2', '210', '尺寸', '4寸');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('452', '100', '2', '214', '尺寸', '6寸');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('453', '100', '4', '217', '容量', '16G');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('454', '101', '1', '219', '颜色', '蓝色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('455', '101', '3', '221', '版本', 'b版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('456', '102', '1', '218', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('457', '102', '3', '220', '版本', 'a版');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('458', '103', '1', '232', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('459', '103', '4', '238', '容量', '5T');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('460', '104', '1', '231', '颜色', '黑色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('461', '104', '4', '236', '容量', '1T');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('462', '105', '1', '235', '颜色', '变色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('463', '105', '4', '237', '容量', '3T');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('464', '107', '1', '252', '颜色', '魅海蓝');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('465', '107', '3', '256', '版本', '全网通(4G+64G)');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('466', '108', '1', '260', '颜色', '黑色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('467', '108', '4', '263', '容量', '64GB');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('468', '109', '1', '261', '颜色', '白色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('469', '109', '4', '263', '容量', '64GB');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('470', '110', '1', '260', '颜色', '黑色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('471', '110', '4', '264', '容量', '128GB');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('472', '111', '1', '260', '颜色', '黑色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('473', '111', '4', '265', '容量', '256GB');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('474', '112', '1', '261', '颜色', '白色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('475', '112', '4', '264', '容量', '128GB');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('476', '113', '1', '261', '颜色', '白色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('477', '113', '4', '265', '容量', '256GB');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('478', '114', '1', '262', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('479', '114', '4', '263', '容量', '64GB');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('480', '115', '1', '262', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('481', '115', '4', '264', '容量', '128GB');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('482', '116', '1', '262', '颜色', '红色');
INSERT INTO `pms_sku_sale_attr_value` VALUES ('483', '116', '4', '265', '容量', '256GB');

-- ----------------------------
-- Table structure for `ums_member`
-- ----------------------------
DROP TABLE IF EXISTS `ums_member`;
CREATE TABLE `ums_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_level_id` bigint(20) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `phone` varchar(64) DEFAULT NULL COMMENT '手机号码',
  `status` int(1) DEFAULT NULL COMMENT '帐号启用状态:0->禁用；1->启用',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  `icon` varchar(500) DEFAULT NULL COMMENT '头像',
  `gender` char(1) DEFAULT NULL COMMENT '性别：n->未知；m->男；f->女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `city` varchar(64) DEFAULT NULL COMMENT '所做城市',
  `job` varchar(100) DEFAULT NULL COMMENT '职业',
  `personalized_signature` varchar(200) DEFAULT NULL COMMENT '个性签名',
  `source_type` int(1) DEFAULT NULL COMMENT '用户来源:1-本网站 2-腾讯 3-微信 4-微博 5-百度',
  `source_uid` varchar(255) DEFAULT NULL COMMENT '用户使用社交登录的网站的uid',
  `integration` int(11) DEFAULT NULL COMMENT '积分',
  `growth` int(11) DEFAULT NULL COMMENT '成长值',
  `lucky_count` int(11) DEFAULT NULL COMMENT '剩余抽奖次数',
  `history_integration` int(11) DEFAULT NULL COMMENT '历史积分数量',
  `access_code` varchar(255) DEFAULT 'null' COMMENT '社交登录时获取的授权码码',
  `access_token` varchar(255) DEFAULT NULL COMMENT '用户token',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`),
  UNIQUE KEY `idx_phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of ums_member
-- ----------------------------
INSERT INTO `ums_member` VALUES ('1', '4', 'test', '202cb962ac59075b964b07152d234b70', '小卢', '18061581849', '1', '2018-08-02 10:35:44', null, 'm', '2009-06-01', '上海', '学生', 'test', null, null, '5000', null, null, null, 'null', null);
INSERT INTO `ums_member` VALUES ('3', '4', 'windy', 'e10adc3949ba59abbe56e057f20f883e', 'windy', '18061581848', '1', '2018-08-03 16:46:38', null, null, null, null, null, null, null, null, null, null, null, null, 'null', null);
INSERT INTO `ums_member` VALUES ('4', '4', 'zhengsan', 'e10adc3949ba59abbe56e057f20f883e', 'zhengsan', '18061581847', '1', '2018-11-12 14:12:04', null, null, null, null, null, null, null, null, null, null, null, null, 'null', null);
INSERT INTO `ums_member` VALUES ('5', '4', 'lisi', 'e10adc3949ba59abbe56e057f20f883e', 'lisi', '18061581841', '1', '2018-11-12 14:12:38', null, null, null, null, null, null, null, null, null, null, null, null, 'null', null);
INSERT INTO `ums_member` VALUES ('6', '4', 'wangwu', 'e10adc3949ba59abbe56e057f20f883e', 'wangwu', '18061581842', '1', '2018-11-12 14:13:09', null, null, null, null, null, null, null, null, null, null, null, null, 'null', null);
INSERT INTO `ums_member` VALUES ('7', '4', 'lion', 'e10adc3949ba59abbe56e057f20f883e', 'lion', '18061581845', '1', '2018-11-12 14:21:39', null, null, null, null, null, null, null, null, null, null, null, null, 'null', null);
INSERT INTO `ums_member` VALUES ('8', '4', 'shari', 'e10adc3949ba59abbe56e057f20f883e', 'shari', '18061581844', '1', '2018-11-12 14:22:00', null, null, null, null, null, null, null, null, null, null, null, null, 'null', null);
INSERT INTO `ums_member` VALUES ('9', '4', 'aewen', 'e10adc3949ba59abbe56e057f20f883e', 'aewen', '18061581843', '1', '2018-11-12 14:22:55', null, null, null, null, null, null, null, null, null, null, null, null, 'null', null);
INSERT INTO `ums_member` VALUES ('10', '4', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', null, '17512080612', '1', '2019-03-06 17:51:56', null, null, null, null, null, null, null, null, null, null, null, null, 'null', null);
INSERT INTO `ums_member` VALUES ('17', null, null, null, '啤酒鸭好吃丶', null, null, '2014-10-16 08:38:51', null, 'm', null, '江西', null, null, '4', '5334425717', null, null, null, null, '73c07dcbff1dba7f7e8355528e4bf2da', '2.00TohApFp3UMxBb6ac1fe2c7WxpflC');

-- ----------------------------
-- Table structure for `ums_member_level`
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_level`;
CREATE TABLE `ums_member_level` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `growth_point` int(11) DEFAULT NULL,
  `default_status` int(1) DEFAULT NULL COMMENT '是否为默认等级：0->不是；1->是',
  `free_freight_point` decimal(10,2) DEFAULT NULL COMMENT '免运费标准',
  `comment_growth_point` int(11) DEFAULT NULL COMMENT '每次评价获取的成长值',
  `priviledge_free_freight` int(1) DEFAULT NULL COMMENT '是否有免邮特权',
  `priviledge_sign_in` int(1) DEFAULT NULL COMMENT '是否有签到特权',
  `priviledge_comment` int(1) DEFAULT NULL COMMENT '是否有评论获奖励特权',
  `priviledge_promotion` int(1) DEFAULT NULL COMMENT '是否有专享活动特权',
  `priviledge_member_price` int(1) DEFAULT NULL COMMENT '是否有会员价格特权',
  `priviledge_birthday` int(1) DEFAULT NULL COMMENT '是否有生日特权',
  `note` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='会员等级表';

-- ----------------------------
-- Records of ums_member_level
-- ----------------------------
INSERT INTO `ums_member_level` VALUES ('1', '黄金会员', '1000', '0', '199.00', '5', '1', '1', '1', '1', '1', '1', null);
INSERT INTO `ums_member_level` VALUES ('2', '白金会员', '5000', '0', '99.00', '10', '1', '1', '1', '1', '1', '1', null);
INSERT INTO `ums_member_level` VALUES ('3', '钻石会员', '15000', '0', '69.00', '15', '1', '1', '1', '1', '1', '1', null);
INSERT INTO `ums_member_level` VALUES ('4', '普通会员', '1', '1', '199.00', '20', '1', '1', '1', '1', '0', '0', null);

-- ----------------------------
-- Table structure for `ums_member_receive_address`
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_receive_address`;
CREATE TABLE `ums_member_receive_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '收货人名称',
  `phone_number` varchar(64) DEFAULT NULL,
  `default_status` int(1) DEFAULT NULL COMMENT '是否为默认',
  `post_code` varchar(100) DEFAULT NULL COMMENT '邮政编码',
  `province` varchar(100) DEFAULT NULL COMMENT '省份/直辖市',
  `city` varchar(100) DEFAULT NULL COMMENT '城市',
  `region` varchar(100) DEFAULT NULL COMMENT '区',
  `detail_address` varchar(128) DEFAULT NULL COMMENT '详细地址(街道)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='会员收货地址表';

-- ----------------------------
-- Records of ums_member_receive_address
-- ----------------------------
INSERT INTO `ums_member_receive_address` VALUES ('1', '1', '大梨', '18033441849', '0', '518000', '广东省', '深圳市', '南山区', '科兴科学园');
INSERT INTO `ums_member_receive_address` VALUES ('3', '1', '大梨', '18033441849', '0', '518000', '广东省', '深圳市', '福田区', '清水河街道');
INSERT INTO `ums_member_receive_address` VALUES ('4', '1', '大梨', '18033441849', '1', '518000', '广东省', '深圳市', '福田区', '东晓街道');

-- ----------------------------
-- Table structure for `ware_info`
-- ----------------------------
DROP TABLE IF EXISTS `ware_info`;
CREATE TABLE `ware_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `area_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ware_info
-- ----------------------------
INSERT INTO `ware_info` VALUES ('1', '朝阳1号仓库', '北京', '110000');
INSERT INTO `ware_info` VALUES ('2', '大兴2号仓库', '北京', '110000');
INSERT INTO `ware_info` VALUES ('3', '大兴3号仓库', '京', '123123');
INSERT INTO `ware_info` VALUES ('4', '朝阳2号仓库', '京', '123123');
INSERT INTO `ware_info` VALUES ('5', '朝阳3号仓库', '京', '123123');
INSERT INTO `ware_info` VALUES ('6', '朝41号仓库', '京', '123123');
INSERT INTO `ware_info` VALUES ('7', '朝阳5号仓库', '京', '123123');
INSERT INTO `ware_info` VALUES ('8', '朝阳6号仓库', '京', '123123');

-- ----------------------------
-- Table structure for `ware_order_task`
-- ----------------------------
DROP TABLE IF EXISTS `ware_order_task`;
CREATE TABLE `ware_order_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单编号',
  `consignee` varchar(100) DEFAULT NULL COMMENT '收货人',
  `consignee_tel` varchar(20) DEFAULT NULL COMMENT '收货人电话',
  `delivery_address` varchar(1000) DEFAULT NULL COMMENT '送货地址',
  `order_comment` varchar(200) DEFAULT NULL COMMENT '订单备注',
  `payment_way` varchar(2) DEFAULT NULL COMMENT '付款方式 1:在线付款 2:货到付款',
  `task_status` varchar(20) DEFAULT NULL,
  `order_body` varchar(200) DEFAULT NULL COMMENT '订单描述',
  `tracking_no` varchar(200) DEFAULT NULL COMMENT '物流单号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `ware_id` bigint(20) DEFAULT NULL COMMENT '仓库编号',
  `task_comment` varchar(500) DEFAULT NULL COMMENT '工作单备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8 COMMENT='库存工作单表 库存工作单表';

-- ----------------------------
-- Records of ware_order_task
-- ----------------------------
INSERT INTO `ware_order_task` VALUES ('162', '298', '博哥', '123123123123', '北京市海淀区双榆树东里', null, null, 'DEDUCTED', null, null, '2019-03-22 23:33:22', null, null);
INSERT INTO `ware_order_task` VALUES ('163', '307', '博哥', '123123123123', '北京市海淀区双榆树东里', null, null, 'DEDUCTED', null, null, '2019-03-23 15:44:05', null, null);
INSERT INTO `ware_order_task` VALUES ('164', '308', '博哥', '123123123123', '北京市海淀区双榆树东里', null, null, 'DEDUCTED', null, null, '2019-03-23 15:44:06', null, null);
INSERT INTO `ware_order_task` VALUES ('165', '309', '博哥', '123123123123', '北京市海淀区双榆树东里', null, null, 'DEDUCTED', null, null, '2019-03-23 15:44:06', null, null);
INSERT INTO `ware_order_task` VALUES ('166', '310', '博哥', '123123123123', '北京市海淀区双榆树东里', null, null, 'DEDUCTED', null, null, '2019-03-23 15:44:06', null, null);
INSERT INTO `ware_order_task` VALUES ('167', '311', '博哥', '123123123123', '北京市海淀区双榆树东里', null, null, 'DEDUCTED', null, null, '2019-03-23 16:44:06', null, null);
INSERT INTO `ware_order_task` VALUES ('168', '84', '大梨', '18033441849', '东晓街道', null, null, 'DEDUCTED', null, null, '2020-04-29 22:44:01', null, null);
INSERT INTO `ware_order_task` VALUES ('169', '85', '大梨', '18033441849', '东晓街道', null, null, 'DEDUCTED', null, null, '2020-04-29 23:15:31', null, null);

-- ----------------------------
-- Table structure for `ware_order_task_detail`
-- ----------------------------
DROP TABLE IF EXISTS `ware_order_task_detail`;
CREATE TABLE `ware_order_task_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'sku_id',
  `sku_name` varchar(200) DEFAULT NULL COMMENT 'sku名称',
  `task_id` bigint(20) DEFAULT NULL COMMENT '工作单编号',
  `sku_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=294 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ware_order_task_detail
-- ----------------------------
INSERT INTO `ware_order_task_detail` VALUES ('286', '103', '黑鲨游戏手机Gmall1015系列低配双核版', '162', '1');
INSERT INTO `ware_order_task_detail` VALUES ('287', '103', '黑鲨游戏手机Gmall1015系列低配双核版', '163', '1');
INSERT INTO `ware_order_task_detail` VALUES ('288', '103', '黑鲨游戏手机Gmall1015系列低配双核版', '164', '1');
INSERT INTO `ware_order_task_detail` VALUES ('289', '103', '黑鲨游戏手机Gmall1015系列低配双核版', '165', '1');
INSERT INTO `ware_order_task_detail` VALUES ('290', '103', '黑鲨游戏手机Gmall1015系列低配双核版', '166', '1');
INSERT INTO `ware_order_task_detail` VALUES ('291', '103', '黑鲨游戏手机Gmall1015系列低配双核版', '167', '1');
INSERT INTO `ware_order_task_detail` VALUES ('292', '107', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '168', '2');
INSERT INTO `ware_order_task_detail` VALUES ('293', '107', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '169', '4');

-- ----------------------------
-- Table structure for `ware_sku`
-- ----------------------------
DROP TABLE IF EXISTS `ware_sku`;
CREATE TABLE `ware_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'skuid',
  `warehouse_id` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `stock` int(11) DEFAULT '0' COMMENT '库存数',
  `stock_name` varchar(200) DEFAULT NULL COMMENT '存货名称',
  `stock_locked` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_skuid` (`sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ware_sku
-- ----------------------------
INSERT INTO `ware_sku` VALUES ('9', '80', '2', '10', '测试编号80sku库存', '10');
INSERT INTO `ware_sku` VALUES ('11', '22', '2', '100', '小米美颜', '1');
INSERT INTO `ware_sku` VALUES ('12', '13', '2', '100', '一堆小米6 全网通 6GB+128GB 亮黑色 移动联通电信4G手机 双卡双待', '1');
INSERT INTO `ware_sku` VALUES ('13', '88', '2', '100', '又一联想拯救者', '1');
INSERT INTO `ware_sku` VALUES ('14', '94', '1', '100', '一堆尚硅谷超长待机', '1');
INSERT INTO `ware_sku` VALUES ('15', '85', '6', '10', '进了一批iphoneXs', '2');
INSERT INTO `ware_sku` VALUES ('16', '97', '5', '10', '刚刚进货的iphoneRx一批', '0');
INSERT INTO `ware_sku` VALUES ('18', '95', '4', '10', '一堆尚硅谷无人驾驶手机R720', '3');
INSERT INTO `ware_sku` VALUES ('19', '98', '6', '100', '18年12月21日新入库一堆硅谷gmall0725全面屏游戏智能手机 6GB+64GB 红色 硅谷纪念限量版手机', '3');
INSERT INTO `ware_sku` VALUES ('20', '96', '6', '10', '突然到货一拼商品', '0');
INSERT INTO `ware_sku` VALUES ('21', '96', '1', '10', '突然到货一堆sku96商品手机', '1');
INSERT INTO `ware_sku` VALUES ('22', '100', '1', '100', '一堆尚硅谷游戏机', '1');
INSERT INTO `ware_sku` VALUES ('23', '102', '6', '10', '一堆手机0906系列256G大内存容量版', '1');
INSERT INTO `ware_sku` VALUES ('28', '104', '3', '10', '10台尚硅谷黑鲨系列手机gmall1015', '0');
INSERT INTO `ware_sku` VALUES ('29', '103', '2', '10', '黑纱gmall1015低配版', '5');
INSERT INTO `ware_sku` VALUES ('30', '107', '1', '10', '荣耀9X 麒麟810 4000mAh续航 4800万超清夜拍 6.59英寸升降全面屏 全网通6GB+64GB 魅海蓝 ', '6');
