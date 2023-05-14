var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas_Umi/:idLocal", function (req, res) {
    medidaController.buscarUltimasMedidas_Umi(req, res);
});

router.get("/tempo-real_Umi/:idLocal", function (req, res) {
    medidaController.buscarMedidasEmTempoReal_Umi(req, res);
})

router.get("/ultimas_Temp/:idLocal", function (req, res) {
    medidaController.buscarUltimasMedidas_Temp(req, res);
});

router.get("/tempo-real_Temp/:idLocal", function (req, res) {
    medidaController.buscarMedidasEmTempoReal_Temp(req, res);
})

module.exports = router;