class puppet::common(
  $basemodulepath = '/etc/puppetlabs/code/modules'
) {

  require 'apt'

  helper::script { 'install puppet apt sources':
    content => template("${module_name}/install-apt-sources.sh"),
    unless  => "dpkg-query -f '\${Status}\n' -W puppetlabs-release-pc1 | grep -q 'ok installed'",
    require => Class['apt::update'],
  }

  file { ['/etc/puppetlabs', '/etc/puppetlabs/puppet', '/etc/puppetlabs/code']:
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0644',
  }

  file { '/etc/puppetlabs/puppet/conf.d':
    ensure  => directory,
    group   => '0',
    owner   => '0',
    mode    => '0644',
    purge   => true,
    recurse => true,
  }

  file { '/etc/puppetlabs/puppet/conf.d/main':
    ensure  => file,
    content => template("${module_name}/config"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Exec['/etc/puppetlabs/puppet/puppet.conf'],
  }

  exec { '/etc/puppetlabs/puppet/puppet.conf':
    command     => 'cat /etc/puppetlabs/puppet/conf.d/* > /etc/puppetlabs/puppet/puppet.conf',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
    require     => File['/etc/puppetlabs/puppet'],
  }

  ruby::gem {
    'deep_merge':
      ensure => present;

    'hiera-file':
      ensure => '1.1.0';

    'ipaddress':
      ensure => present;
  }
}
