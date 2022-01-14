-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 14, 2022 at 11:58 PM
-- Server version: 8.0.27-0ubuntu0.20.04.1
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(7, 1, 9, 1, '2022-01-14 21:44:34');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `second_name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `profile_pic` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `second_name`, `email`, `mobile`, `profile_pic`, `password`) VALUES
(1, 'ruth', 'doe', 'ruthdoe@gmail.com', NULL, 'profile.jpg', 'ruth'),
(3, 'foo', 'bar', 'foo@gmail.com', NULL, 'profile.jpg', 'foo'),
(4, 'james', 'mumo', 'jmumo@gmail.com', NULL, 'profile.jpg', 'james');

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
