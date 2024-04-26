-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2024 at 10:47 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `netflix`
--

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `CityId` int(11) NOT NULL,
  `CityName` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `dvd`
--

CREATE TABLE `dvd` (
  `DVDId` bigint(20) NOT NULL,
  `DVDTitle` varchar(32) NOT NULL,
  `GenreId` int(11) NOT NULL,
  `RatingId` int(11) NOT NULL,
  `DVDReleaseDate` datetime NOT NULL,
  `TheaterReleaseDate` datetime DEFAULT NULL,
  `DVDQuantityOnHand` int(11) NOT NULL,
  `DVDQuantityOnRent` int(11) NOT NULL,
  `DVDLostQuantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `GenreId` int(11) NOT NULL,
  `GenreName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `MemberId` int(11) NOT NULL,
  `MemberFirstName` varchar(32) NOT NULL,
  `MemberLastName` varchar(32) NOT NULL,
  `MemberInitial` varchar(32) DEFAULT NULL,
  `MemberAddress` varchar(100) NOT NULL,
  `MemberAddressId` int(11) NOT NULL,
  `MemberPhone` varchar(14) DEFAULT NULL,
  `MemberEMail` varchar(32) NOT NULL,
  `MemberPassword` varchar(32) NOT NULL,
  `MembershipId` int(11) NOT NULL,
  `MemberSinceDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `membership`
--

CREATE TABLE `membership` (
  `MembershipId` int(11) NOT NULL,
  `MembershipType` varchar(128) NOT NULL,
  `MembershipLimitPerMonth` int(11) NOT NULL,
  `MembershipMonthlyPrice` decimal(5,2) NOT NULL,
  `MembershipMonthlyTax` decimal(5,2) NOT NULL,
  `MembershipDVDLostPrice` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `movieperson`
--

CREATE TABLE `movieperson` (
  `PersonId` int(11) NOT NULL,
  `PersonFirstName` varchar(32) NOT NULL,
  `PersonLastName` varchar(32) NOT NULL,
  `PersonInitial` varchar(32) DEFAULT NULL,
  `PersonDateOfBirth` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `moviepersonrole`
--

CREATE TABLE `moviepersonrole` (
  `PersonId` int(11) NOT NULL,
  `RoleId` int(11) NOT NULL,
  `DVDId` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `PaymentId` bigint(20) NOT NULL,
  `MemberId` int(11) NOT NULL,
  `AmountPaid` decimal(8,2) NOT NULL,
  `AmountPaidDate` datetime NOT NULL,
  `AmountPaidUntilDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `RatingId` int(11) NOT NULL,
  `RatingName` varchar(10) NOT NULL,
  `RatingDescription` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rental`
--

CREATE TABLE `rental` (
  `RentalId` bigint(20) NOT NULL,
  `MemberId` int(11) NOT NULL,
  `DVDId` bigint(20) NOT NULL,
  `RentalRequestDate` datetime NOT NULL,
  `RentalShippedDate` datetime DEFAULT NULL,
  `RentalReturnedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rentalqueue`
--

CREATE TABLE `rentalqueue` (
  `MemberId` int(11) NOT NULL,
  `DVDId` bigint(20) NOT NULL,
  `DateAddedInQueue` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `RoleId` int(11) NOT NULL,
  `RoleName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE `state` (
  `StateId` int(11) NOT NULL,
  `StateName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `zipcode`
--

CREATE TABLE `zipcode` (
  `ZipCodeId` int(11) NOT NULL,
  `ZipCode` varchar(5) NOT NULL,
  `StateId` int(11) DEFAULT NULL,
  `CityId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`CityId`);

--
-- Indexes for table `dvd`
--
ALTER TABLE `dvd`
  ADD PRIMARY KEY (`DVDId`),
  ADD KEY `GenreId` (`GenreId`),
  ADD KEY `RatingId` (`RatingId`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`GenreId`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`MemberId`),
  ADD KEY `MemberAddressId` (`MemberAddressId`),
  ADD KEY `MembershipId` (`MembershipId`);

--
-- Indexes for table `membership`
--
ALTER TABLE `membership`
  ADD PRIMARY KEY (`MembershipId`);

--
-- Indexes for table `movieperson`
--
ALTER TABLE `movieperson`
  ADD PRIMARY KEY (`PersonId`);

--
-- Indexes for table `moviepersonrole`
--
ALTER TABLE `moviepersonrole`
  ADD PRIMARY KEY (`PersonId`,`DVDId`,`RoleId`),
  ADD KEY `DVDId` (`DVDId`),
  ADD KEY `RoleId` (`RoleId`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`PaymentId`),
  ADD KEY `MemberId` (`MemberId`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`RatingId`);

--
-- Indexes for table `rental`
--
ALTER TABLE `rental`
  ADD PRIMARY KEY (`RentalId`),
  ADD KEY `MemberId` (`MemberId`),
  ADD KEY `DVDId` (`DVDId`);

--
-- Indexes for table `rentalqueue`
--
ALTER TABLE `rentalqueue`
  ADD PRIMARY KEY (`MemberId`,`DVDId`),
  ADD KEY `DVDId` (`DVDId`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`RoleId`);

--
-- Indexes for table `state`
--
ALTER TABLE `state`
  ADD PRIMARY KEY (`StateId`);

--
-- Indexes for table `zipcode`
--
ALTER TABLE `zipcode`
  ADD PRIMARY KEY (`ZipCodeId`),
  ADD KEY `StateId` (`StateId`),
  ADD KEY `CityId` (`CityId`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dvd`
--
ALTER TABLE `dvd`
  ADD CONSTRAINT `dvd_ibfk_1` FOREIGN KEY (`GenreId`) REFERENCES `genre` (`GenreId`),
  ADD CONSTRAINT `dvd_ibfk_2` FOREIGN KEY (`RatingId`) REFERENCES `rating` (`RatingId`);

--
-- Constraints for table `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `member_ibfk_1` FOREIGN KEY (`MemberAddressId`) REFERENCES `zipcode` (`ZipCodeId`),
  ADD CONSTRAINT `member_ibfk_2` FOREIGN KEY (`MembershipId`) REFERENCES `membership` (`MembershipId`);

--
-- Constraints for table `moviepersonrole`
--
ALTER TABLE `moviepersonrole`
  ADD CONSTRAINT `moviepersonrole_ibfk_1` FOREIGN KEY (`PersonId`) REFERENCES `movieperson` (`PersonId`),
  ADD CONSTRAINT `moviepersonrole_ibfk_2` FOREIGN KEY (`DVDId`) REFERENCES `dvd` (`DVDId`),
  ADD CONSTRAINT `moviepersonrole_ibfk_3` FOREIGN KEY (`RoleId`) REFERENCES `role` (`RoleId`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`MemberId`) REFERENCES `member` (`MemberId`);

--
-- Constraints for table `rental`
--
ALTER TABLE `rental`
  ADD CONSTRAINT `rental_ibfk_1` FOREIGN KEY (`MemberId`) REFERENCES `member` (`MemberId`),
  ADD CONSTRAINT `rental_ibfk_2` FOREIGN KEY (`DVDId`) REFERENCES `dvd` (`DVDId`);

--
-- Constraints for table `rentalqueue`
--
ALTER TABLE `rentalqueue`
  ADD CONSTRAINT `rentalqueue_ibfk_1` FOREIGN KEY (`MemberId`) REFERENCES `member` (`MemberId`),
  ADD CONSTRAINT `rentalqueue_ibfk_2` FOREIGN KEY (`DVDId`) REFERENCES `dvd` (`DVDId`);

--
-- Constraints for table `zipcode`
--
ALTER TABLE `zipcode`
  ADD CONSTRAINT `zipcode_ibfk_1` FOREIGN KEY (`StateId`) REFERENCES `state` (`StateId`),
  ADD CONSTRAINT `zipcode_ibfk_2` FOREIGN KEY (`CityId`) REFERENCES `city` (`CityId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
