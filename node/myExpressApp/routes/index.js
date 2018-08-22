var express = require('express');
var router = express.Router();
var db = require('../queries');
router.post('/api/consultarGrabarUsuario', db.consultarGrabarUsuario);
router.post('/api/consultarSolicitudHistorial', db.consultarSolicitudHistorial);
router.post('/api/nuevaSolicitud', db.nuevaSolicitud);
router.get('/api/aceptarSolicitud', db.aceptarSolicitud);

module.exports = router;









