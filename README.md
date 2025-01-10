# WebX Development Workspace

## Description

This project regroups the [WebX Engine](https://github.com/ILLGrenoble/webx-engine), [WebX Router](https://github.com/ILLGrenoble/webx-router) and [WebX Session Manager](https://github.com/ILLGrenoble/webx-session-manager) projects into a single development workspace.

It uses a devcontainer to install a unified development environment with the necessary build and run dependencies (currently based on Ubuntu 22.04).

Primary use is aimed at a VSCode environment and Launch Commands are included to build, run and debug all three projects.

Testing of the WebX projects is most simply done by using the [WebX Demo Deploy](https://github.com/ILLGrenoble/webx-demo-deploy) project. This project runs the WebX Demo in a docker compose stack on the host machine: the WebX Router or WebX Engine processes can be reached directly through exposed ports in the devcontainer.

## Installation

Firstly, obtain the WebX Dev Workspace and the WebX Engine, Router and Session Manager submodules:

```
git clone --recursive https://github.com/ILLGrenoble/webx-dev-workspace.git
cd webx-dev-workspace
```

Make sure all projects are using the <em>dev</em> branch

```
cd webx-engine
git checkout dev
cd ../webx-router
git checkout dev
cd ../webx-session-manager
git checkout dev
cd ..
```

## Launching the devcontainer

Open the Dev Workspace project in VSCode and then run the command `Reopen in Container`. 

This will download the base webx-dev-env container from GitHub: ghcr.io/illgrenoble/webx-dev-env-ubuntu:22.04 and launch the `install.sh` script to:
 - install the Rust environment
 - Setup the Xorg configuration to allow users to run Xorg inside a container
 - Initialise the Web Router and Session Manager configs
 - Install some standard users for testing the multiuser environment

## Building, Running and Debugging the WebX Engine in standalone mode

The simplest way to start developing on WebX is the look at the WebX Engine. Running in <em>standalone</em> mode the Engine is run as the logged-in user and attaches to an X11 server. The devcontainer has Xorg and Xfce4 already running on DISPLAY=:20.

To build and run the WebX Engine run the VSCode Launch Command <em>Launch and Debug WebX Engine Standalone (:20)</em>. This will compile the webx-engine executable and launch it in standalone mode.

You can debug the WebX Engine by adding breakpoints to the source code.

### Testing the WebX Engine in standalone mode

On the host computer download the [WebX Demo Deploy](https://github.com/ILLGrenoble/webx-demo-deploy) project and launch it in standalone mode:

```
git clone https://github.com/ILLGrenoble/webx-demo-deploy
cd webx-demo-deploy
./deploy.sh -sh host.docker.internal
```

This runs and configures the webx-demo-server to attach to ports on the host computer.

Open a browser at https://localhost and you'll be able to connect to the WebX Engine directly.

## Building, Running and Debugging the full WebX server stack in multiuser mode

To develop the full WebX server stack, the first thing is to build the WebX Engine (if it hasn't already been done).

```
cd webx-engine
cmake .
cmake --build . -j 4 --target webx-engine
```

This ensures that the WebX Router has a valid WebX Engine executable.

To build and run the WebX Router, run the VSCode Launch Command <em>Launch and Debug WebX Router</em>. This will compile the webx-router executable and launch it. It should be correctly configured to communicate with the WebX Session Manager and launch the locally-built WebX Engine.

The WebX Session Manager is built and launched similarly: run the Launch Command <em>Launch and Debug WebX Session Manager</em>. Again the Session Manager should be correctly configured to authenticate users, launch Xorg and run Xfce4.

### Testing the full WebX server stack

On the host computer download the [WebX Demo Deploy](https://github.com/ILLGrenoble/webx-demo-deploy) project and launch it (by default in multiuser mode):

```
git clone https://github.com/ILLGrenoble/webx-demo-deploy
cd webx-demo-deploy
./deploy.sh
```

Open a browser at https://localhost and you'll be able set the WebX Host to `host.docker.internal`.

The development environment comes with a number of preconfigured users: (mario, luigi, peach, toad, yoshi and bowser) - the password for these users is the same as the username.

When you connect using these users you should see logs for the WebX Session Manager validating the login and launching Xorg and Xfce4. The WebX Router should also show logs of launching the WebX Engine for the user.

### Debugging WebX Engine in multiuser mode

Since the WebX Engine is launched by the WebX Router, we need to attach to a running process in order to debug it.

Use the VSCode launch command <em>Debug Running WebX Engine Process</em> and then filter the processes for `webx-engine`. The debugger should attach to the process and you can add breakpoints as you normally would to the webx-engine source.


