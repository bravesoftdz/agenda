-- MySQL dump 10.13  Distrib 5.6.24, for Win32 (x86)
--
-- Host: agendadb.cfmlnopzuyrp.sa-east-1.rds.amazonaws.com    Database: agendadb
-- ------------------------------------------------------
-- Server version	5.6.23-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno` (
  `aluno_id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) DEFAULT NULL,
  `sobrenome` varchar(150) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `sexo` char(1) DEFAULT NULL,
  `rg` varchar(50) DEFAULT NULL,
  `cpf` bigint(20) DEFAULT NULL,
  `ativo` char(1) DEFAULT NULL,
  `informacoes_gerais` text,
  `escola_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`aluno_id`),
  KEY `fk_aluno_escola_idx` (`escola_id`),
  KEY `idx_aluno_nome` (`nome`),
  KEY `idx_aluno_sobrenome` (`sobrenome`),
  KEY `idx_aluno_data_nascimento` (`data_nascimento`),
  KEY `idx_aluno_rg` (`rg`),
  KEY `idx_aluno_cpf` (`cpf`),
  KEY `idx_aluno_ativo` (`ativo`),
  KEY `idx_aluno_escola_id` (`escola_id`),
  CONSTRAINT `fk_aluno_x_escola` FOREIGN KEY (`escola_id`) REFERENCES `escola` (`escola_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno`
--

LOCK TABLES `aluno` WRITE;
/*!40000 ALTER TABLE `aluno` DISABLE KEYS */;
INSERT INTO `aluno` VALUES (10,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(11,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(12,'3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(13,'4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(19,'Leonardo','Bomconpagno Alves','2015-10-07','M','427099705',32087213828,'S','teste',1),(25,'Maria','da Silva',NULL,NULL,NULL,NULL,'S',NULL,1),(27,'Carlos','Vizinho',NULL,NULL,NULL,NULL,'S',NULL,1),(28,'Gertrudes','',NULL,NULL,NULL,NULL,'S',NULL,1),(29,'Aluno de Teste - ID Escola 2',NULL,NULL,NULL,NULL,NULL,'S',NULL,2),(36,'Pedro',NULL,NULL,NULL,NULL,NULL,'S',NULL,1);
/*!40000 ALTER TABLE `aluno` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-04 16:16:49
