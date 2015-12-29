
class backupmanager::conf::archive(
  	# 02 archives
  	$chmod      = "0660",
  	$ttl        = "21",
  	$method     = "tarball-incremental", # at least on of
   		                                 # tarball, tarball-incremental,
                                         # mysql, pgsql, svn, pipe, none

	$target		= "/etc/backup-manager.conf",

) {

    include backupmanager::conf

	if is_array($method) {
		$methods_string = join($method,' ')
		$method_arr		= $method
	} else {
	    $methods_string = $method
	    $method_arr		= split($method, ' ')
	}

  	concat::fragment { "${target}_archives":
    	target  => $target,
    	content => template("backupmanager/bm_cf_02_archives.erb"),
    	order   => '02'
	}

	if member($method_arr,'tar') {
		include ::backupmanager::conf::archive::tarball
  	}

	if member ($method_arr,'tarball-incremental') {
	    include ::backupmanager::conf::archive::tarball_incremental
  	}

  	if member ($method_arr,'mysql') {
		include ::backupmanager::conf::archive::mysql
  	}

  	if member ($method_arr,'pgsql') {
		include ::backupmanager::conf::archive::pgsql
  	}

  	if member ($method_arr,'svn') {
		include ::backupmanager::conf::archive::svn
  	}

  	if member ($method_arr,'pipe') {
		include ::backupmanager::conf::archive::pipe
  	}
}
