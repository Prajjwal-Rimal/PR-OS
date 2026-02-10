# Developer Guide

This is a  **_installation and verification_** guidelines for the tools used in this project

##  Git
1. Install and verify the version
	```bash
	# to install git via the terminal
	sudo dnf install git -y

	# to verify git version
	git --version
	```

	- for **debian and ubuntu** replace **dnf** with **apt**
	- for **arch** replace **dnf** with **pacman -S**

2. setup and verification of username and user email
	```bash
	# to set username and email
	git config --global user.name "username"
	git config --global user.email "email@email.com"

	# to check username and email
	git config --global user.name
	git config --global user.email
	```

	- the user **email** should be the **same as the one used in GitHub** account

3. setup of ssh key
	```bash
	# to set up ssh 
	ssh-keygen -t ed25519
	```

	- this generates a **private** and a **public** file 
	- add the **_public file_** to the GitHub account
	- it is **_recommended to use ssh_**

4. Cloning a remote repository to the local device
	```bash
	# this is to clone a remote repository to the local disk
	git clone <ssh_link>
	```

5. Commands
	```bash
	# to get changes from the remote repository and merge them to the local machine
	git pull

	# tells the status of new, changed, or unchanged files
	git status

	# adds all the newly created, modified, and deleted files into 	the staging area
	git add .

	# adds the specific files to the staging area
	git add <file_name>

	# commits the changes in the staging area with message
	git commit -m "enter the commit message"

	# opens an text editor (vim, nano) to write the commit message for the staging area
	git commit 

	# creates a tag with a message for the commit, useful for versioning
	git tag -a <tag_number> -m "tag message"

	# pushes the specified tag to the remote repository
	git push origin <tag_number>

	# pushes the committed changes to the remote repository sometimes the main branch is also known as master
	git push origin main

	# shows the detailed information about the tag
	git show <tag_number>

	# shows all the tag that are in the repository
	git tag

	# shows the commit history
	git log
	```