/**
 * puppet module to install and manage backup manager
 *
 * (c) 2015 by Peter Krebs
 *
 * for detailed information of the variables please see at the template
 */

class backupmanager::conf(
  $conffile			 = '/etc/backup-manager.conf',

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

    concat { "${conffile}":
		ensure => present,
  	}

  	concat::fragment { "${conffile}head":
    	target  => "${conffile}",
    	content => template("backupmanager/bm_cf_00_head.erb"),
    	order   => '00'
  	}

  	concat::fragment { "${conffile}_repository":
    	target  => "${conffile}",
    	content => template("backupmanager/bm_cf_01_repository.erb"),
    	order   => '01'
  	}

  	concat::fragment { "${conffile}_advanced":
    	target  => "${conffile}",
    	content => template("backupmanager/bm_cf_90_advanced.erb"),
    	order   => '90'
  	}

}
