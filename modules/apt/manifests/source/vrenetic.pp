class apt::source::vrenetic {

  apt::source { 'vrenetic':
    entries => [
      "deb [arch=amd64] http://debian-packages.vrenetic.io ${::facts['lsbdistcodename']} main",
    ],
    keys    => {
      'vrenetic' => {
        'key' => '4A45CD8B',
        'key_url' => 'http://debian-packages.vrenetic.io/conf/signing.key',
      }
    },
  }
}
