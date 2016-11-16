from gearman.worker import GearmanWorker

import os
import pytest
# import random
# import string
import sys

from _connection_conf import ConnectionConf

# char_set = string.ascii_lowercase + string.digits

def doit(worker, job):
    r=''
    try:
        i = int(job.data)
        # r = ''.join(random.sample(char_set * i, i))
        r = 'x' * i
        print "result length: %s" % (len(r))
    except Exception as ex:
        print ex
        r = str(ex)

    return r


def test_doit(request):
    c = ConnectionConf(request.config.option.host, request.config.option.port, request.config.option.ssl)
    worker = GearmanWorker(host_list=c.host_list())
    worker.set_client_id(
        '-'.join([os.path.basename(__file__), str(os.getpid())]))
    worker.register_task("doit", doit)
    worker.work()

if __name__ == '__main__':
    pytest.main()
