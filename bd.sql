-- Criar banco de dados
CREATE DATABASE ComunidadeDB;
USE ComunidadeDB;

-- ======================
-- 1. TABELAS PRINCIPAIS
-- ======================

CREATE TABLE Genero (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(20) NOT NULL
);

CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    id_genero INT,
    FOREIGN KEY (id_genero) REFERENCES Genero(id_genero)
);

CREATE TABLE Ministerio (
    id_ministerio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    responsavel VARCHAR(100)
);

CREATE TABLE Evento (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_evento DATE NOT NULL,
    horario TIME NOT NULL,
    local VARCHAR(100),
    tema VARCHAR(100),
    vagas INT,
    recursos TEXT
);

CREATE TABLE Missa (
    id_missa INT AUTO_INCREMENT PRIMARY KEY,
    data_missa DATE NOT NULL,
    horario TIME NOT NULL,
    local VARCHAR(100),
    tema VARCHAR(100)
);

CREATE TABLE Escala (
    id_escala INT AUTO_INCREMENT PRIMARY KEY,
    data_escala DATE NOT NULL,
    observacoes TEXT
);

-- ==========================
-- 2. TABELAS DE RELACIONAMENTO
-- ==========================

-- Usuários participam de Ministérios
CREATE TABLE Usuario_Ministerio (
    id_usuario INT,
    id_ministerio INT,
    PRIMARY KEY (id_usuario, id_ministerio),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_ministerio) REFERENCES Ministerio(id_ministerio)
);

-- Usuários participam de Eventos
CREATE TABLE Usuario_Evento (
    id_usuario INT,
    id_evento INT,
    PRIMARY KEY (id_usuario, id_evento),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento)
);

-- Ministérios são escalados em Missas
CREATE TABLE Escala_Ministerio (
    id_escala INT,
    id_ministerio INT,
    id_missa INT,
    PRIMARY KEY (id_escala, id_ministerio, id_missa),
    FOREIGN KEY (id_escala) REFERENCES Escala(id_escala),
    FOREIGN KEY (id_ministerio) REFERENCES Ministerio(id_ministerio),
    FOREIGN KEY (id_missa) REFERENCES Missa(id_missa)
);

-- ======================
-- 3. INSERINDO DADOS DE TESTE
-- ======================

INSERT INTO Genero (descricao) VALUES ('Masculino'), ('Feminino'), ('Outro');

INSERT INTO Usuario (nome, email, senha, data_nascimento, id_genero)
VALUES ('Ana Silva', 'ana@email.com', '12345', '2000-05-10', 2),
       ('João Santos', 'joao@email.com', '12345', '1998-03-15', 1);

INSERT INTO Ministerio (nome, descricao, responsavel)
VALUES ('Música', 'Responsável pelos cânticos', 'Pedro Almeida'),
       ('Liturgia', 'Organiza a celebração', 'Maria Souza');

INSERT INTO Evento (nome, data_evento, horario, local, tema, vagas, recursos)
VALUES ('Retiro Jovem', '2025-10-15', '09:00:00', 'Salão Paroquial', 'Espiritualidade', 50, 'Som, Projetor'),
       ('Encontro de Formação', '2025-11-05', '19:00:00', 'Auditório', 'Liturgia', 30, 'Livros, DataShow');

INSERT INTO Missa (data_missa, horario, local, tema)
VALUES ('2025-10-10', '18:00:00', 'Igreja Central', 'Missa de Ação de Graças'),
       ('2025-10-12', '10:00:00', 'Capela São José', 'Missa da Família');

INSERT INTO Escala (data_escala, observacoes)
VALUES ('2025-10-10', 'Escala de ministérios para missa de ação de graças'),
       ('2025-10-12', 'Escala de ministérios para missa da família');

-- Relacionamentos de teste
INSERT INTO Usuario_Ministerio VALUES (1, 1), (2, 2);
INSERT INTO Usuario_Evento VALUES (1, 1), (2, 2);
INSERT INTO Escala_Ministerio VALUES (1, 1, 1), (2, 2, 2);
