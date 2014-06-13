Hello, I am peer-cnnctd.  I am a proof of concept implementation for connecting peers, allowing to easily spawn multiple peers.


# Why #

This has been built to quickly and easily check if the peer_cnnctr works when supplying multiple peers, without having to spawn a whole bunch of services.  It also serves as a minimal example case of how to hook up services using peer-cnnctr.


# Installation #

peer-cnnctd requires SBCL and QuickLisp.


## Installing SBCL ##

peer-cnnctd has been tested on `SBCL 1.1.17` on an amd64 linux architecture.  It is advised to install SBCL from [http://sbcl.org](the main page).  You may alternatively use your package manager to install SBCL, though those releases are often ill-maintained.

## Installing quicklisp ##

Install quicklisp from [http://quicklisp.org](their main site).  Follow the instructions supplied there and follow the hints given on your screen.

## Installing peer-cnnctd ##

Installing peer-cnnctd can be done by fetching the sources [http://github.com/tenforce/ddcat-peer-cnnctd/](from github) and installing them in QuickLisp's local-projects directory.

> `cd ~/quicklisp/local-projects`
> `git clone git@github.com:tenforce/didicat-peer-cnnctd.git`


# Usage #

Management of peer-cnnctd is done through SBCL's REPL.

Boot up sbcl

> `sbcl`

Load up peer-cnnctd

> `(ql:quickload :peer-cnnctd)`

Set the path where the peer-cnnctr is running (the standard path assumes we have a peer_cnnctr running on `http://localhost:3001`.

> `(setf peer-cnnctd:*peer-cnnctr-path* "http://localhost:3000")`

set our own hostname (so peer_cnnctr can find us and talk to us)

> `(setf peer-cnnctd:*peer-cnnctd-hostname* "localhost")`

Surf to the peer_cnnctr and ensure that the `didicat` group exists (we spawn all peer in that group).  Don't close that REPL just yet, launch this in a separate terminal.

> `lynx http://localhost:3001/peer_groups/new  # or use a real web browser`

Example: spawn a single server on port `5000`

> `(peer-cnnctd:start-server 5000)`

or start a server on each port between `5001` and `5050`.

> `(loop for port from 5001 to 5050 do (peer-cnnctd:start-server port))`

You can see what is running on a server by visiting its `/server`

> `lynx http://localhost:5001/server # no really, there are browsers which display stuff`

or fetch all connected peers from all servers by visiting `/peers`

> `wget http://localhost:5001/peers # this is json, so you don't need a real browser`


# License #

peer-cnnctd was built for TenForce and is distributed under the Apache 2.0 license.  See license.md.

