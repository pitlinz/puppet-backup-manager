/**
 * class to configure tarball archive method
 */
class backupmanager::conf::archive::tarball(
	# 10 tarball
	$directories    = "/etc /home /var/www",
	$dumpsymlinks   = "false",
	$blacklist      = "cache dump save bak",
	$extra_options  = "",

	$target   		= "/etc/backup-manager.conf",
) {

	include ::backupmanager::conf::archive

	concat::fragment { "${target}_tarball":
		target  => $target,
		content => template("backupmanager/bm_cf_10_tarball.erb"),
		order   => '10'
	}

}
