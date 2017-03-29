class gstreamer::plugins::ugly {

  require 'apt::source::vrenetic'
  require 'gstreamer::plugins::base'

  package { 'gstreamer1.0-plugins-ugly':
    provider => 'apt',
  }
}
