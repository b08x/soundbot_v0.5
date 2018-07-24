mysql role
----------

This role installs and configures MariaDB.


This configuration is pretty specific to RedHat (centos) based distros. If yer looking to user another distro, add a task called 'setup-$DISTRO.yml' and set the distro specifc vars in vars/$DISTRO.yml