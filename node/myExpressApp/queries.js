const initOptions = {
  // global event notification;
  error(error, e) {
      if (e.cn) {
          // A connection-related error;
          //
          // Connections are reported back with the password hashed,
          // for safe errors logging, without exposing passwords.
          console.log('CN:', e.cn);
          console.log('EVENT:', error.message || error);
      }
  }
};

var pgp = require('pg-promise')(initOptions);

var cn = {
  user: 'xisgvbuqbefvqs',
  password: '8ece9cc1f6a10692ffe6f69cd6d205c206f2f34a6b4635b5744417aa760c4c27',
  database: 'd9kls1oslb8occ',
  port: 5432,
  host: 'ec2-23-21-121-220.compute-1.amazonaws.com' // server name or IP address;

};
pgp.pg.defaults.ssl = true;
var db = pgp(cn);

db.connect()
    .then(obj => {
        obj.done(); // success, release the connection;
    })
    .catch(error => {
        console.log('ERROR:', error.message || error);
    });

// add query functions

module.exports = {
  consultarGrabarUsuario: consultarGrabarUsuario,
  consultarSolicitudHistorial: consultarSolicitudHistorial,
  nuevaSolicitud: nuevaSolicitud,
  aceptarSolicitud: aceptarSolicitud,
  consultarSolicitudesPendientes: consultarSolicitudesPendientes,
  consultarPerfil: consultarPerfil
};


function consultarGrabarUsuario(req, res, next) {
  db.func('fun_ConsultarGrabarUsuario', [req.body.Username])
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
  db.func('fun_ConsultarSolicitudHistorial', [req.body.Id])
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
  db.func('fun_NuevaSolicitud', [req.body.Id, req.body.Monto, req.body.Edad, req.body.TarjetaDeCredito, req.body.PlazoDeInteres])
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
  db.func('fun_AceptarSolicitud', [])
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

function consultarSolicitudesPendientes(req, res, next) {
  db.func('fun_ConsultarSolicitudesPendientes', [req.body.Id])
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Consulta de Solicitudes Pendientes'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function consultarPerfil(req, res, next) {
  db.func('fun_ConsultarPerfil', [req.body.Id])
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Consulta del Perfil'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

  //response is not defined
  //chrome.exe --user-data-dir="C:/Chrome dev session" --disable-web-security
