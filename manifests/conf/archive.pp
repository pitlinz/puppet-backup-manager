
class backupmanager::conf::archive(
  	# 02 archives
  	$archive_chmod      = "0660",
  	$archive_ttl        = "21",
  	$archive_method     = ["tarball-incremental"], # at least on of
   		                                           # tarball, tarball-incremental,
                                                   # mysql, pgsql, svn, pipe, none
	# 10 tarball
	$tarball_directories    = "/etc /home /var/www",
	$tarball_dumpsymlinks   = "false",
	$tarball_blacklist      = "cache",
	$tarball_extra_options  = "",

	# 11 tarball-incremental
	$tarballinc_masterdatetype = "weekly",        # weekly or monthly
	$tarballinc_masterdatevalue= "1",

	# 15 mysql
	$mysql_databases        = "__ALL__",
	$mysql_adminlogin       = "root",
	$mysql_adminpass        = "",
	$mysql_host             = "localhost",
	$mysql_port             = "3306",
	$mysql_filetype         = "gzip", # (gzip or bzip2)

	# 15 pgsql
	$pgsql_databases        = "__ALL__",
	$pgsql_adminlogin       = "root",
	$pgsql_adminpass        = "",
	$pgsql_host             = "localhost",
	$pgsql_port             = "5432",
	$pgsql_filetype         = "bzip2", # (gzip or bzip2)

	# 15 svm
	$svn_repositories       = "",
	$svn_compresswith       = "bzip2",
) {

	validate_array($archive_method)

    include backupmanager::conf
   	#Concat::Fragment{
   	#    require => Concat['/etc/backup-manager.conf']
   	#}

  	concat::fragment { 'archives':
    	target  => '/etc/backup-manager.conf',
    	content => template("backupmanager/bm_cf_02_archives.erb"),
    	order   => '02'
	}

	if member($archive_method,'tar') or member($archive_method,'tarball-incremental') {
		concat::fragment { 'tarball':
			target  => '/etc/backup-manager.conf',
			content => template("backupmanager/bm_cf_10_tarball.erb"),
			order   => '10'
	  	}
  	}

	if member ($archive_method,'tarball-incremental') {
		concat::fragment { 'tarball-incremental':
      		target  => '/etc/backup-manager.conf',
      		content => template("backupmanager/bm_cf_11_tarball_incremental.erb"),
      		order   => '11'
    	}
  	}

  	if member ($archive_method,'mysql') {
    	concat::fragment { 'mysql':
      		target  => '/etc/backup-manager.conf',
      		content => template("backupmanager/bm_cf_15_mysql.erb"),
      		order   => '15'
    	}
  	}

  	if member ($archive_method,'pgsql') {
    	concat::fragment { 'pgsql':
      		target  => '/etc/backup-manager.conf',
      		content => template("backupmanager/bm_cf_15_pgsql.erb"),
      		order   => '15'
    	}
  	}

  	if member ($archive_method,'svn') {
    	concat::fragment { 'svn':
      		target  => '/etc/backup-manager.conf',
      		content => template("backupmanager/bm_cf_15_svn.erb"),
      		order   => '15'
    	}
  	}

  	if member ($archive_method,'pipe') {
    	concat::fragment { 'svn':
      		target  => '/etc/backup-manager.conf',
      		content => template("backupmanager/bm_cf_15_pipe.erb"),
      		order   => '15'
    	}
  	}
}
