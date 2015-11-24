class nginx::package {

  require 'apt'

  apt::source { 'nginx':
    entries => [
      "deb http://nginx.org/packages/debian/ ${::lsbdistcodename} nginx",
      "deb-src http://nginx.org/packages/debian/ ${::lsbdistcodename} nginx"
    ],
    keys    => {
      'nginx' => {
        key     => '7BD9BF62',
        key_url => 'http://nginx.org/keys/nginx_signing.key',
      }
    }
  }
  ->

  package { 'nginx':
    provider => 'apt',
    ensure => present,
  }
}
