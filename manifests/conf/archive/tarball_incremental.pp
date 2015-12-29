/**
 * class to configure tarball-incremental archive method
 *
 */
class backupmanager::conf::archive::tarball_incremental(
	# 11 tarball-incremental
	$masterdatetype = "weekly",        # weekly or monthly
	$masterdatevalue= 6,			   # day of week

	$target   		= "${::backupmanager::conf::archive::target}",
) {

	validate_re($masterdatetype,[ '^weekly$' , '^montly$' ])
	validate_integer($masterdatevalue,6,0)

	include ::backupmanager::conf::archive::tarball

	concat::fragment { "${target}_tarball-incremental":
		target  => $target,
		content => template("backupmanager/bm_cf_11_tarball_incremental.erb"),
		order   => '11'
	}

}
