# Grid Caching System- GCS

[![N|Solid](https://i.imgur.com/x37NfvT.png)](https://i.imgur.com/x37NfvT.png)

Grid Caching System (GCS) is a system where the objective is to allow missions creators to use more intensively vehicles and AI with a lower impact on performance by dynamically spawning these.
Optionally, a persistence system is also integrated with GCS.

# Features

  - Dynamic grid allowing better performances by caching unused AI or vehicles
  - Integrated persistence system (optionnal)

# How it works

GCS adds a grid to the field based on three configurable parameters:

    GCS_VAR_SIZE_SQUARE_GRID            - Represents the total size of each grid
    GCS_VAR_SIZE_ACTIVATION_SQUARE_GRID - Represents the trigger distance where AIs and vehicles will be created
    GCS_VAR_SIZE_UNSPAWN_SQUARES        - Represents the trigger distance where AIs and vehicles will be cached and removed

Here is a simple 2D visual representation of a single grid square:
[![N|Solid](https://i.imgur.com/QpyUlN9.png)](https://i.imgur.com/QpyUlN9.png)

All the AI units and vehicles inside the black square will be spawned if one or more player enter the red square (activation area). If all the players leaves the blue square (unspawn area), then all the AI units and vehicles in the black square will be cached and unspawned.

Ideally, the distance between GCS_VAR_SIZE_SQUARE_GRID and GCS_VAR_SIZE_ACTIVATION_SQUARE_GRID must be large enough to prevent the player from seeing the spawn of AI units and objects, this will depend heavly on type of map though. Also, the distance between GCS_VAR_SIZE_ACTIVATION_SQUARE_GRID and GCS_VAR_SIZE_UNSPAWN_SQUARES must be large enough too to avoid players spawning and unspawning the AI units and vehicles all the time (or cause a potentially problematic desynchronisation between the cached data and the spawned data).

### Persistence

By default, GCS will use in-memory caching, this means that all the data will simply be stored in local array.
This can be used as long as your usage of this system is link to the mission life time (ie. until the mission is changed or the server shutdown). However if you want to add persistent data caching, then you can use the database system that is proposed with GCS. This "simple" switch simply will store all the in-memory array in a database table.

This will allow the system to retrieve the cached data even after a server shutdown, mission change. This can be very helpfull if your mission is designed to have a long duration (ie. survival mods, liberation-like mission, ...).

If your mission already use a database, then you can simply add a new table into it and get started, very non-intrusive!

## Installation

1. Download the latest release 
2. Copy the /gcs_functions folder into your mission root directory. (ie. /MyMission.Stratis/)
3. Copy the following files into your mission root directly :
3.1 GCS_configServer.sqf
3.2 initGridCachingSystem.sqf
4. Copy the content of the initServer.sqf in your own initServer.sqf. The content idealy must be at the begining of the file. (if you don't have this file already, just copy the file in the root directory of your mission).
5. Play!

## Additionnal configuration
#### Grid configuration
You can adapt the size of the different sizes of each square grid parameter in the initGridCachingSystem.sqf:
```
// Grid cells parameters
GCS_VAR_SIZE_SQUARE_GRID = 500;
GCS_VAR_SIZE_ACTIVATION_SQUARE_GRID = 1500;
GCS_VAR_SIZE_UNSPAWN_SQUARES = 2000;
```

#### Persistence system configuration
You can enable the persitence system by realising a few steps:

#### 1. MySQL installation
First, you need to install MySQL Server on your server or computer, if you already have an instance of MySQL running, please go to step 2.
You first need to download the MySQL Community Installer from the following uri: https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-web-community-5.7.30.0.msi

Run the .msi file to install the MySQL installer as an administrator (!) Once the installer launched, select "Custom" setup type then click on Next:

[![N|Solid](https://i.imgur.com/QY4hAGi.png)](https://i.imgur.com/QY4hAGi.png)

Now, make sure to select both, MySQL Server 8.0.020 - X64 (or newest) under MySQL Servers and Connector/NET 8.0.20 - X86 (or newest) under MySQL Connectors then click on Next and Execute.

[![N|Solid](https://i.imgur.com/wege804.png)](https://i.imgur.com/wege804.png)

Once the installation is finished, click on next until the Type and Networking screen, here make sure to select "Server computer" on the Config Tab selection item then click on next

[![N|Solid](https://i.imgur.com/UMtu8Xf.png)](https://i.imgur.com/UMtu8Xf.png)

On the Authentication Method tab, make sure (this is critical) to select "Use Legacy Authentication Method (Retain MySQL 5.x Compatibility) then click on Next.
This is because InterceptDB will not work with SHA-256 based passwords.

[![N|Solid](https://i.imgur.com/X3T3RQG.png)](https://i.imgur.com/X3T3RQG.png)

Now it's time to create a root user for MySQL and a user for the Grid Caching System.
Use a strong password for the root user, please take note of this password, you will need it later and click on OK.

Now click on Next, Next, and Execute. MySQL will now install itself your computer or server.

#### 2. Database installation and configuration
You can now go into the mission folder and go into the databaseInstaller.
Right click on installer and select "Run with PowerShell". This will create the database required for the Grid Caching System, now complete the form:

[![N|Solid](https://i.imgur.com/EmKUtuA.png)](https://i.imgur.com/EmKUtuA.png)

Once all the information are entered, you will shortly have a message stating if the database installation was a success or not. 

#### 3. InterceptDB installation and configuration
First, download the latest release of InterceptDB at the following uri: https://github.com/intercept/intercept-database/releases (thanks to Dedmen)
Unzip the downloaded file (@InterceptDB.zip or @InterceptDB_linux_exp.zip based on your operating system)
(optional)Move the @InterceptDB folder to your mods directory, for example: C:\SteamLibrary\steamapps\common\Arma 3\@InterceptDB
Now, edit the config.yaml "accounts" part as follow:

accounts:
 maindb:
  ip: localhost
  username: root
  password: StrongPassword
  database: GCSARMA
  port: 3306
  
Update your ip, username and password as configured during part 1 "Accounts and Roles" picture.

Once the config.yaml is updated, add the move to Arma 3 or Arma 3 server.

For Arma 3, go to the Arma 3 Launcher -> Mods -> Local mod, select the @InterceptDB folder and click on "Activate mod" on the launcher once it's installed.
For Arma 3 Server, update your startup properties, for more informations about that, please refere the to "ADDONS & MODS" on this tutorial: https://forums.bohemia.net/forums/topic/139003-tutorial-installation-configuration-of-arma3-dedicated-server/

Please, note that CBA is required for InterceptDB.

#### 4. Enable persistent storage on the mission configs
Go into the mission folder, edit the gcs_configServer.sqf file and set the variable "GCS_VAR_GRIDSYSTEM_ENABLE_DATABASE" to true.