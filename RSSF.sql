-- phpMyAdmin SQL Dump
-- version 4.2.6deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 11-Maio-2015 às 19:57
-- Versão do servidor: 5.5.41-0ubuntu0.14.10.1
-- PHP Version: 5.5.12-2ubuntu4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `RSSF`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `Amostra`
--

CREATE TABLE IF NOT EXISTS `Amostra` (
`idAmostra` int(11) NOT NULL,
  `idSensor` int(11) NOT NULL,
  `valor` int(5) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `No`
--

CREATE TABLE IF NOT EXISTS `No` (
`idNo` int(11) NOT NULL,
  `serial` varchar(16) NOT NULL,
  `name` varchar(10) NOT NULL,
  `latitude` varchar(6) DEFAULT NULL,
  `longitude` varchar(6) DEFAULT NULL,
  `altitude` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Sensor`
--

CREATE TABLE IF NOT EXISTS `Sensor` (
`idSensor` int(11) NOT NULL,
  `idNo` int(11) NOT NULL,
  `idTipo` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Tipo`
--

CREATE TABLE IF NOT EXISTS `Tipo` (
`idTipo` int(11) NOT NULL,
  `tipo` varchar(15) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Amostra`
--
ALTER TABLE `Amostra`
 ADD PRIMARY KEY (`idAmostra`), ADD KEY `idSensor` (`idSensor`);

--
-- Indexes for table `No`
--
ALTER TABLE `No`
 ADD PRIMARY KEY (`idNo`);

--
-- Indexes for table `Sensor`
--
ALTER TABLE `Sensor`
 ADD PRIMARY KEY (`idSensor`), ADD KEY `idTipo` (`idTipo`), ADD KEY `idNo` (`idNo`);

--
-- Indexes for table `Tipo`
--
ALTER TABLE `Tipo`
 ADD PRIMARY KEY (`idTipo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Amostra`
--
ALTER TABLE `Amostra`
MODIFY `idAmostra` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `No`
--
ALTER TABLE `No`
MODIFY `idNo` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Sensor`
--
ALTER TABLE `Sensor`
MODIFY `idSensor` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Tipo`
--
ALTER TABLE `Tipo`
MODIFY `idTipo` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `Amostra`
--
ALTER TABLE `Amostra`
ADD CONSTRAINT `Amostra_ibfk_1` FOREIGN KEY (`idSensor`) REFERENCES `Sensor` (`idSensor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `Sensor`
--
ALTER TABLE `Sensor`
ADD CONSTRAINT `Sensor_ibfk_2` FOREIGN KEY (`idNo`) REFERENCES `No` (`idNo`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `Sensor_ibfk_1` FOREIGN KEY (`idTipo`) REFERENCES `Tipo` (`idTipo`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
