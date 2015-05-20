/**
 * puppet module to install and manage backup manager
 *
 * (c) 2015 by Peter Krebs
 *
 * for detailed information of the variables please see at the template
 */

class backupmanager(

) {

	if !defined(Package["backup-manager"]) {
 		package{"backup-manager":
    		ensure => installed
  		}
  	}

}
