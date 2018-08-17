var express = require('express');
var router = express.Router();

var db = require('../queries');

router.get('/api/consultarGrabarUsuario', db.consultarGrabarUsuario);


module.exports = router;







