/**
 * add ftp upload to backupmanager conf
 */
class backupmanager::conf::upload::ftp(
	# 37 uplftp
	$ftp_secure			= "false",
	$ftp_passive		= "true",

	$ftp_hosts			= $::backupmanager::conf::upload::hosts,
	$ftp_user			= $::backupmanager::conf::upload::user,
	$ftp_passwd			= $::backupmanager::conf::upload::passwd,
	$ftp_ttl			= $::backupmanager::conf::upload::ttl,
	$ftp_destination	= "/",

	$target   			= "${::backupmanager::conf::upload::target}",
) {

	concat::fragment { 'ftp':
		target  => $target,
		content => template("backupmanager/bm_cf_37_ulftp.erb"),
		order   => '37'
	}
}
