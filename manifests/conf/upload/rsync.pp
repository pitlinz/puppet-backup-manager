/**
 * configure rsync upload to backupmanager conf
 *
 * $directories	Which directories should be backuped with rsync
 *
 */
class backupmanager::conf::upload::rsync(
	# 38 uprsync
	$directories      = "",
	$destination      = "${::backupmanager::conf::upload::destination}",
	$hosts            = "${::backupmanager::conf::upload::hosts}",
	$target			  = "/etc/backup-manager.conf",
) {

	concat::fragment { 'rsync':
		target  => $target,
		content => template("backupmanager/bm_cf_38_ulrsync.erb"),
		order   => '38'
	}

}
