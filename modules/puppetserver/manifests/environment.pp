define puppetserver::environment (
  $manifest   = undef,
  $puppetfile = undef,
) {

  include 'puppetserver'

  $directory = "/etc/puppetlabs/code/environments/${name}"
  $data_directory = "${directory}/hieradata"

  file { [$directory, "${directory}/manifests", "${directory}/modules", $data_directory]:
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0644',
  }

  file { "${directory}/hiera.yaml":
    ensure  => file,
    content => template("${module_name}/puppet/hiera.yaml"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    before  => Package['puppetserver'],
    notify  => Service['puppetserver'],
  }

  file { "${data_directory}/common.yaml":
    ensure  => file,
    content => template("${module_name}/puppet/common.yaml"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    before  => Package['puppetserver'],
    notify  => Service['puppetserver'],
  }

  if ($manifest) {
    file { "${directory}/manifests/site.pp":
      ensure  => file,
      content => $manifest,
      group   => '0',
      owner   => '0',
      mode    => '0644',
      before  => Package['puppetserver'],
      notify  => Service['puppetserver'],
    }
  }

  if ($puppetfile) {
    puppet::puppetfile { $directory:
      content => $puppetfile,
      require => File["${directory}/modules"],
      before  => Package['puppetserver'],
      notify  => Service['puppetserver'],
    }
  }

}
