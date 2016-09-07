define daemon (
  $binary,
  $args = '',
  $user = 'root',
  $stop_timeout = 20,
  $nice = undef,
  $oom_score_adjust = undef,
  $env = { },
  $limit_nofile = undef,
  $limit_fsize = undef,
  $limit_cpu = undef,
  $limit_as = undef,
  $limit_rss = undef,
  $limit_nproc = undef,
  $core_dump = false,
  $sysvinit_kill = false,
  $pre_command = undef,
  $post_command = undef,
  $runtime_directory = undef,
  $runtime_directory_mode = undef,
) {

  $virtual = $::facts['virtual']
  $service_provider = $::facts['service_provider']

  if (defined(User[$user])) {
    User[$user] -> Daemon[$name]
  }

  if ($virtual == 'docker') {
    file { "/docker-run-${name}":
      ensure  => file,
      content => template("${module_name}/docker.sh.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0755',
    }

  } else {
    service { $name:
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }

    if ($service_provider == 'debian') {
      sysvinit::script { $name:
        content => template("${module_name}/sysvinit.sh.erb"),
      }

      File <| title == $binary or path == $binary |> {
        before => Sysvinit::Script[$title],
      }

    }

    if ($service_provider == 'systemd') {
      
      systemd::service { $name:
        content => template("${module_name}/systemd.service.erb"),
      }

      File <| title == $binary or path == $binary |> {
        before => Systemd::Service[$name],
      }
    }

    @monit::entry { $name:
      content => template("${module_name}/monit.${service_provider}.erb"),
      require => Service[$name],
    }
  }

}
