class gstreamer::plugins::entrans {

  require 'apt::source::vrenetic'
  require 'gstreamer::plugins::base'

  package { 'gst-entrans':
    provider => 'apt',
  }
}
