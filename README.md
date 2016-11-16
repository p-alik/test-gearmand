this repo is for testing purposes of [gearmand](http://gearman.org)
----

USAGE
----
```bash
cd python
./bin/run-client.sh --port 4731 --host localhost --ssl --iteration 10 --start 1000 --timeout 10
./bin/run-worker.sh --port 4731 --host localhost --ssl
```
