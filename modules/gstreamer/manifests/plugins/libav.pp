class gstreamer::plugins::libav {

  require 'apt::source::vrenetic'
  require 'gstreamer::plugins::base'

  package { 'gstreamer1.0-libav':
    provider => 'apt',
  }
}
