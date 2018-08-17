
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
    db.func('usuario',["david"])
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