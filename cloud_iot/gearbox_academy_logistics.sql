-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 20, 2022 at 02:03 PM
-- Server version: 8.0.28-0ubuntu0.20.04.3
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gearbox_academy_logistics`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `second_name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `first_name`, `second_name`, `email`, `password`) VALUES
(1, 'Ephy', 'Ngugi', 'admin@gmail.com', 'admin'),
(2, 'Foo', 'bar', 'foo@gmail.com', 'foobar');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `item_id`, `quantity`) VALUES
(74, 10, 2, 1),
(78, 12, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `shelf` int NOT NULL,
  `drawer` int NOT NULL,
  `quantity` int NOT NULL,
  `description` varchar(100) NOT NULL,
  `external_link` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `image`, `shelf`, `drawer`, `quantity`, `description`, `external_link`) VALUES
(2, 'resistor', 'items/resistors-fg.jpeg', 1, 2, 999, '', '33'),
(8, 'keypad', 'items/keypad-8456845.jpeg', 1, 2, 9, '', ''),
(9, 'led', 'items/led-8945.jpeg', 1, 1, 999, '', ''),
(10, '8 x 8 led matrix', 'items/8 x 8 led matrix-5848.jpeg', 2, 1, 12, '', ''),
(11, 'lcd display', 'items/lcd display-5455485.jpeg', 5, 1, 3, '', ''),
(12, '7 segment display', 'items/7 segment display-rewtyui.jpeg', 2, 1, 10, '', ''),
(13, 'potentiometer', 'items/potentiometer-4516584.jpeg', 2, 1, 1, '', ''),
(14, 'piezo', 'items/piezo-54.jpeg', 1, 2, 10, '', ''),
(15, 'capacitor', 'items/capacitor-84584.jpeg', 1, 2, 1, '', ''),
(16, 'diode', 'items/diode-894515.jpeg', 2, 1, 10, '', ''),
(17, 'zener diode', 'items/zener diode-84554.jpeg', 2, 1, 3, '', ''),
(18, 'Ruler', 'items/Ruler-ruler.jpg', 1, 3, 10, '', ''),
(19, 'Sticky notes', 'items/Sticky notes-sticky notes.jpg', 1, 3, 77, '', ''),
(20, 'Goggles', 'items/Goggles-goggles.jpg', 1, 3, 7, '', ''),
(21, 'Scissors', 'items/Scissors-scissors.jpg', 1, 3, 4, '', ''),
(22, 'White board marker', 'items/White board marker-whiteboardmarker.jpg', 1, 3, 24, '', ''),
(23, 'Modelling clay', 'items/Modelling clay-modellingclay.jpg', 1, 3, 5, '', ''),
(24, 'Tape', 'items/Tape-tape.jpg', 1, 3, 1, '', ''),
(25, 'Reflectors', 'items/Reflectors-reflector.jpg', 1, 3, 7, '', ''),
(26, 'Dust coat', 'items/Dust coat-dust coat.jpg', 1, 3, 2, '', ''),
(27, 'Furniture lock', 'items/Furniture lock-lockjpg', 1, 3, 3, '', ''),
(28, 'cotton rope', 'items/cotton rope-white-cotton-rope-15mm-50m.jpg', 1, 3, 5, 'white cotton rope', ''),
(29, 'Battery holder', 'items/Battery holder-holder.jpeg', 1, 3, 10, '', ''),
(30, 'Battery pack', 'items/Battery pack-9-volt-battery-pack_1.jpg', 1, 3, 2, '9 V', ''),
(31, 'Battery AA', 'items/Battery AA-AA.jpeg', 1, 3, 23, '', ''),
(32, 'Rechargeable battery', 'profile.jpg', 1, 3, 3, '', ''),
(33, 'Battery AAA', 'items/Battery AAA-duracell-aaa-battery-500x500.jpg', 1, 3, 6, '', ''),
(34, 'CNC shield', 'items/CNC shield-CNC.jpeg', 1, 2, 2, '', ''),
(35, 'Step motor', 'items/Step motor-STEPjpeg', 1, 2, 15, '', ''),
(37, 'Copper board', 'items/Copper board-1441635540187.jpg', 1, 2, 8, '', ''),
(38, 'Bread board', 'items/Bread board-OIP.jfif', 1, 2, 7, '', ''),
(39, 'Arduino Shield', 'items/Arduino Shield-R.jfif', 1, 2, 3, '', ''),
(40, 'Arduino nano', 'items/Arduino nano-OIP (1).jfif', 1, 2, 1, '', ''),
(41, 'Button switch', 'items/Button switch-R (1).jfif', 1, 2, 1, '', ''),
(42, 'Jumper wires', 'items/Jumper wires-R (2).jfif', 1, 2, 988, '', ''),
(43, 'Potentiometer', 'items/Potentiometer-01-28.jpg', 1, 2, 2, '', ''),
(44, 'Trimmer potentiometer', 'items/Trimmer potentiometer-download (1).jfif', 1, 2, 6, '', ''),
(45, 'Power transistor', 'items/Power transistor-OIP (2).jfif', 1, 2, 4, '', ''),
(47, 'Temperature and humidity sensor', 'items/Temperature and humidity sensor-OIP (3).jfif', 1, 2, 6, '', ''),
(48, 'Photo sensor', 'profile.jpg', 1, 2, 10, '', ''),
(49, 'Touch sensor', 'items/Touch sensor-TOUCH.jpg', 1, 2, 5, '', ''),
(50, 'Magnetic sensor module', 'items/Magnetic sensor module-F.jpg', 1, 2, 2, '', ''),
(51, 'Photo diode', 'items/Photo diode-PHOTO.jpeg', 1, 2, 8, '', ''),
(52, 'IR receiver', 'items/IR receiver-IR.jpeg', 1, 2, 4, '', ''),
(53, 'Real time clock (RTC)', 'items/Real time clock (RTC)-download.jpeg', 1, 2, 10, '', ''),
(54, 'Hall effect sensor', 'items/Hall effect sensor-HALL.jpeg', 1, 2, 2, '', ''),
(56, 'Battery shield', 'profile.jpg', 1, 2, 1, '', ''),
(57, 'MQ -2 gas sensor', 'profile.jpg', 1, 2, 2, '', ''),
(58, 'Limit switch', 'items/Limit switch-limit switch.jpg', 1, 2, 1, '', ''),
(59, 'LM35 Temperature sensor', 'items/LM35 Temperature sensor-lm sth.jpg', 1, 2, 2, '', ''),
(60, 'Accelerometer MPU6050', 'profile.jpg', 1, 2, 3, '', ''),
(61, 'Logic level shifter', 'profile.jpg', 1, 2, 1, '', ''),
(62, 'Radio transmitter 433MHz', 'profile.jpg', 1, 2, 3, '', ''),
(63, 'Radio receiver 433MGz', 'profile.jpg', 1, 2, 2, '', ''),
(64, 'Rotary encoder', 'profile.jpg', 1, 2, 1, '', ''),
(65, 'Moisture sensor', 'profile.jpg', 1, 2, 6, '', ''),
(66, 'SD card modules', 'profile.jpg', 1, 2, 2, '', ''),
(67, 'ICs', 'profile.jpg', 1, 2, 30, '', ''),
(68, 'Joystick', 'profile.jpg', 1, 2, 10, '', ''),
(69, 'RFID', 'profile.jpg', 1, 2, 5, '', ''),
(70, 'Relay', 'profile.jpg', 1, 2, 9, '', ''),
(71, 'Light cup', 'profile.jpg', 1, 2, 2, '', ''),
(72, 'Analogue hall', 'profile.jpg', 1, 2, 2, '', ''),
(73, 'SMD RGB', 'profile.jpg', 1, 2, 2, '\r\n', ''),
(74, 'Mini read', 'profile.jpg', 1, 2, 1, '', ''),
(75, 'Light blocking', 'profile.jpg', 1, 2, 1, '', ''),
(76, 'Ball switch', 'profile.jpg', 1, 2, 1, '', ''),
(77, 'Tap module', 'profile.jpg', 1, 2, 2, '', ''),
(78, 'RGB LED', 'profile.jpg', 1, 2, 1, '', ''),
(79, 'Heartbeat sensor', 'profile.jpg', 1, 2, 2, '', ''),
(80, 'Tracking', 'profile.jpg', 1, 2, 2, '', ''),
(81, 'Read switch', 'profile.jpg', 1, 2, 1, '', ''),
(82, 'Touch', 'profile.jpg', 1, 2, 2, '', ''),
(83, 'Read switch', 'profile.jpg', 1, 2, 1, '', ''),
(84, 'Small sound', 'profile.jpg', 1, 2, 1, '', ''),
(86, 'Linear hall', 'profile.jpg', 1, 2, 1, '', ''),
(87, 'Two color LED', 'profile.jpg', 1, 2, 1, '', ''),
(88, 'Stepper motor driver', 'profile.jpg', 1, 2, 11, '', ''),
(89, 'Heart rate monitor', 'profile.jpg', 1, 2, 1, '', ''),
(90, 'Easy driver', 'profile.jpg', 1, 2, 3, '', ''),
(91, 'Pilot lamb LED', 'profile.jpg', 1, 2, 1, '', ''),
(92, 'Power supply module', 'profile.jpg', 1, 2, 3, '', ''),
(93, 'Switch mode buck converter', 'profile.jpg', 1, 2, 2, '', ''),
(94, 'Glue sticks', 'profile.jpg', 1, 2, 8, '', ''),
(95, 'Switch mode buck converter', 'profile.jpg', 1, 2, 2, '', ''),
(96, 'Arduino cable', 'profile.jpg', 1, 2, 2, '', ''),
(97, 'Starter kit', 'profile.jpg', 2, 3, 25, '', ''),
(98, 'Multimeter', 'profile.jpg', 2, 2, 3, '', ''),
(99, 'Power supply', 'profile.jpg', 2, 2, 3, '', ''),
(100, 'Digital oscilloscope', 'profile.jpg', 3, 1, 1, '', ''),
(101, 'Generator', 'profile.jpg', 3, 1, 1, '', ''),
(102, 'Charging deck', 'profile.jpg', 3, 3, 1, '', ''),
(103, 'Hot glue gun', 'profile.jpg', 4, 1, 3, '', ''),
(104, 'Stepper motor 17HS4401', 'profile.jpg', 4, 1, 1, '', ''),
(105, 'Pliers', 'profile.jpg', 4, 1, 1, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `user_id`, `item_id`, `quantity`, `date_time`) VALUES
(1, 1, 8, 1, '2022-01-13 21:41:51'),
(2, 1, 2, 1, '2022-01-14 21:41:56'),
(3, 1, 8, 1, '2022-01-14 21:43:46'),
(4, 1, 2, 1, '2022-01-14 21:43:46'),
(5, 1, 2, 1, '2022-01-11 21:44:34'),
(6, 1, 15, 1, '2022-01-13 10:38:12'),
(7, 1, 9, 1, '2022-01-13 10:38:22'),
(8, 1, 13, 4, '2022-01-15 11:45:36'),
(9, 1, 11, 1, '2022-01-15 11:45:36'),
(10, 1, 10, 3, '2022-01-15 11:45:36'),
(11, 1, 17, 1, '2022-01-15 12:46:42'),
(12, 1, 2, 1, '2022-01-15 12:46:42'),
(13, 1, 15, 10, '2022-01-15 13:20:21'),
(14, 1, 10, 4, '2022-01-15 13:20:21'),
(15, 1, 12, 1, '2022-01-15 18:15:12'),
(16, 1, 10, 1, '2022-01-15 18:15:12'),
(17, 1, 9, 1, '2022-01-15 18:15:12'),
(18, 1, 8, 1, '2022-01-15 18:15:12'),
(19, 1, 2, 1, '2022-01-15 18:15:12'),
(20, 1, 12, 1, '2022-01-15 18:15:14'),
(21, 1, 10, 1, '2022-01-15 18:15:14'),
(22, 1, 9, 1, '2022-01-15 18:15:14'),
(23, 1, 8, 1, '2022-01-15 18:15:14'),
(24, 1, 2, 1, '2022-01-15 18:15:14'),
(25, 1, 12, 1, '2022-01-15 18:15:15'),
(26, 1, 10, 1, '2022-01-15 18:15:15'),
(27, 1, 9, 1, '2022-01-15 18:15:15'),
(28, 1, 8, 1, '2022-01-15 18:15:15'),
(29, 1, 2, 1, '2022-01-15 18:15:15'),
(30, 1, 12, 1, '2022-01-15 18:15:16'),
(31, 1, 10, 1, '2022-01-15 18:15:16'),
(32, 1, 9, 1, '2022-01-15 18:15:16'),
(33, 1, 8, 1, '2022-01-15 18:15:16'),
(34, 1, 2, 1, '2022-01-15 18:15:16'),
(35, 1, 12, 1, '2022-01-15 18:15:16'),
(36, 1, 10, 1, '2022-01-15 18:15:16'),
(37, 1, 9, 1, '2022-01-15 18:15:16'),
(38, 1, 8, 1, '2022-01-15 18:15:16'),
(39, 1, 2, 1, '2022-01-15 18:15:17'),
(40, 1, 12, 1, '2022-01-15 18:15:17'),
(41, 1, 10, 1, '2022-01-15 18:15:17'),
(42, 1, 9, 1, '2022-01-15 18:15:17'),
(43, 1, 8, 1, '2022-01-15 18:15:17'),
(44, 1, 2, 1, '2022-01-15 18:15:17'),
(45, 1, 12, 1, '2022-01-15 18:15:18'),
(46, 1, 10, 1, '2022-01-15 18:15:18'),
(47, 1, 9, 1, '2022-01-15 18:15:18'),
(48, 1, 8, 1, '2022-01-15 18:15:18'),
(49, 1, 2, 1, '2022-01-15 18:15:18'),
(50, 1, 12, 1, '2022-01-15 18:15:18'),
(51, 1, 10, 1, '2022-01-15 18:15:18'),
(52, 1, 9, 1, '2022-01-15 18:15:18'),
(53, 1, 8, 1, '2022-01-15 18:15:18'),
(54, 1, 2, 1, '2022-01-15 18:15:18'),
(55, 1, 10, 1, '2022-01-15 18:17:31'),
(56, 1, 9, 1, '2022-01-15 18:17:31'),
(57, 1, 10, 1, '2022-01-15 18:20:01'),
(58, 1, 9, 1, '2022-01-15 18:20:01'),
(59, 1, 10, 1, '2022-01-15 18:20:02'),
(60, 1, 9, 1, '2022-01-15 18:20:02'),
(61, 1, 10, 1, '2022-01-15 18:20:02'),
(62, 1, 9, 1, '2022-01-15 18:20:02'),
(63, 1, 9, 1, '2022-01-15 18:40:23'),
(64, 1, 9, 1, '2022-01-15 18:40:40'),
(65, 1, 13, 1, '2022-01-15 18:41:02'),
(66, 1, 12, 1, '2022-01-15 18:41:02'),
(67, 1, 11, 1, '2022-01-15 18:41:02'),
(68, 1, 13, 1, '2022-01-15 18:43:02'),
(69, 1, 12, 1, '2022-01-15 18:43:02'),
(70, 1, 11, 1, '2022-01-15 18:43:02'),
(71, 1, 10, 1, '2022-01-15 18:43:02'),
(72, 1, 10, 1, '2022-01-15 18:43:02'),
(73, 1, 9, 1, '2022-01-15 18:43:02'),
(74, 1, 8, 1, '2022-01-15 18:43:02'),
(75, 1, 8, 1, '2022-01-15 18:43:02'),
(76, 1, 2, 1, '2022-01-15 18:43:02'),
(77, 1, 2, 1, '2022-01-15 18:43:02'),
(78, 1, 13, 1, '2022-01-15 18:48:13'),
(79, 1, 12, 1, '2022-01-15 18:48:13'),
(80, 1, 11, 1, '2022-01-15 18:48:13'),
(81, 1, 10, 1, '2022-01-15 18:48:13'),
(82, 1, 10, 1, '2022-01-15 18:48:13'),
(83, 1, 9, 1, '2022-01-15 18:48:13'),
(84, 1, 8, 1, '2022-01-15 18:48:13'),
(85, 1, 8, 1, '2022-01-15 18:48:13'),
(86, 1, 2, 1, '2022-01-15 18:48:13'),
(87, 1, 2, 1, '2022-01-15 18:48:13'),
(88, 1, 17, 1, '2022-01-17 06:49:21'),
(89, 1, 9, 1, '2022-01-17 10:28:25'),
(90, 1, 8, 1, '2022-01-17 10:28:25'),
(91, 1, 10, 1, '2022-01-17 12:05:25'),
(92, 1, 9, 1, '2022-01-17 12:05:25'),
(93, 1, 8, 1, '2022-01-17 12:05:25'),
(94, 1, 15, 4, '2022-01-17 12:17:01'),
(95, 1, 16, 1, '2022-01-18 07:43:33'),
(96, 1, 2, 1, '2022-01-18 07:43:33'),
(97, 1, 16, 1, '2022-01-18 07:43:35'),
(98, 1, 2, 1, '2022-01-18 07:43:35'),
(99, 1, 16, 1, '2022-01-18 07:43:37'),
(100, 1, 2, 1, '2022-01-18 07:43:37'),
(101, 1, 16, 1, '2022-01-18 07:43:38'),
(102, 1, 2, 1, '2022-01-18 07:43:38'),
(103, 1, 16, 1, '2022-01-18 07:43:39'),
(104, 1, 2, 1, '2022-01-18 07:43:39'),
(105, 9, 2, 1, '2022-01-18 07:43:56'),
(106, 1, 8, 1, '2022-01-18 07:44:10'),
(107, 1, 2, 1, '2022-01-18 07:44:10'),
(108, 1, 16, 1, '2022-01-18 07:44:20'),
(109, 1, 2, 1, '2022-01-18 07:44:20'),
(110, 1, 16, 1, '2022-01-18 07:44:46'),
(111, 1, 2, 5, '2022-01-18 07:44:46'),
(112, 1, 8, 9, '2022-01-18 07:45:33'),
(113, 1, 2, 6, '2022-01-18 07:45:33'),
(114, 1, 8, 9, '2022-01-18 07:45:33'),
(115, 1, 2, 6, '2022-01-18 07:45:33'),
(116, 9, 9, 1, '2022-01-18 07:47:01'),
(117, 9, 8, 1, '2022-01-18 07:47:01'),
(118, 1, 8, 1, '2022-01-18 08:27:08'),
(119, 1, 8, 1, '2022-01-18 08:27:08'),
(120, 1, 2, 1, '2022-01-18 08:27:08'),
(121, 1, 8, 1, '2022-01-18 08:48:25'),
(122, 1, 2, 1, '2022-01-18 08:48:25'),
(123, 1, 9, 1, '2022-03-10 09:20:26'),
(124, 1, 8, 1, '2022-03-10 09:20:26'),
(125, 1, 2, 1, '2022-03-10 09:20:26'),
(126, 1, 51, 1, '2022-03-10 09:21:52'),
(127, 1, 17, 1, '2022-03-10 09:21:52'),
(128, 1, 8, 1, '2022-03-31 11:29:36'),
(129, 1, 2, 1, '2022-03-31 11:29:36'),
(130, 1, 101, 1, '2022-03-31 11:30:25'),
(131, 1, 10, 1, '2022-03-31 11:30:25'),
(132, 1, 2, 1, '2022-03-31 11:30:25');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `second_name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mobile` varchar(20) CHARACTER SET utf8mb4  DEFAULT '',
  `profile_pic` varchar(200) CHARACTER SET utf8mb4  NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `second_name`, `email`, `mobile`, `profile_pic`, `password`) VALUES
