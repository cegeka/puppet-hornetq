class hornetq::package(
  $version = undef,
  $versionlock = false
){

  validate_re($version, '^[~+._0-9a-zA-Z:-]+$')
  validate_bool($versionlock)

  $hornetq_major_version = regsubst($version, '^(\d+\.\d+).*','\1')
  $package_version = regsubst($hornetq_major_version, '\.', '', 'G')

  package { "hornetq${package_version}":
    ensure => $version
  }

  case $versionlock {
    true: {
      yum::versionlock { "0:hornetq${package_version}-${version}.*": }
    }
    false: {
      yum::versionlock { "0:hornetq${package_version}-${version}.*": ensure => absent }
    }
    default: { fail('Class[Hornetq::Package]: parameter versionlock must be true or false') }
  }

}
