/**
 * class to configure mysql archive method
 *
 */
class backupmanager::conf::archive::mysql(
	# 15 mysql
	$databases      = "__ALL__",
	$adminlogin     = "root",
	$adminpass      = "",
	$host           = "localhost",
	$port           = "3306",
	$filetype       = "gzip", # (gzip or bzip2)
	$extra_options	= "",

	$target   		= "${::backupmanager::conf::archive::target}",
) {

	include ::backupmanager::conf::archive

    concat::fragment { "${target}_mysql":
 		target  => $target,
  		content => template("backupmanager/bm_cf_15_mysql.erb"),
  		order   => '15'
	}
}
