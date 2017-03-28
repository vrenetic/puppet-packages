class raid::sas2ircu {

  require 'apt'
  require 'apt::source::vrenetic'
  require 'python'

  package { 'sas2ircu':
    provider => 'apt',
  }

  file { '/usr/local/sbin/sas2ircu-status':
    ensure  => file,
    content => template("${module_name}/sas2ircu/sas2ircu-status"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => Package['sas2ircu'],
  }

  @monit::entry { 'raid-sas':
    content => template("${module_name}/sas2ircu/monit"),
    require => File['/usr/local/sbin/sas2ircu-status'],
  }
}
