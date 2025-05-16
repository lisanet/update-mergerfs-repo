## 📦 Local APT Repository for [mergerfs](https://github.com/trapexit/mergerfs)

This repository provides a shell script and accompanying `systemd` unit files to automatically create and update a **local Debian APT repository** with the latest compatible `mergerfs` `.deb` package from GitHub Releases.


### ✅ Features

* Automatically detects your Debian version (e.g., `bookworm`, `bullseye`) and architecture (e.g. `amd64`)
* Downloads the latest `.deb` for your version from [trapexit/mergerfs](https://github.com/trapexit/mergerfs/releases)
* Builds a local APT repo in `/usr/local/aptrepo/mergerfs`
* Adds the corresponding `local-mergerfs.list` file  in `/etc/apt/sources.list.d`
* Automatically removes outdated `.deb` files
* Runs weekly via a `systemd` timer
* Works seamlessly with `apt update` and `apt upgrade` for updates od mergerfs


### 📁 Files

| File | Description 
| --- | --- |
| `update-mergerfs-repo` | main script to create/update the local repo |
| `update-mergerfs-repo.service` | systemd service to run the script |
| `update-mergerfs-repo.timer` | systemd timer to schedule weekly execution |
| `install.sh` | install script|


### 🛠 Requirements

Ensure the following packages are installed:

```
sudo apt install curl jq dpkg-dev lsb-release
```


### 🚀 Installation

1. **Clone this repo**

   ```
   git clone https://github.com/lisanet/update-mergerfs-repo.git
   ```
   
2. **Run the install script**

 First ensure that the install.sh script is executable,

 ```
 cd update-mergerfs-repo
 chmod a+x install.sh
 ```

 then run it:

 ```
 sudo ./install.sh
 ```
 This copies the updater script to `/usr/local/bin`, installs the systemd files into `/etc/systemd/system` and enables the systemd timer. 


### 🧪 Usage

The updater script will run once a week, looking for updated packages and donwloads them if necessary. You can use `apt update`, `apt list --upgradable` and `apt upgrade` as usual.  

You can trigger an update of the local mergerfs repo anytime. It's recommend to do this right after installation.

```
sudo systemctl start update-mergerfs-repo.service
```


### 📂 Local Repository Location

After a successful run, the local repo is available at `/usr/local/aptrepo/mergerfs`. The corresponding sources.list file is automatically added to `/etc/apt/sources.list.d/local-mergerfs.list` with the following contents:

```text
deb [trusted=yes] file:///usr/local/aptrepo/mergerfs stable main
```


### 🧼 Uninstall

To fully unistall the script, timer, service, and the local repo and sources.list file:

```
sudo systemctl disable --now update-mergerfs-repo.timer
sudo rm /etc/systemd/system/update-mergerfs-repo.{service,timer}
sudo rm /usr/local/bin/update-mergerfs-repo
sudo rm -rf /usr/local/aptrepo/mergerfs
sudo rm /etc/apt/sources.list.d/local-mergerfs.list
```

Finally update your apt sources list:

```
sudo apt update
```

### 📬 License

BSD 2-clause – free to use, modify, and distribute.


### 🤝 Contributing

Contributions, bug reports, and feature requests are welcome. Please open an issue or submit a pull request if you have any improvements or suggestions.


### ⚠️ Disclaimer

update-mergerfs-repo is provided **"as is"** without any warranty. Use at your own risk. Always ensure that you have current backups of your data.

