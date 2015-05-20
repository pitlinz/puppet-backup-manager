class backupmanager::conf::upload(
  # 30 upload
  $upload_method          = ["none"], # scp ssh-gpg ftp rsync S3 none
  $upload_hosts           = "",
  $upload_destination     = "/var/archives/uploads",
  $upload_user            = "bmgr",
  $upload_passwd          = "",
  $upload_ttl             = "60",

  # 35 uplssh
  $upload_ssh_key         = "",
  $upload_ssh_port        = "22",
  $upload_ssh_purge       = "false",

  # 36 uplssh-pgp
  $upload_sshgpg_recipient = "",

  # 37 uplftp
  $upload_ftp_secure      = "false",
  $upload_ftp_passive     = "true",

  # 38 upls3
  # $upload_user = accesskey
  # $upload_pass = secret
  # $upload_destination = bucket

  # 38 uprsync
  $rsync_directories      = "",
  $rsync_destination      = "",
  $rsync_hosts            = "",

) {
   	validate_array($upload_method)

    include backupmanager::conf
   	#Concat::Fragment{
   	#    require => Concat['/etc/backup-manager.conf']
   	#}

   	$upload_methods_string = join($upload_method,' ')

  	concat::fragment { 'upload':
    	target  => '/etc/backup-manager.conf',
    	content => template("backupmanager/bm_cf_30_upload.erb"),
    	order   => '30'
  	}

  	if member($upload_method,'ssh') or member($upload_method,'ssh-pgp') {
	  	concat::fragment { 'ssh':
	    	target  => '/etc/backup-manager.conf',
	    	content => template("backupmanager/bm_cf_35_ulssh.erb"),
	    	order   => '35'
	  	}
  	}

  	if member($upload_method,'ssh-pgp') {
    	concat::fragment { 'ssh-pgp':
      		target  => '/etc/backup-manager.conf',
      		content => template("backupmanager/bm_cf_36_ulssh-pgp.erb"),
      		order   => '36'
    	}
  	}

  	if member($upload_method,'ftp') {
    	concat::fragment { 'ftp':
      		target  => '/etc/backup-manager.conf',
      		content => template("backupmanager/bm_cf_37_ulftp.erb"),
      		order   => '37'
    	}
  	} elsif member($upload_method,'S3') {
    	concat::fragment { 'S3':
      		target  => '/etc/backup-manager.conf',
      		content => template("backupmanager/bm_cf_38_uls3.erb"),
      		order   => '38'
    	}
  	}

  	if member($upload_method,'rsync') {
    	concat::fragment { 'rsync':
      		target  => '/etc/backup-manager.conf',
      		content => template("backupmanager/bm_cf_38_ulrsync.erb"),
      		order   => '38'
    	}
  	}
}

