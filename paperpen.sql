-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 13-Set-2022 às 16:43
-- Versão do servidor: 10.4.22-MariaDB
-- versão do PHP: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sas`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `config`
--

CREATE TABLE `config` (
  `id` int(11) NOT NULL,
  `empresa` int(11) NOT NULL,
  `nome_sistema` varchar(50) NOT NULL,
  `telefone_sistema` varchar(20) DEFAULT NULL,
  `email_sistema` varchar(20) DEFAULT NULL,
  `tipo_rel` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `config`
--

INSERT INTO `config` (`id`, `empresa`, `nome_sistema`, `telefone_sistema`, `email_sistema`, `tipo_rel`) VALUES
(1, 0, 'Sistema de Vendas', '(55) 55555-5555', 'contato@hugocursos.c', 'PDF');

-- --------------------------------------------------------

CREATE TABLE `Produtos` (
  `id_produto` int(11) NOT NULL PRIMARY KEY,
  `nome_produto` varchar(50) NOT NULL,
  `descricao_produto`TEXT,
  `categoria_produto` varchar(100),
  `unidade_medida` varchar(20),
  `peso` DECIMAL(10, 2),
  `volume` DECIMAL(10, 2,
  `codigo_barra` varchar(50),
  `fornecedor_id` INT(11),
  `data_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Ordens (
    `id_ordem` INT(11) PRIMARY KEY,
    `tipo_ordem` VARCHAR(50), -- 'Entrada' ou 'Saída'
    `status_ordem` VARCHAR(50), -- 'Pendente', 'Processando', 'Concluída'
    `data_emissao` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `data_prevista` TIMESTAMP,
    `id_cliente` INT(11), -- Pode ser utilizado para clientes de serviços de transporte ou exportação
    `id_funcionario` INT(11), -- Pessoa responsável pela ordem
    `data_conclusao` TIMESTAMP
);

CREATE TABLE Movimentacao_Estoque (
    `id_movimentacao` INT(11) PRIMARY KEY,
    `id_produto` INT(11),
    `id_localizacao_origem` INT(11),
    `id_localizacao_destino` INT(11),
    `quantidade` DECIMAL(10, 2),
    `tipo_movimentacao` VARCHAR(50), -- 'Entrada' ou 'Saída'
    `data_movimentacao` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `id_funcionario` INT(11), -- Responsável pela movimentação
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
    FOREIGN KEY (id_localizacao_origem) REFERENCES Localizacoes(id_localizacao),
    FOREIGN KEY (id_localizacao_destino) REFERENCES Localizacoes(id_localizacao)
);

CREATE TABLE Localizacoes (
    `id_localizacao` INT(11) PRIMARY KEY,
    `codigo_localizacao` VARCHAR(50) NOT NULL,
    `tipo_localizacao` VARCHAR(50),
    `descricao_localizacao` TEXT,
    `capacidade` DECIMAL(10, 2),
    `id_area` INT,
    `data_registro`S TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Itens_Ordem (
    `id_item_ordem` INT(11) PRIMARY KEY,
    `id_ordem` INT(11),
    `id_produto` INT(11),
    `quantidade` DECIMAL(10, 2),
    `unidade_medida` VARCHAR(20),
    FOREIGN KEY (id_ordem) REFERENCES Ordens(id_ordem),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

CREATE TABLE Fornecedores (
    `id_fornecedor` INT(11) PRIMARY KEY,
    `nome_fornecedor` VARCHAR(100) NOT NULL,
    `cnpj` VARCHAR(18),
    `endereco_fornecedor` VARCHAR(100),
    `telefone_fornecedor` VARCHAR(15),
    `email_fornecedor` VARCHAR(50),
    `data_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Areas (
    `id_area` INT(11) PRIMARY KEY,
    `nome_area` VARCHAR(50),
    `descricao_area` TEXT
);
--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id_funcionario` int(11) NOT NULL PRIMARY KEY,
  `empresa` int(11) NOT NULL,
  `nome_funcionario` varchar(50) NOT NULL,
  `telefone_funcionario` varchar(20) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `email_funcionario` varchar(50) DEFAULT NULL,
  `senha` varchar(25) NOT NULL,
  `senha_crip` varchar(100) NOT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `ativo` varchar(5) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `nivel` varchar(50) NOT NULL,
  `data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `empresa`, `nome`, `telefone`, `cpf`, `email`, `senha`, `senha_crip`, `endereco`, `ativo`, `foto`, `nivel`, `data`) VALUES
(3, 0, 'Administrador SAS', '(44) 44444-5555', '000.000.000-00', 'contato@hugocursos.com.br', '123', '202cb962ac59075b964b07152d234b70', 'Rua 6', 'Sim', '13-09-2022-09-43-36-04-05-2022-14-26-43-eu.jpeg', 'SAS', '2022-09-12');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
