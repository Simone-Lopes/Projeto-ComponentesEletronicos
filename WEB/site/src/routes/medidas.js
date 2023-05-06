var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas_umi/:idLocal", function (req, res) {
    medidaController.buscarUltimasMedidas_umi(req, res);
});

router.get("/tempo-real_umi/:idLocal", function (req, res) {
    medidaController.buscarMedidasEmTempoReal_umi(req, res);
})

router.get("/ultimas_temp/:idLocal", function (req, res) {
    medidaController.buscarUltimasMedidas_temp(req, res);
});

router.get("/tempo-real_temp/:idLocal", function (req, res) {
    medidaController.buscarMedidasEmTempoReal_temp(req, res);
})

module.exports = router;