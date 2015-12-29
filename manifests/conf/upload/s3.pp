/**
 * add s3 upload to backupmanager conf
 *
 * $upload_user 		is used for S3_ACCESS_KEY
 * $upload_passwd		is used for S3_SECRET_KEY
 * $upload_destination	is used for S3_BUCKET
 */
class backupmanager::conf::upload::s3(

) {
	concat::fragment {'S3':
		target  => '/etc/backup-manager.conf',
		content => template("backupmanager/bm_cf_38_uls3.erb"),
		order   => '38'
	}

	if !defined(Package['libnet-amazon-perl']) {
	    package{'libnet-amazon-perl': ensure => latest}
	}
	if !defined(Package['libnet-amazon-s3-perl']) {
	    package{'libnet-amazon-s3-perl': ensure => latest}
	}
	if !defined(Package['libnet-amazon-s3-tools-perl']) {
	    package{'libnet-amazon-s3-tools-perl': ensure => latest}
	}

	/*
	file_line{'environment.AWS_ACCESS_KEY_ID':
	    path => "/etc/environment",
		line => "AWS_ACCESS_KEY_ID=\"${upload_user}\"\n",
	}
	file_line{'environment.AWS_ACCESS_KEY_SECRET':
	    path => "/etc/environment",
		line => "AWS_ACCESS_KEY_SECRET=\"${upload_passwd}\"\n",
	}
	*/
}
