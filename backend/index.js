const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');

const app = express();
app.use(bodyParser.json());

// Conexão com MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',       // seu usuário do MySQL
    password: '06022009Anna*',       // sua senha
    database: 'ComunidadeDB'
});

db.connect(err => {
    if(err) {
        console.log('Erro ao conectar ao banco:', err);
    } else {
        console.log('Conectado ao banco de dados!');
    }
});

// =========================
// Rotas do Back-end
// =========================

// 1. Listar todos os usuários
app.get('/usuarios', (req, res) => {
    const sql = 'SELECT * FROM Usuario';
    db.query(sql, (err, results) => {
        if(err) return res.status(500).send(err);
        res.json(results);
    });
});

// 2. Inscrever usuário em evento
app.post('/inscrever_evento', (req, res) => {
    const { id_usuario, id_evento } = req.body;
    const sql = 'INSERT INTO Usuario_Evento (id_usuario, id_evento) VALUES (?, ?)';
    db.query(sql, [id_usuario, id_evento], (err, result) => {
        if(err) return res.status(500).send(err);
        res.send('Usuário inscrito no evento com sucesso!');
    });
});

// 3. Mostrar escala de uma missa
app.get('/escala/:id_missa', (req, res) => {
    const id_missa = req.params.id_missa;
    const sql = `
        SELECT u.nome AS Usuario, m.nome AS Ministerio
        FROM Escala_Ministerio em
        JOIN Ministerio m ON em.id_ministerio = m.id_ministerio
        JOIN Usuario_Ministerio um ON m.id_ministerio = um.id_ministerio
        JOIN Usuario u ON um.id_usuario = u.id_usuario
        WHERE em.id_missa = ?
    `;
    db.query(sql, [id_missa], (err, results) => {
        if(err) return res.status(500).send(err);
        res.json(results);
    });
});

// Iniciar servidor
app.listen(3000, () => {
    console.log('Servidor rodando em http://localhost:3000');
});
