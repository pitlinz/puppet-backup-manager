/**
 * class to configure svn archive method
 *
 */
class backupmanager::conf::archive::svn(
	# 15 svm
	$repositories       = "",
	$compresswith       = "bzip2",

	$target   		= "${::backupmanager::conf::archive::target}",
) {

	validate_re($compresswith,['^bzip2$','^gzip$'])

	concat::fragment { 'svn':
  		target  => '/etc/backup-manager.conf',
  		content => template("backupmanager/bm_cf_15_svn.erb"),
  		order   => '15'
	}
}
