# oracle-install-scripts

This project allows people to install oracledb in node through a script. (Currently works for `12.1.0.2.0`)
```
# Clone the repository
git clone http://j.ferrell@162.216.42.179:7990/scm/~j.ferrell/oracle-install.git
```

## MacOS Installation
* Download [Basic and SDK 64-bit ZIPs from Oracle Technology Network](http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html)
* execute the script using `./install-oracle.sh` in the same directory as the downloaded zip files from Oracle

## Windows Installation
* Download [Basic and SDK 64-bit ZIPs from Oracle Technology Network](http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html)
* [Install Chocolatey](https://chocolatey.org/install)
* Open CMD Prompt using <kbd>CTRL</kbd>+<kbd><font face=Wingdings>&#xff;</font></kbd>
* execute the sript using `runas /user:Administrator install-oracle.bat`