(1, 'ruth', 'doe', 'ruthdoe@gmail.com', '4', 'users/doe-0.jpg', '$2b$12$fhr84rtCy7rN3nRz1xzYK.Vv2gtLzs8RZ3lIICFI8HKAd09zNFMwO'),
(3, 'foo', 'bar', 'foo@gmail.com', '', 'profile.jpg', 'foo'),
(4, 'james', 'mumo', 'jmumo@gmail.com', '', 'profile.jpg', 'james'),
(8, 'f', 'm', 'f@gmail.com', '1', 'users/m-closet-svgrepo-com.svg', '$2b$12$fhr84rtCy7rN3nRz1xzYK.Vv2gtLzs8RZ3lIICFI8HKAd09zNFMwO'),
(9, 'Bowen', 'Sitati', 'boensitati@gmail.com', '+254716948526', 'profile.jpg', '$2b$12$MAUFRqgUoM42E4cq0ocm6uA.koFfVgXU2uNUWKmRAN600cFJAQ0La'),
(10, 'vee', 'Matei', 'veepeeghdsjh@gmail.com', '0742344557', 'users/Matei-chess.jpg', '$2b$12$Csvi697bVJ4JB3xr8Txddu/K5ik7f5d9Gur3YIAWCWODtdCzAgaYy'),
(12, 'Wise', 'Mercy', 'wise_mercy@yahoo.com', '3055550174', 'profile.jpg', '$2b$12$dNCOWPs4dt67IzeF2/ECJupnWQ11feZ71pVbXrPS4R3Gu3WlUwUYS');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;