module.exports = function(OrdenComprador) {
    
    OrdenComprador.observe('before save', function(ctx, next) {
            //SI CREO
        if (ctx.instance) {
            ctx.instance.fecha = new Date();
            //SI UPDATEO
        } else {

        }
        //CONTINUO
        next();
    });

};
