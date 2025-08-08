-- ####################################################################
-- Script SQL para o sistema de gestão de oficina "bco_oficina"
-- ####################################################################

-- Seleciona o banco de dados para uso
USE bco_oficina;

-- Desativa a verificação de chaves estrangeiras para permitir a exclusão das tabelas
SET FOREIGN_KEY_CHECKS = 0;

-- Exclui as tabelas existentes (se houver) para evitar erros ao recriar
DROP TABLE IF EXISTS tipo_manutencao;
DROP TABLE IF EXISTS veiculos;
DROP TABLE IF EXISTS manutencao;
DROP TABLE IF EXISTS proprietarios;

-- Reativa a verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;

-- --------------------------------------------------------
-- Tabela: proprietarios
-- Armazena os dados dos proprietários dos veículos
-- --------------------------------------------------------
CREATE TABLE proprietarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- --------------------------------------------------------
-- Tabela: manutencao
-- Armazena os tipos de serviços disponíveis na oficina e seus preços
-- --------------------------------------------------------
CREATE TABLE manutencao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_servico VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

-- --------------------------------------------------------
-- Tabela: veiculos
-- Armazena os dados dos veículos e os associa a um proprietário
-- --------------------------------------------------------
CREATE TABLE veiculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(8) NOT NULL UNIQUE,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    ano YEAR,
    proprietario_id INT,
    FOREIGN KEY (proprietario_id) REFERENCES proprietarios(id)
);

-- --------------------------------------------------------
-- Tabela: tipo_manutencao
-- Esta tabela atua como uma "ordem de serviço", conectando
-- um veículo a um ou mais serviços realizados.
-- --------------------------------------------------------
CREATE TABLE tipo_manutencao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    veiculo_id INT NOT NULL,
    manutencao_id INT NOT NULL,
    data_servico DATE NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (veiculo_id) REFERENCES veiculos(id),
    FOREIGN KEY (manutencao_id) REFERENCES manutencao(id)
);

-- ####################################################################
-- POPULANDO AS TABELAS COM DADOS FICTÍCIOS
-- ####################################################################

-- --------------------------------------------------------
-- Dados para a tabela 'proprietarios'
-- --------------------------------------------------------
INSERT INTO proprietarios (nome, telefone, email) VALUES
('João Silva', '11987654321', 'joao.silva@email.com'),
('Maria Oliveira', '21912345678', 'maria.o@email.com'),
('Pedro Souza', '31998765432', 'pedro.souza@email.com'),
('Ana Costa', '41911223344', 'ana.costa@email.com');

-- --------------------------------------------------------
-- Dados para a tabela 'manutencao' (serviços disponíveis)
-- --------------------------------------------------------
INSERT INTO manutencao (nome_servico, preco) VALUES
('Revisão Completa', 350.00),
('Troca de Óleo e Filtro', 120.50),
('Alinhamento e Balanceamento', 85.00),
('Substituição de Pastilhas de Freio', 250.00),
('Diagnóstico Computadorizado', 150.00);

-- --------------------------------------------------------
-- Dados para a tabela 'veiculos'
-- Associando cada veículo a um proprietário
-- --------------------------------------------------------
INSERT INTO veiculos (placa, marca, modelo, ano, proprietario_id) VALUES
('ABC1234', 'Volkswagen', 'Gol', 2018, 1),
('XYZ5678', 'Chevrolet', 'Onix', 2020, 2),
('DEF9012', 'Honda', 'Civic', 2019, 3),
('GHI3456', 'Fiat', 'Toro', 2022, 1),
('JKL7890', 'Hyundai', 'HB20', 2021, 4);

-- --------------------------------------------------------
-- Dados para a tabela 'tipo_manutencao' (ordens de serviço)
-- Associando veículos e serviços a uma data específica
-- --------------------------------------------------------
INSERT INTO tipo_manutencao (veiculo_id, manutencao_id, data_servico, observacoes) VALUES
(1, 2, '2025-05-10', 'Troca de óleo e filtro realizada com óleo 5w-30.'),
(2, 1, '2025-05-15', 'Revisão completa de 20.000 km.'),
(3, 3, '2025-05-18', 'Correção de desalinhamento na suspensão traseira.'),
(4, 4, '2025-05-20', 'Pastilhas de freio dianteiras substituídas.'),
(5, 5, '2025-05-22', 'Diagnóstico para problema no sensor de ABS. Sensor substituído.');

-- Fim do script