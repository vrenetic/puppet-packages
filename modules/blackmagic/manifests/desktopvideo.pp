class blackmagic::desktopvideo {

  $version = '10.6.2a3'

  include 'apt'
  include 'kernel::headers'

  package { ['libgl1-mesa-glx']:
    ensure   => present,
    provider => 'apt',
  }

  $deb_url = 'http://puppet-packages.vrenetic.io/blackmagic/desktopvideo_10.6.2a3_amd64.deb'

  helper::script { 'install blackmagic desktopvideo':
    content => template("${module_name}/desktopvideo/install.sh.erb"),
    unless  => "dpkg-query -f '\${Status} \${Version}\n' -W desktopvideo | grep -q 'ok installed ${version}'",
    timeout => 1000,
    require => [
      Class['apt::update'],
      Class['kernel::headers'],
      Package['libgl1-mesa-glx'],
    ]
  }

  file { 'blackmagic-firmware-status':
    ensure  => file,
    path    => '/usr/local/bin/blackmagic-firmware-status',
    content => template("${module_name}/desktopvideo/firmware-status.sh"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => Helper::Script['install blackmagic desktopvideo'],
  }

  @monit::entry { 'blackmagic-firmware-status':
    content => template("${module_name}/desktopvideo/firmware-status-monit.conf"),
    require => File['blackmagic-firmware-status'],
  }

}
