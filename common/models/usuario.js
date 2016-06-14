module.exports = function(Usuario) {
    
    Usuario.observe('before save', function(ctx, next) {
            //SI CREO
        if (ctx.instance) {
            ctx.instance.created = new Date();
            //SI UPDATEO
        } else {

        }
        //CONTINUO
        next();
    });

};
