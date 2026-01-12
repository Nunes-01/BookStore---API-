function fn() {
  var env = karate.env;

  var uuid = java.util.UUID.randomUUID().toString().substring(0, 8);

  var config = {
    baseUrl: 'https://bookstore.demoqa.com',
    user: {
      userName: 'User_' + uuid,
      password: 'Password@123!'
    }
  };

  karate.configure('connectTimeout', 60000);
  karate.configure('readTimeout', 60000);

  karate.configure('ssl',true);
  return config;
}