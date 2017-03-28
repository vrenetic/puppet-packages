class gstreamer::plugins::base {

  require 'apt::source::vrenetic'

  package { 'gstreamer1.0-plugins-base':
    provider => 'apt',
  }
}
