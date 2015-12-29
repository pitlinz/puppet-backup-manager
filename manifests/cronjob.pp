/**
 * configure cron-job to run backup manager
 */
class backupmanager::cronjob(
	$minute 	= "0",
	$hour		= "1",
) {
	file {"/etc/cron.d/backup-manager":
		content => "${minute} ${hour} * * * root /usr/sbin/backup-manager 2>&1 >> /var/log/backup-manager.log\n"
	}

}
