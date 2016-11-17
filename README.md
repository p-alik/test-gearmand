this repo is for testing purposes of [gearmand](http://gearman.org)
----

USAGE
----
```bash
cd python
cp bin/_connection_conf.py.sample bin/_connection_conf.py
# setup SSL configuration in bin/_connection_conf.py
./bin/run-client.sh --port 4731 --host localhost --ssl --iteration 10 --start 1000 --timeout 10
./bin/run-worker.sh --port 4731 --host localhost --ssl
```
