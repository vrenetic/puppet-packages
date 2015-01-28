class autoprefixer {

  require 'nodejs'

  package { 'autoprefixer':
    ensure   => '4.0.0',
    provider => 'npm',
  }

  package { 'caniuse-db':
    ensure   => '1.0.20140810',
    provider => 'npm',
  }
}
