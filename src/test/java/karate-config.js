function() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  var config = {};

  if(env == 'qa'){
      config = {
        "url": karate.properties['baseUrl'],
        "users": {
          "regular": {
            "email": karate.properties['regularEmail'],
            "password": karate.properties['regularPass']
          },
          "admin": {
            "email": karate.properties['adminEmail'],
            "password": karate.properties['adminPass']
          },
          "newUser": {
            "email": karate.properties['newUserEmail'],
            "password": karate.properties['newUserPass'],
            "firstName": karate.properties['newUserFirstName'],
            "lastName": karate.properties['newUserLastName']
          }
        }
       };
  }else{
    var data = read('classpath:nodejs/flows/env.json');
    config = data[env];
  }

  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);

  return config;
}
