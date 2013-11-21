node default {

  class {'lvm::install':
    physicalDevices => ['/dev/sda5'],
    volumeGroupName => 'vg01',
    logicalVolumeName => 'storage01',
    logicalVolumeSize => '50%',
    logicalVolumeMountpoint => '/raid',
    expandTools => ['lvm::expand::raid::adaptec'],
  }
}