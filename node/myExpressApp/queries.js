
var pgp = require('pg-promise')({});
var cn = {
    host: 'localhost', // server name or IP address;
    port: 5432,
    database: 'EasyCredit',
    user: 'postgres',
    password: '1'
};

var db = pgp(cn);


// add query functions

module.exports = {
  consultarGrabarUsuario: consultarGrabarUsuario
};


function consultarGrabarUsuario(req, res, next) {
    db.func('fun_ConsultarGrabarUsuario',[req.body.Username])
      .then(function (data) {
        res.status(200)
          .json({
            status: 'success',
            data: data,
            message: 'Consulta o guarda usuario'
          });
      })
      .catch(function (err) {
        return next(err);
      });
  }
 
  function consultarSolicitudHistorial(req, res, next) {
    db.func('fun_ConsultarSolicitudHistorial',[req.body.Id])
      .then(function (data) {
        res.status(200)
          .json({
            status: 'success',
            data: data,
            message: 'Consulta de Solicitudes Historial'
          });
      })
      .catch(function (err) {
        return next(err);
      });
  }

  function nuevaSolicitud(req, res, next) {
    db.func('fun_NuevaSolicitud',[req.body.Id,req.body.Monto,req.body.Edad,req.body.TarjetaDeCredito,req.body.PlazoDeInteres,req.body.ProcesoDeAutorizacion])
      .then(function (data) {
        res.status(200)
          .json({
            status: 'success',
            data: data,
            message: 'Solicitud Insertada'
          });
      })
      .catch(function (err) {
        return next(err);
      });
  }

  function aceptarSolicitud(req, res, next) {
    db.func('fun_AceptarSolicitud',[])
      .then(function (data) {
        res.status(200)
          .json({
            status: 'success',
            data: data,
            message: 'Solicitud Aceptada'
          });
      })
      .catch(function (err) {
        return next(err);
      });
  }


  //response is not defined
  //chrome.exe --user-data-dir="C:/Chrome dev session" --disable-web-security