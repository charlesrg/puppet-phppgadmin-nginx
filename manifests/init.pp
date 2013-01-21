class phppgadmin(
  $domain = $::fqdn,
  $pg_server_desc = 'PostgreSQL Server',
  $pg_server_host = 'localhost',
  $pg_server_port = 5432,
) {
  # TODO: Change to arrays, so that multiple servers can be used.

  package { 'php5-pgsql':
    ensure => present,
    name   => 'php5-pgsql',
  }

  package { 'phppgadmin':
    ensure   => present,
    name     => 'phppgadmin',
    provider => 'dpkg',
    source   => '/tmp/phppgadmin_5.0.4_all.deb',
    require  => File['phppgadmin-package'],
  }

  file { 'phppgadmin-package':
    ensure  => 'present',
    path    => '/tmp/phppgadmin_5.0.4_all.deb',
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    source  => 'puppet:///modules/phppgadmin/phppgadmin_5.0.4_all.deb',
  }

  file { 'phppgadmin-nginx-vhost':
    ensure  => 'present',
    path    => '/etc/nginx/conf.d/phppgadmin_vhost.conf',
    owner   => 'root',
    group   => 'root',
    mode    => 0600,
    content => template('phppgadmin/nginx_vhost.erb'),
  }

  file { 'phppgadmin-configuration':
    ensure  => 'present',
    path    => '/var/www/phppgadmin/conf/config.inc.php',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => 0644,
    content => template('phppgadmin/config.php.erb'),
    require => Package['phppgadmin'],
  }
}
