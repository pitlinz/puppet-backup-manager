/**
 * puppet module to install and manage backup manager
 * 
 * (c) 2015 by Peter Krebs
 * 
 * for detailed information of the variables please see at the template
 */
 
class backupmanager(
  # 01 repository
  $repository_root    = "/var/archives",
  $temp_dir           = "/tmp",
  $repository_user    = "root",
  $repository_group   = "root",
  $repository_chmod   = "0770",

  # 02 archives 
  $archive_chmod      = "0660",
  $archive_ttl        = "21",
  $archive_method     = ["tarball-incremental"], # at least on of 
                                                 # tarball, tarball-incremental, 
                                                 # mysql, pgsql, svn, pipe, none    
  # 10 tarball
  $tarball_directories    = "/etc /home /var/www",
  $tarball_dumpsymlinks   = "false", 
  $tarball_blacklist      = "cache",
  $tarball_extra_options  = "", 
  
  # 11 tarball-incremental
  $tarballinc_masterdatetype = "weekly",        # weekly or monthly
  $tarballinc_masterdatevalue= "1",
  
  # 15 mysql  
  $mysql_databases        = "__ALL__",
  $mysql_adminlogin       = "root",
  $mysql_adminpass        = "",
  $mysql_host             = "localhost",
  $mysql_port             = "3306",
  $mysql_filetype         = "gzip", # (gzip or bzip2)
  
  # 15 pgsql
  $pgsql_databases        = "__ALL__",
  $pgsql_adminlogin       = "root",
  $pgsql_adminpass        = "",
  $pgsql_host             = "localhost",
  $pgsql_port             = "5432",
  $pgsql_filetype         = "bzip2", # (gzip or bzip2)
  
  # 15 svm
  $svn_repositories       = "",
  $svn_compresswith       = "bzip2",

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

  # 40 burning
  $burning_method         = "none",
  $burning_device         = "/dev/cdrom",
  $burning_maxsize        = "650",

  # 90 advanced settings
  $pre_backup_command     = "",
  $post_backup_command    = "",
  
  
) {
  validate_array($archive_method)
  validate_array($upload_method)

  package{"backup-manager": 
    ensure => installed
  }
  
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
  
  concat::fragment { 'archives':
    target  => '/etc/backup-manager.conf',
    content => template("backupmanager/bm_cf_02_archives.erb"),
    order   => '02'    
  }  
  
  if member($archive_method,'tar') or member($archive_method,'tarball-incremental') {
	  concat::fragment { 'tarball':
	    target  => '/etc/backup-manager.conf',
	    content => template("backupmanager/bm_cf_10_tarball.erb"),
	    order   => '10'    
	  }      
  }
  
  if member ($archive_method,'tarball-incremental') {
    concat::fragment { 'tarball-incremental':
      target  => '/etc/backup-manager.conf',
      content => template("backupmanager/bm_cf_11_tarball_incremental.erb"),
      order   => '11'    
    }        
  }
  
  if member ($archive_method,'mysql') {
    concat::fragment { 'mysql':
      target  => '/etc/backup-manager.conf',
      content => template("backupmanager/bm_cf_15_mysql.erb"),
      order   => '15'    
    }        
  }  

  if member ($archive_method,'pgsql') {
    concat::fragment { 'pgsql':
      target  => '/etc/backup-manager.conf',
      content => template("backupmanager/bm_cf_15_pgsql.erb"),
      order   => '15'    
    }        
  }  
  
  if member ($archive_method,'svn') {
    concat::fragment { 'svn':
      target  => '/etc/backup-manager.conf',
      content => template("backupmanager/bm_cf_15_svn.erb"),
      order   => '15'    
    }        
  }
  
  if member ($archive_method,'pipe') {
    concat::fragment { 'svn':
      target  => '/etc/backup-manager.conf',
      content => template("backupmanager/bm_cf_15_pipe.erb"),
      order   => '15'    
    }        
  }    
  
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
  
  concat::fragment { 'burning':
    target  => '/etc/backup-manager.conf',
    content => template("backupmanager/bm_cf_40_burning.erb"),
    order   => '40'    
  }     
  
  concat::fragment { 'advanced':
    target  => '/etc/backup-manager.conf',
    content => template("backupmanager/bm_cf_90_advanced.erb"),
    order   => '90'    
  }      
  
}