-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.5.24-log - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla tekcity.ospos_app_config
CREATE TABLE IF NOT EXISTS `ospos_app_config` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_app_config: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_app_config` DISABLE KEYS */;
REPLACE INTO `ospos_app_config` (`key`, `value`) VALUES
	('address', '123 Nowhere street'),
	('company', 'Open Source Point of Sale'),
	('default_tax_rate', '8'),
	('email', 'admin@pappastech.com'),
	('fax', ''),
	('phone', '555-555-5555'),
	('return_policy', 'Test'),
	('timezone', 'America/New_York'),
	('website', '');
/*!40000 ALTER TABLE `ospos_app_config` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_customers
CREATE TABLE IF NOT EXISTS `ospos_customers` (
  `person_id` int(10) NOT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `taxable` int(1) NOT NULL DEFAULT '1',
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_number` (`account_number`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `ospos_customers_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_customers: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_customers` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_employees
CREATE TABLE IF NOT EXISTS `ospos_employees` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `person_id` int(10) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `username` (`username`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `ospos_employees_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_employees: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_employees` DISABLE KEYS */;
REPLACE INTO `ospos_employees` (`username`, `password`, `person_id`, `deleted`) VALUES
	('admin', '439a6de57d475c1a0ba9bcb1c39f0af6', 1, 0);
/*!40000 ALTER TABLE `ospos_employees` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_expenses
CREATE TABLE IF NOT EXISTS `ospos_expenses` (
  `expense_id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_date` date DEFAULT NULL,
  `description` varchar(50) COLLATE latin1_bin NOT NULL,
  `amount` double NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  `image` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`expense_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Volcando datos para la tabla tekcity.ospos_expenses: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_expenses` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_giftcards
CREATE TABLE IF NOT EXISTS `ospos_giftcards` (
  `giftcard_id` int(11) NOT NULL AUTO_INCREMENT,
  `giftcard_number` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `value` double(15,2) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  `person_id` int(11) NOT NULL,
  PRIMARY KEY (`giftcard_id`),
  UNIQUE KEY `giftcard_number` (`giftcard_number`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla tekcity.ospos_giftcards: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_giftcards` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_giftcards` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_inventory
CREATE TABLE IF NOT EXISTS `ospos_inventory` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_items` int(11) NOT NULL DEFAULT '0',
  `trans_user` int(11) NOT NULL DEFAULT '0',
  `trans_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trans_comment` text NOT NULL,
  `trans_inventory` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`trans_id`),
  KEY `ospos_inventory_ibfk_1` (`trans_items`),
  KEY `ospos_inventory_ibfk_2` (`trans_user`),
  CONSTRAINT `ospos_inventory_ibfk_1` FOREIGN KEY (`trans_items`) REFERENCES `ospos_items` (`item_id`),
  CONSTRAINT `ospos_inventory_ibfk_2` FOREIGN KEY (`trans_user`) REFERENCES `ospos_employees` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_inventory: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_inventory` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_items
CREATE TABLE IF NOT EXISTS `ospos_items` (
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `item_number` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `cost_price` double(15,2) NOT NULL,
  `unit_price` double(15,2) NOT NULL,
  `quantity` double(15,2) NOT NULL DEFAULT '0.00',
  `reorder_level` double(15,2) NOT NULL DEFAULT '0.00',
  `location` varchar(255) NOT NULL,
  `item_id` int(10) NOT NULL AUTO_INCREMENT,
  `allow_alt_description` tinyint(1) NOT NULL,
  `is_serialized` tinyint(1) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  `custom1` varchar(25) NOT NULL,
  `custom2` varchar(25) NOT NULL,
  `custom3` varchar(25) NOT NULL,
  `custom4` varchar(25) NOT NULL,
  `custom5` varchar(25) NOT NULL,
  `custom6` varchar(25) NOT NULL,
  `custom7` varchar(25) NOT NULL,
  `custom8` varchar(25) NOT NULL,
  `custom9` varchar(25) NOT NULL,
  `custom10` varchar(25) NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_number` (`item_number`),
  KEY `ospos_items_ibfk_1` (`supplier_id`),
  CONSTRAINT `ospos_items_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `ospos_suppliers` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_items: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_items` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_items_taxes
CREATE TABLE IF NOT EXISTS `ospos_items_taxes` (
  `item_id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `percent` double(15,3) NOT NULL,
  PRIMARY KEY (`item_id`,`name`,`percent`),
  CONSTRAINT `ospos_items_taxes_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_items_taxes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_items_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_items_taxes` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_item_kits
CREATE TABLE IF NOT EXISTS `ospos_item_kits` (
  `item_kit_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`item_kit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_item_kits: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_item_kits` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_item_kits` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_item_kit_items
CREATE TABLE IF NOT EXISTS `ospos_item_kit_items` (
  `item_kit_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` double(15,2) NOT NULL,
  PRIMARY KEY (`item_kit_id`,`item_id`,`quantity`),
  KEY `ospos_item_kit_items_ibfk_2` (`item_id`),
  CONSTRAINT `ospos_item_kit_items_ibfk_1` FOREIGN KEY (`item_kit_id`) REFERENCES `ospos_item_kits` (`item_kit_id`) ON DELETE CASCADE,
  CONSTRAINT `ospos_item_kit_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_item_kit_items: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_item_kit_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_item_kit_items` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_modules
CREATE TABLE IF NOT EXISTS `ospos_modules` (
  `name_lang_key` varchar(255) NOT NULL,
  `desc_lang_key` varchar(255) NOT NULL,
  `sort` int(10) NOT NULL,
  `module_id` varchar(255) NOT NULL,
  PRIMARY KEY (`module_id`),
  UNIQUE KEY `desc_lang_key` (`desc_lang_key`),
  UNIQUE KEY `name_lang_key` (`name_lang_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_modules: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_modules` DISABLE KEYS */;
REPLACE INTO `ospos_modules` (`name_lang_key`, `desc_lang_key`, `sort`, `module_id`) VALUES
	('module_config', 'module_config_desc', 100, 'config'),
	('module_customers', 'module_customers_desc', 10, 'customers'),
	('module_employees', 'module_employees_desc', 80, 'employees'),
	('module_expenses', 'module_expenses_desc', 110, 'expenses'),
	('module_giftcards', 'module_giftcards_desc', 90, 'giftcards'),
	('module_items', 'module_items_desc', 20, 'items'),
	('module_item_kits', 'module_item_kits_desc', 30, 'item_kits'),
	('module_receivings', 'module_receivings_desc', 60, 'receivings'),
	('module_registers', 'module_registers_desc', 120, 'registers'),
	('module_reports', 'module_reports_desc', 50, 'reports'),
	('module_sales', 'module_sales_desc', 70, 'sales'),
	('module_suppliers', 'module_suppliers_desc', 40, 'suppliers');
/*!40000 ALTER TABLE `ospos_modules` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_people
CREATE TABLE IF NOT EXISTS `ospos_people` (
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address_1` varchar(255) NOT NULL,
  `address_2` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `comments` text NOT NULL,
  `person_id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_people: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_people` DISABLE KEYS */;
REPLACE INTO `ospos_people` (`first_name`, `last_name`, `phone_number`, `email`, `address_1`, `address_2`, `city`, `state`, `zip`, `country`, `comments`, `person_id`) VALUES
	('John', 'Doe', '555-555-5555', 'admin@pappastech.com', 'Address 1', '', '', '', '', '', '', 1);
/*!40000 ALTER TABLE `ospos_people` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_permissions
CREATE TABLE IF NOT EXISTS `ospos_permissions` (
  `module_id` varchar(255) NOT NULL,
  `person_id` int(10) NOT NULL,
  PRIMARY KEY (`module_id`,`person_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `ospos_permissions_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_employees` (`person_id`),
  CONSTRAINT `ospos_permissions_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `ospos_modules` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_permissions: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_permissions` DISABLE KEYS */;
REPLACE INTO `ospos_permissions` (`module_id`, `person_id`) VALUES
	('config', 1),
	('customers', 1),
	('employees', 1),
	('expenses', 1),
	('giftcards', 1),
	('items', 1),
	('item_kits', 1),
	('receivings', 1),
	('registers', 1),
	('reports', 1),
	('sales', 1),
	('suppliers', 1);
/*!40000 ALTER TABLE `ospos_permissions` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_receivings
CREATE TABLE IF NOT EXISTS `ospos_receivings` (
  `receiving_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `supplier_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `receiving_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`receiving_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `ospos_receivings_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `ospos_employees` (`person_id`),
  CONSTRAINT `ospos_receivings_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `ospos_suppliers` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_receivings: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_receivings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_receivings` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_receivings_items
CREATE TABLE IF NOT EXISTS `ospos_receivings_items` (
  `receiving_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL,
  `quantity_purchased` int(10) NOT NULL DEFAULT '0',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`receiving_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ospos_receivings_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`),
  CONSTRAINT `ospos_receivings_items_ibfk_2` FOREIGN KEY (`receiving_id`) REFERENCES `ospos_receivings` (`receiving_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_receivings_items: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_receivings_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_receivings_items` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_sales
CREATE TABLE IF NOT EXISTS `ospos_sales` (
  `sale_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `sale_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `ospos_sales_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `ospos_employees` (`person_id`),
  CONSTRAINT `ospos_sales_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `ospos_customers` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_sales: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_sales` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_sales_items
CREATE TABLE IF NOT EXISTS `ospos_sales_items` (
  `sale_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `quantity_purchased` double(15,2) NOT NULL DEFAULT '0.00',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sale_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ospos_sales_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`),
  CONSTRAINT `ospos_sales_items_ibfk_2` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_sales_items: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_sales_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_sales_items` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_sales_items_taxes
CREATE TABLE IF NOT EXISTS `ospos_sales_items_taxes` (
  `sale_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `percent` double(15,3) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`,`name`,`percent`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ospos_sales_items_taxes_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_items` (`sale_id`),
  CONSTRAINT `ospos_sales_items_taxes_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_sales_items_taxes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_sales_items_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_sales_items_taxes` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_sales_payments
CREATE TABLE IF NOT EXISTS `ospos_sales_payments` (
  `sale_id` int(10) NOT NULL,
  `payment_type` varchar(40) NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`),
  CONSTRAINT `ospos_sales_payments_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_sales_payments: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_sales_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_sales_payments` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_sales_suspended
CREATE TABLE IF NOT EXISTS `ospos_sales_suspended` (
  `sale_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `sale_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `ospos_sales_suspended_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `ospos_employees` (`person_id`),
  CONSTRAINT `ospos_sales_suspended_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `ospos_customers` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_sales_suspended: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_sales_suspended` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_sales_suspended` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_sales_suspended_items
CREATE TABLE IF NOT EXISTS `ospos_sales_suspended_items` (
  `sale_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `quantity_purchased` double(15,2) NOT NULL DEFAULT '0.00',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sale_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ospos_sales_suspended_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`),
  CONSTRAINT `ospos_sales_suspended_items_ibfk_2` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_suspended` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_sales_suspended_items: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_sales_suspended_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_sales_suspended_items` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_sales_suspended_items_taxes
CREATE TABLE IF NOT EXISTS `ospos_sales_suspended_items_taxes` (
  `sale_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `percent` double(15,3) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`,`name`,`percent`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ospos_sales_suspended_items_taxes_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_suspended_items` (`sale_id`),
  CONSTRAINT `ospos_sales_suspended_items_taxes_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `ospos_items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_sales_suspended_items_taxes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_sales_suspended_items_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_sales_suspended_items_taxes` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_sales_suspended_payments
CREATE TABLE IF NOT EXISTS `ospos_sales_suspended_payments` (
  `sale_id` int(10) NOT NULL,
  `payment_type` varchar(40) NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`),
  CONSTRAINT `ospos_sales_suspended_payments_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `ospos_sales_suspended` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_sales_suspended_payments: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_sales_suspended_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_sales_suspended_payments` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_sessions
CREATE TABLE IF NOT EXISTS `ospos_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_sessions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_sessions` ENABLE KEYS */;


-- Volcando estructura para tabla tekcity.ospos_suppliers
CREATE TABLE IF NOT EXISTS `ospos_suppliers` (
  `person_id` int(10) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_number` (`account_number`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `ospos_suppliers_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ospos_people` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla tekcity.ospos_suppliers: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ospos_suppliers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ospos_suppliers` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
