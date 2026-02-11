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


## VIM
1. Installation and Verification
	```bash
	# to install vim
	sudo dnf install vim -y

	#for verification and version detail
	vim --version
	```
	- for **debian and ubuntu** replace **dnf** with **apt**
	- for **arch** replace **dnf** with **pacman -S**

2. To create/open a file in vim
	```bash
	vim <filename>
	```

3. Basic Vim Keybindings
	```
	modes:
	i => insert mode
		used for text insertion
	v => visual mode 
		used for text selection
	Esc => normal mode
		used for text navigation
	
	
	Navigation:
	h 	=> left
	j 	=> down
	k 	=> up
	l 	=> right
	gg 	=> first line of the file
	G 	=> last line of the file	
	w 	=> next word
	b	=> previous word
	:<line number> 	=> move to the specified line number
	use of arrow keys is also supported


	exiting and saving vim:
	:q	=> exit (only works if file is not changed)
	:q!	=> force exit
	:wq => saving and exiting
	:w	=> saving the file
	
	```
For in depth vim usage please refer: [Vim book converted by Tomas Vasko ](http://www.truth.sk/vim/vimbook-OPL.pdf)


## Rust + Cargo + Rust Nightly

1. Installing stable Rust	
	```Bash
	# command to download and run the shell script installs Rust, cargo, and Rustup and adds the path to the environment
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

	#  to load Rust into the current shell, alternatively you could close and reopen the terminal
	. "$HOME/.cargo/env"
	```

2. Install Rust Nightly and rust-src
	```bash
	# nightly provides us with experimental features, and support for unstable language support 
  	rustup install nightly
	
	#  installs the rust source code, it comes with libraries that are essential for low level, bare metal programming
	rustup component add rust-src
	
	#  to load Rust into the current shell, alternatively you could close and reopen the terminal
	. "$HOME/.cargo/env"
	```

3. verify the installation
	```bash
	# shows version information for rustc which is the rust compiler
	rustc --version
  	
	# shows the version information for cargo which is the rust package managger
	cargo --version
	
	# shows the current active setup 
	rustup show
	```
	- the project should use the same version throughout the development phase
	- **cargo** : cargo 1.93.0 (083ac5135 2025-12-15)
	- **rustc** : rustc 1.93.0 (254b59607 2026-01-19)
	- **rustc nightly**: rustc 1.95.0-nightly (9e79395f9 2026-02-10)


4. **RUST NIGHTLY IMPORTANT**
	- DO NOT SET **_Rust Nightly as the default_** it is **_not recommended_**
	```bash
	# this make nightly default everywhere, not recommended
	rustup default nightly
	```
	- instead use rust nightly when necessary i.e the project folder only as shown below:

    ```bash
	# makes a new directory for the os
	mkdir my_os

	# navigating into that directory
	cd my_os

	# making it so that rust nightly is default only for this project folder and not the whole system
	rustup override set nightly
	```

5. Rust commands
	```bash
	# a new rust project
	cargo new my_project

	# existing project as a rust project
	cd existing_project
	cargo init

	# compile in debug mode
	cargo build

	# compile in release mode
	cargo build --release

	# compile and run in debug mode 
	cargo run

	# check if the code compiles
	cargo check

	# compile for a custom target 
	cargo build --target <custom file to compile to> 
	#for example if we want to compile to i686-unknown-none.json
	# this means using i686(32 bit architecture)
	# compile for bare metal programming no vendor
	# there is no os
	# as a json file
	cargo build --target i686-unknown-none.json

	# compile bare-metal + build core library 
	cargo build -Z build-std=core --target i686-unknown-none.json

	# testing in QEMU
	qemu-system-i386 -kernel <path to the binary file that needs to be tested>
	# says qemu to use 32 bit architecture
	# telling we are testing a kernel
	# and providing the path to the kernel binary file

	qemu-system-i386 -kernel target/i686-unknown-none/debug/my_os.bin
	# target/<target-name>/<build-mode>/<your-binary>
	# syntax:  creates a target folder within the main project with a sub folder and builds our binary there

	```