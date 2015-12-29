class backupmanager::conf::burning(
	# 40 burning
  	$burning_method         = "none",
  	$burning_device         = "/dev/cdrom",
  	$burning_maxsize        = "650",

  	$target					= "/etc/backup-manager.conf",
) {

    include backupmanager::conf
   	#Concat::Fragment{
   	#    require => Concat['/etc/backup-manager.conf']
   	#}

  	concat::fragment { 'burning':
    	target  => $target,
    	content => template("backupmanager/bm_cf_40_burning.erb"),
    	order   => '40'
  	}
}

