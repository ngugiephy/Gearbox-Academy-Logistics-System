-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 14, 2022 at 10:43 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Logistics gearbox`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `second_name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `shelf` int(11) NOT NULL,
  `drawer` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  `external_link` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `image`, `shelf`, `drawer`, `quantity`, `description`, `external_link`) VALUES
(2, 'resistor', 'items/resistors-fg.jpeg', 2, 3, 23, '23', '33'),
(8, 'keypad', 'items/keypad-8456845.jpeg', 2, 2, 2, '', ''),
(9, 'led', 'items/led-8945.jpeg', 3, 1, 10, '', ''),
(10, '8 x 8 led matrix', 'items/8 x 8 led matrix-5848.jpeg', 2, 1, 12, '', ''),
(11, 'lcd display', 'items/lcd display-5455485.jpeg', 5, 1, 3, '', ''),
(12, '7 segment display', 'items/7 segment display-rewtyui.jpeg', 2, 1, 10, '', ''),
(13, 'potentiometer', 'items/potentiometer-4516584.jpeg', 2, 1, 1, '', ''),
(14, 'piezo', 'items/piezo-54.jpeg', 1, 2, 10, '', ''),
(15, 'capacitor', 'items/capacitor-84584.jpeg', 1, 2, 1, '', ''),
(16, 'diode', 'items/diode-894515.jpeg', 2, 1, 10, '', ''),
(17, 'zener diode', 'items/zener diode-84554.jpeg', 2, 1, 3, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `user_id`, `item_id`, `quantity`, `date_time`) VALUES
(1, 1, 8, 1, '2022-01-14 21:41:51'),
(2, 1, 2, 1, '2022-01-14 21:41:56'),
(3, 1, 8, 1, '2022-01-14 21:43:46'),
(4, 1, 2, 1, '2022-01-14 21:43:46'),
(5, 1, 16, 1, '2022-01-14 21:44:34'),
(6, 1, 15, 1, '2022-01-14 21:44:34'),
(7, 1, 9, 1, '2022-01-14 21:44:34'),
(8, 9, 10, 1, '2022-04-14 07:31:46'),
(9, 9, 9, 1, '2022-04-14 07:31:46'),
(10, 9, 8, 1, '2022-04-14 07:31:46'),
(11, 9, 2, 1, '2022-04-14 07:31:46'),
(12, 9, 10, 1, '2022-04-14 07:31:47'),
(13, 9, 9, 1, '2022-04-14 07:31:47'),
(14, 9, 8, 1, '2022-04-14 07:31:47'),
(15, 9, 2, 1, '2022-04-14 07:31:47'),
(16, 9, 10, 1, '2022-04-14 07:31:47'),
(17, 9, 9, 1, '2022-04-14 07:31:47'),
(18, 9, 8, 1, '2022-04-14 07:31:47'),
(19, 9, 2, 1, '2022-04-14 07:31:47'),
(20, 9, 10, 1, '2022-04-14 07:42:00'),
(21, 9, 9, 1, '2022-04-14 07:42:00'),
(22, 9, 8, 1, '2022-04-14 07:42:00'),
(23, 9, 2, 1, '2022-04-14 07:42:00'),
(24, 9, 11, 1, '2022-04-14 07:51:48'),
(25, 9, 10, 1, '2022-04-14 07:51:48'),
(26, 9, 9, 1, '2022-04-14 07:51:48'),
(27, 9, 8, 1, '2022-04-14 07:51:48'),
(28, 9, 2, 1, '2022-04-14 07:51:48'),
(29, 9, 11, 1, '2022-04-14 07:51:50'),
(30, 9, 10, 1, '2022-04-14 07:51:50'),
(31, 9, 9, 1, '2022-04-14 07:51:50'),
(32, 9, 8, 1, '2022-04-14 07:51:50'),
(33, 9, 2, 1, '2022-04-14 07:51:50'),
(34, 9, 11, 1, '2022-04-14 07:51:50'),
(35, 9, 10, 1, '2022-04-14 07:51:50'),
(36, 9, 9, 1, '2022-04-14 07:51:50'),
(37, 9, 8, 1, '2022-04-14 07:51:50'),
(38, 9, 2, 1, '2022-04-14 07:51:50'),
(39, 9, 11, 1, '2022-04-14 07:51:51'),
(40, 9, 10, 1, '2022-04-14 07:51:51'),
(41, 9, 9, 1, '2022-04-14 07:51:51'),
(42, 9, 8, 1, '2022-04-14 07:51:51'),
(43, 9, 2, 1, '2022-04-14 07:51:51'),
(44, 9, 11, 1, '2022-04-14 07:51:51'),
(45, 9, 10, 1, '2022-04-14 07:51:51'),
(46, 9, 9, 1, '2022-04-14 07:51:51'),
(47, 9, 8, 1, '2022-04-14 07:51:51'),
(48, 9, 2, 1, '2022-04-14 07:51:51'),
(49, 9, 11, 1, '2022-04-14 07:51:54'),
(50, 9, 10, 1, '2022-04-14 07:51:54'),
(51, 9, 9, 1, '2022-04-14 07:51:54'),
(52, 9, 8, 1, '2022-04-14 07:51:54'),
(53, 9, 2, 1, '2022-04-14 07:51:54'),
(54, 9, 11, 1, '2022-04-14 07:51:54'),
(55, 9, 10, 1, '2022-04-14 07:51:54'),
(56, 9, 9, 1, '2022-04-14 07:51:54'),
(57, 9, 8, 1, '2022-04-14 07:51:54'),
(58, 9, 2, 1, '2022-04-14 07:51:54'),
(59, 9, 11, 1, '2022-04-14 07:52:51'),
(60, 9, 10, 1, '2022-04-14 07:52:51'),
(61, 9, 9, 1, '2022-04-14 07:52:51'),
(62, 9, 8, 1, '2022-04-14 07:52:51'),
(63, 9, 2, 1, '2022-04-14 07:52:51'),
(64, 9, 14, 1, '2022-04-14 07:54:39'),
(65, 9, 14, 1, '2022-04-14 07:54:42'),
(66, 9, 14, 1, '2022-04-14 08:01:53'),
(67, 9, 14, 1, '2022-04-14 08:01:53'),
(68, 9, 14, 1, '2022-04-14 08:01:54'),
(69, 9, 14, 1, '2022-04-14 08:10:10'),
(70, 9, 12, 1, '2022-04-14 08:10:10'),
(71, 9, 13, 1, '2022-04-14 08:10:10'),
(72, 9, 10, 1, '2022-04-14 08:10:10'),
(73, 9, 9, 1, '2022-04-14 08:10:10'),
(74, 9, 8, 1, '2022-04-14 08:10:10'),
(75, 9, 2, 1, '2022-04-14 08:10:10'),
(76, 9, 13, 1, '2022-04-14 08:19:40'),
(77, 9, 12, 1, '2022-04-14 08:19:40'),
(78, 9, 11, 1, '2022-04-14 08:19:40'),
(79, 9, 10, 1, '2022-04-14 08:19:40'),
(80, 9, 9, 1, '2022-04-14 08:19:40'),
(81, 9, 8, 1, '2022-04-14 08:19:40'),
(82, 9, 2, 1, '2022-04-14 08:19:40'),
(83, 9, 13, 1, '2022-04-14 08:19:40'),
(84, 9, 12, 1, '2022-04-14 08:19:40'),
(85, 9, 11, 1, '2022-04-14 08:19:40'),
(86, 9, 10, 1, '2022-04-14 08:19:40'),
(87, 9, 9, 1, '2022-04-14 08:19:40'),
(88, 9, 8, 1, '2022-04-14 08:19:40'),
(89, 9, 2, 1, '2022-04-14 08:19:41'),
(90, 9, 13, 1, '2022-04-14 08:26:52'),
(91, 9, 12, 1, '2022-04-14 08:26:52'),
(92, 9, 11, 1, '2022-04-14 08:26:52'),
(93, 9, 10, 1, '2022-04-14 08:26:52'),
(94, 9, 9, 1, '2022-04-14 08:26:52'),
(95, 9, 8, 1, '2022-04-14 08:26:52'),
(96, 9, 2, 1, '2022-04-14 08:26:52'),
(97, 9, 13, 1, '2022-04-14 08:27:21'),
(98, 9, 12, 1, '2022-04-14 08:27:21'),
(99, 9, 11, 1, '2022-04-14 08:27:21'),
(100, 9, 10, 1, '2022-04-14 08:27:21'),
(101, 9, 9, 1, '2022-04-14 08:27:21'),
(102, 9, 8, 1, '2022-04-14 08:27:21'),
(103, 9, 2, 1, '2022-04-14 08:27:21'),
(104, 9, 13, 1, '2022-04-14 08:27:21'),
(105, 9, 12, 1, '2022-04-14 08:27:21'),
(106, 9, 11, 1, '2022-04-14 08:27:21'),
(107, 9, 10, 1, '2022-04-14 08:27:21'),
(108, 9, 9, 1, '2022-04-14 08:27:21'),
(109, 9, 8, 1, '2022-04-14 08:27:21'),
(110, 9, 2, 1, '2022-04-14 08:27:21'),
(111, 9, 12, 1, '2022-04-14 08:27:55'),
(112, 9, 12, 1, '2022-04-14 08:28:25'),
(113, 9, 16, 1, '2022-04-14 08:28:54'),
(114, 9, 16, 1, '2022-04-14 08:29:06'),
(115, 9, 16, 1, '2022-04-14 08:29:06'),
(116, 9, 16, 1, '2022-04-14 08:29:06'),
(117, 9, 10, 1, '2022-04-14 08:29:38'),
(118, 9, 9, 1, '2022-04-14 08:29:38'),
(119, 9, 8, 1, '2022-04-14 08:29:38'),
(120, 9, 2, 1, '2022-04-14 08:29:38'),
(121, 9, 10, 1, '2022-04-14 08:31:45'),
(122, 9, 9, 1, '2022-04-14 08:31:45'),
(123, 9, 8, 1, '2022-04-14 08:31:45'),
(124, 9, 2, 1, '2022-04-14 08:31:45'),
(125, 9, 10, 1, '2022-04-14 08:31:46'),
(126, 9, 9, 1, '2022-04-14 08:31:46'),
(127, 9, 8, 1, '2022-04-14 08:31:46'),
(128, 9, 2, 1, '2022-04-14 08:31:46'),
(129, 9, 11, 1, '2022-04-14 08:32:33'),
(130, 9, 10, 1, '2022-04-14 08:32:33'),
(131, 9, 9, 1, '2022-04-14 08:32:33'),
(132, 9, 8, 1, '2022-04-14 08:32:33'),
(133, 9, 2, 1, '2022-04-14 08:32:33'),
(134, 9, 11, 1, '2022-04-14 08:32:34'),
(135, 9, 10, 1, '2022-04-14 08:32:34'),
(136, 9, 9, 1, '2022-04-14 08:32:34'),
(137, 9, 8, 1, '2022-04-14 08:32:34'),
(138, 9, 2, 1, '2022-04-14 08:32:34');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `second_name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `profile_pic` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `second_name`, `email`, `mobile`, `profile_pic`, `password`) VALUES
(8, 'ruth', 'doe', 'ruthdoe@gmail.com', '07451258322', 'profile.jpg', '$2b$12$gD.Q9Cy/FZHsqgfU.Kj24uzoWNVP1kZD76218UW1m/FrbvVfxMEMu'),
(9, 'swafa', 'swafa', 'swafa@gmail.com', 'null', 'profile.jpg', '$2b$12$7iCeBbP3zuoERLTtJTqytOr6mPNb9Gk4paTbDf.wM1eUMoZ1.nvjO');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;