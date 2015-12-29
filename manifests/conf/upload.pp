/**
 * configure the upload for backup-manager
 *
 *
 */
class backupmanager::conf::upload(
  # 30 upload
  $method          = "none", # scp ssh-gpg ftp rsync S3 none
  $hosts           = "",
  $destination     = "/var/archives/uploads",
  $user            = "bmgr",
  $passwd          = "",
  $ttl             = "60",

  $target		   = "/etc/backup-manager.conf"

) {

    include backupmanager::conf

  	concat::fragment { 'upload':
    	target  => $target,
    	content => template("backupmanager/bm_cf_30_upload.erb"),
    	order   => '30'
  	}

	if $method != 'none' {
	    case $method {
	        'scp': {
	        	include backupmanager::conf::upload::ssh
	        	}
			'ssh-pgp': {
				include backupmanager::conf::upload::ssh
			}
			'ftp': {
			    include backupmanager::conf::upload::ftp
			}
			's3': {
			    include backupmanager::conf::upload::s3
			}
			'rsync': {
			    include backupmanager::conf::upload::rsync
			}
	    }
	}

}


