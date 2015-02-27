class hornetq::config(
  $ensure = undef,
  $version = undef,
  $user = undef,
  $install_type = undef,
  $config_folder = undef,
  $data_folder = undef,
  $log_folder = undef,
  $java_home = undef,
  $jnp_host = undef,
  $jnp_port = undef,
  $rmi_port = undef,
  $min_mem = undef,
  $max_mem = undef,
  $debug = undef
){

  validate_re($version, '^[~+._0-9a-zA-Z:-]+$')
  $hornetq_major_version = regsubst($version, '^(\d+\.\d+).*','\1')
  notice("hornetq_major_version = ${hornetq_major_version}")
  $package_version = regsubst($hornetq_major_version, '\.', '', 'G')

  file { $config_folder :
    ensure => directory,
  }

  file { "${config_folder}/hornetq${package_version}-wrapper.conf":
    ensure  => $ensure,
    content => template("${module_name}/etc/hornetq/hornetq-wrapper.conf.erb"),
    require => File[$config_folder]
  }

}
