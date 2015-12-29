class backupmanager::conf::upload::ssh(
  # 35 uplssh
  $ssh_key     = "",
  $ssh_port    = "22",
  $purge       = "false",

  # 36 uplssh-pgp
  $gpg_recipient = '',

) {
    include backupmanager::conf::upload

  	concat::fragment { 'ssh':
    	target  => '/etc/backup-manager.conf',
    	content => template("backupmanager/bm_cf_35_ulssh.erb"),
    	order   => '35'
  	}

  	if $gpg_recipient != '' {
    	concat::fragment { 'ssh-pgp':
      		target  => '/etc/backup-manager.conf',
      		content => template("backupmanager/bm_cf_36_ulssh-pgp.erb"),
      		order   => '36'
    	}
	}
}
