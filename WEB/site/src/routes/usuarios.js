var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

router.get("/", function (req, res) {
    usuarioController.testar(req, res);
});

router.post("/listar_usuarios", function (req, res) {
    usuarioController.listar_usuarios(req, res);
});

router.post("/listar_locais", function (req, res) {
    usuarioController.listar_locais(req, res);
});

router.get("/listar_empresas", function (req, res) {
    usuarioController.listar_empresas(req, res);
});

router.post("/buscar_usuario", function (req, res) {
    usuarioController.buscar_usuario(req, res);
});

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/cadastrar_local", function (req, res) {
    usuarioController.cadastrar_local(req, res);
})

router.post("/autenticar", function (req, res) {
    usuarioController.entrar(req, res);
});

router.post("/deletar", function (req, res) {
    usuarioController.deletar(req, res);
});

router.post("/deletar_local", function (req, res) {
    usuarioController.deletar_local(req, res);
});

router.post("/limpar_tabela", function (req, res) {
    usuarioController.limpar_tabela(req, res);
});

module.exports = router;