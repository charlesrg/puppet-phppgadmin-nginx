# phpPgAdmin Module with nginx support

Uwe Kleinmann <uwe@kleinmann.org>

This module installs phpPgAdmin with an accompanying nginx vhost via Puppet.
It is specifically for Ubuntu 12.10 and hasn't been tested with anything else.

# Usage
<pre>
  class { 'phpldapadmin':
    domain         => 'phppgadmin.example.com',
    pg_server_desc => 'My Postgres Server',
    pg_server_host => 'db.example.com',
    pg_server_port => 5432,
  }
</pre>
