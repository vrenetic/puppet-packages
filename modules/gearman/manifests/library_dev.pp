class gearman::library_dev {

  require 'apt'
  require 'apt::source::vrenetic'

  package { 'libgearman-dev':
    ensure   => present,
    provider => 'apt',
    require  => Class['apt::source::vrenetic'],
  }

}
