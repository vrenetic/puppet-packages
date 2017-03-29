class graphene (
  $version = 'latest',
) {

  require 'apt::source::vrenetic'

  package { 'graphene':
    ensure => $version,
    provider => 'apt',
  }
}
