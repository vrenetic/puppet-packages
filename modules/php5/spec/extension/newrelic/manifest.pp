node default {

  class { 'php5::extension::newrelic':
    license_key                => 'xxxxx',
    appname                    => 'bar',
    enabled                    => false,
    browser_monitoring_enabled => true,
  }
}
