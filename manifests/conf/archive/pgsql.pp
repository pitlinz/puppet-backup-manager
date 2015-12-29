/**
 * class to configure mysql archive method
 *
 */
class backupmanager::conf::archive::pgsql(
	# 15 pgsql
	$databases      = "__ALL__",
	$adminlogin     = "root",
	$adminpass      = "",
	$host           = "localhost",
	$port           = "5432",
	$filetype       = "bzip2", # (gzip or bzip2)
	$extra_options	= "",

	$target   		= "${::backupmanager::conf::archive::target}",
) {

	include ::backupmanager::conf::archive

    concat::fragment { "${target}_pgsql":
 		target  => $target,
  		content => template("backupmanager/bm_cf_15_pgsql.erb"),
  		order   => '15'
	}
}
