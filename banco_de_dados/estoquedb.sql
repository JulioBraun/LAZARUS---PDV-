-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.1.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win32
-- HeidiSQL Versão:              9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para estoquedb
CREATE DATABASE IF NOT EXISTS `estoquedb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `estoquedb`;

-- Copiando estrutura para tabela estoquedb.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `IDCLIENTE` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT '0',
  `ENDERECO` varchar(50) DEFAULT '0',
  `CIDADE` varchar(50) DEFAULT '0',
  `ESTADO` char(2) DEFAULT '0',
  `CELULAR` varchar(14) DEFAULT '0',
  `CEP` varchar(9) DEFAULT '0',
  PRIMARY KEY (`IDCLIENTE`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela estoquedb.cliente: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` (`IDCLIENTE`, `NOME`, `ENDERECO`, `CIDADE`, `ESTADO`, `CELULAR`, `CEP`) VALUES
	(1, 'tttt', 'rua do sol', 'CAMPINA GRANDE', 'PB', '(99)9999-9999', '11111-888'),
	(3, 'Carl Gustav Jung', 'Rua do Sol', 'São Paulo', 'SP', '(88)8888-8888', '44444-444'),
	(5, 'Maria', 'Rua Principal', 'São Luís', 'MA', '(98)9999-9999', '66666-999');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;

-- Copiando estrutura para tabela estoquedb.item
CREATE TABLE IF NOT EXISTS `item` (
  `IDITEM` int(11) NOT NULL AUTO_INCREMENT,
  `ID_VENDA` int(11) NOT NULL DEFAULT '0',
  `ID_PRODUTO` int(11) NOT NULL DEFAULT '0',
  `QUANTIDADE` double(15,2) DEFAULT '0.00',
  PRIMARY KEY (`IDITEM`),
  KEY `FK_item_venda` (`ID_VENDA`),
  KEY `FK_item_produto` (`ID_PRODUTO`),
  CONSTRAINT `FK_item_produto` FOREIGN KEY (`ID_PRODUTO`) REFERENCES `produto` (`IDPRODUTO`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_item_venda` FOREIGN KEY (`ID_VENDA`) REFERENCES `venda` (`IDVENDA`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela estoquedb.item: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` (`IDITEM`, `ID_VENDA`, `ID_PRODUTO`, `QUANTIDADE`) VALUES
	(1, 1, 1, 2.00),
	(2, 2, 1, 3.00),
	(3, 2, 2, 2.50),
	(4, 2, 3, 1.00);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;

-- Copiando estrutura para tabela estoquedb.produto
CREATE TABLE IF NOT EXISTS `produto` (
  `IDPRODUTO` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(50) DEFAULT '0',
  `ESTOQUE` double(15,2) DEFAULT '0.00',
  `PRECOCUSTO` double(15,2) DEFAULT '0.00',
  `PRECOVENDA` double(15,2) DEFAULT '0.00',
  PRIMARY KEY (`IDPRODUTO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela estoquedb.produto: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` (`IDPRODUTO`, `DESCRICAO`, `ESTOQUE`, `PRECOCUSTO`, `PRECOVENDA`) VALUES
	(1, 'Boné', 95.00, 20.00, 50.00),
	(2, 'Camisa', 47.50, 45.98, 67.89),
	(3, 'Meias', 11.00, 20.00, 25.00);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;

-- Copiando estrutura para tabela estoquedb.venda
CREATE TABLE IF NOT EXISTS `venda` (
  `IDVENDA` int(11) NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` int(11) NOT NULL DEFAULT '0',
  `DATA` date DEFAULT NULL,
  `VALORTOTAL` double(15,2) DEFAULT '0.00',
  `VALORPAGO` double(15,2) DEFAULT '0.00',
  `DESCONTO` double(15,2) DEFAULT '0.00',
  PRIMARY KEY (`IDVENDA`),
  KEY `FK_venda_cliente` (`ID_CLIENTE`),
  CONSTRAINT `FK_venda_cliente` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `cliente` (`IDCLIENTE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela estoquedb.venda: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `venda` DISABLE KEYS */;
INSERT INTO `venda` (`IDVENDA`, `ID_CLIENTE`, `DATA`, `VALORTOTAL`, `VALORPAGO`, `DESCONTO`) VALUES
	(1, 1, '2018-09-20', 100.00, 95.00, 5.00),
	(2, 3, '2018-10-05', 344.73, 318.75, 25.98);
/*!40000 ALTER TABLE `venda` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
