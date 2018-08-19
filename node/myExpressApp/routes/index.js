var express = require('express');
var router = express.Router();
var db = require('../queries');
router.post('/api/consultarGrabarUsuario', db.consultarGrabarUsuario);

module.exports = router;







