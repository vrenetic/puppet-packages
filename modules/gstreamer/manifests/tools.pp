class gstreamer::tools {

  require 'apt::source::vrenetic'

  package { 'gstreamer1.0-tools':
    provider => 'apt',
  }
}
