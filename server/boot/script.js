// Copyright IBM Corp. 2015,2016. All Rights Reserved.
// Node module: loopback-example-access-control
// This file is licensed under the Artistic License 2.0.
// License text available at https://opensource.org/licenses/Artistic-2.0

/*
module.exports = function(app) {
  var User = app.models.Usuario;
  var Role = app.models.Role;
  var RoleMapping = app.models.RoleMapping;
  
  User.create([
    {username: 'John', telefono:"1234", email: 'john@doe.com', password: 'opensesame'},
    {username: 'Jane', telefono:"1234", email: 'jane@doe.com', password: 'opensesame'},
    {username: 'Bob', telefono:"1234", email: 'bob@projects.com', password: 'opensesame'}
  ], function(err, users) {
    if (err) throw err;
 
    //create the admin role
    Role.create({
      name: 'admin'
    }, function(err, role) {
      if (err) throw err;
 
      //make bob an admin
      role.principals.create({
        principalType: RoleMapping.USER,
        principalId: users[2].id
      }, function(err, principal) {
        if (err) throw err;
      });
    });
  });

  
};*/