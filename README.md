this repo is for testing purposes of [gearmand](http://gearman.org)
----

USAGE
----

Perl
----

```bash
cd perl
cp lib/EnvCheck.pm.sample lib/EnvCheck.pm
# setup SSL configuration in lib/EnvCheck.pm
./bin/run-worker.sh --port 4731 --timeout 3
./bin/run-client.sh --port 4731 --start 100000000 --iteration 20 --timeout 3
```

Python
----


```bash
cd python
cp bin/_connection_conf.py.sample bin/_connection_conf.py
# setup SSL configuration in bin/_connection_conf.py
./bin/run-client.sh --port 4731 --host localhost --ssl --iteration 10 --start 1000 --timeout 10
./bin/run-worker.sh --port 4731 --host localhost --ssl
```
