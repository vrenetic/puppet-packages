node default {

  class { 'screenconnect':
    account => 'vrenetic',
    server  => 'myInstanceServer.screenconnect.com',
    key     => 'mySecretKey',
  }

}
