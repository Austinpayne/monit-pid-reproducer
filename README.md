# Monit daemon PID issue

This repo documents an issue with running monit in daemon mode. It appears monit
does not recover if its PID file exists but the process itself does not. To
reproduce, run the following in one terminal:

```bash
$ docker build -t monit .
$ docker create --name monit monit
$ docker start -a monit
```

In a second terminal:

```bash
$ docker kill --signal KILL monit
```

Back in the first terminal, start the container again and observe that monit
believes it is already running and quits immediately:

```bash
$ docker start -a monit
Monit daemon with PID 1 awakened
```

In a production system this can result in a container reboot loop.

A simple workaround in this case can be employed, build the `Dockerfile-workaround`
image instead and monit will start every time as expected.

Additionally, the `Dockerfile-latest` image reproduces the same issue.
