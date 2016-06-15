
var loopback = require('loopback');

module.exports = function(Producto) {
    
    Producto.observe('before save', function(ctx, next) {
            //SI CREO
        if (ctx.instance) {
            var ctxs = loopback.getCurrentContext();
            var currentUser = ctxs.get('currentUser');
            ctx.instance.fecha = new Date();
            //ctx.instance.id_usuario = ctxs.active.accessToken["userId"];
            console.log('currentUser.username: ', ctxs.active.accessToken);
            //SI UPDATEO
        } else {

        }
        //CONTINUO
        next();
    });
};
