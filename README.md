# SnapBackup

## Summary

SnapBackup is a very lightweight backup framework designed from the ground up for simplicity and ease of extension and deployment. The codebase is kept very small on purpose and you should be able to start backing up filesystem, database, application and server data in only a few minutes.

Because SnapBackup is so modular, it is completely language agnostic and anyone with moderate programming skills can create new backup targets and storage connectors.

SnapBackup is still very much alpha software, but it has been in use in production on several servers that I manage for over a year. Expect things to change.

## Quick Start

By default, SnapBackup is configured to use Amazon's S3 service as it's configured storage connector. The connector uses the following ENV variables for it's configuration:

 * S3\_BUCKET\_NAME
 * AMAZON\_ACCESS\_KEY\_ID
 * AMAZON\_SECRET\_ACCESS\_KEY
 
When running the backup script, be sure to make sure that those variables are visible at the time of execution.

Once those variables are set up, you must enable policies. At the time of this writing, backup policies are stored in the `policies` directory in the same directory as the `snapbackup` executable. Example policies are stored in the `policies-available` directory. By symlinking policies into the `policies` directory, that enables them.

To run SnapBackup, execute the following as root:

    ./snapbackup
    
## About

SnapBackup is written by Spike Grobstein <spikegrobstein@mac.com>  
http://github.com/spikegrobstein/snapbackup  
http://spike.grobste.in  
http://sadistech.com  