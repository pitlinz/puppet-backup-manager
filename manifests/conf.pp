/**
 * puppet module to install and manage backup manager
 *
 * (c) 2015 by Peter Krebs
 *
 * for detailed information of the variables please see at the template
 */

class backupmanager::conf(
  # 01 repository
  $repository_root    = "/var/archives",
  $temp_dir           = "/tmp",
  $repository_user    = "root",
  $repository_group   = "root",
  $repository_chmod   = "0770",

  # 90 advanced settings
  $pre_backup_command     = "",
  $post_backup_command    = "",

) {

    concat { '/etc/backup-manager.conf':
		ensure => present,
  	}

  	concat::fragment { 'head':
    	target  => '/etc/backup-manager.conf',
    	content => template("backupmanager/bm_cf_00_head.erb"),
    	order   => '00'
  	}

  	concat::fragment { 'repository':
    	target  => '/etc/backup-manager.conf',
    	content => template("backupmanager/bm_cf_01_repository.erb"),
    	order   => '01'
  	}

  	concat::fragment { 'advanced':
    	target  => '/etc/backup-manager.conf',
    	content => template("backupmanager/bm_cf_90_advanced.erb"),
    	order   => '90'
  	}

}
