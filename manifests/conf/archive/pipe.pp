/**
 * class to configure pipe archive method
 *
 */
class backupmanager::conf::archive::pipe(
	# 16 pipe
	$commands	= {
	    0 => {
		    command		=> undef,
		    filename	=> undef,
		}
	},

	$target   		= "${::backupmanager::conf::archive::target}",
) {

	concat::fragment { "${target}_pipe_init":
  		target  => $target,
  		content => template("backupmanager/bm_cf_16_pipe_init.erb"),
  		order   => '16'
	}

	$cmddefaults = {
	    'compress'	=> 'gzip',
		'target'	=> $target,
	}

	create_resources(::backupmanager::conf::archive::pipecommand, $commands, $cmddefaults)

	concat::fragment { "${target}_pipe_end":
  		target  => $target,
  		content => template("backupmanager/bm_cf_18_pipe_end.erb"),
  		order   => '18'
	}
}

define backupmanager::conf::archive::pipecommand(
    $command	= undef,
    $filename	= undef,
    $filetype	= undef,
    $compress	= "gzip",
    $target		= "${::backupmanager::conf::archive::target}",
) {

	if $command	!= undef {

	    validate_integer($name)
		concat::fragment { "${target}_pipe_command_${name}":
	  		target  => $target,
	  		content => template("backupmanager/bm_cf_17_pipe_commends.erb"),
	  		order   => '17'
		}
	}
}
