from gearman.client import GearmanClient
from gearman.job import GearmanJobRequest

from _connection_conf import ConnectionConf

def test_doit(request):
    start = int(request.config.option.start)
    iteration = int(request.config.option.iteration)

    c = ConnectionConf(request.config.option.host, request.config.option.port, request.config.option.ssl)
    client = GearmanClient(host_list=c.host_list())
    for i in range(1, iteration + 1):
        j = start + i
        r = client.submit_job("doit", str(j))
        assert(type(r) is GearmanJobRequest)
        assert(r.complete is True)
        assert(len(r.result) == j)


if __name__ == '__main__':
    pytest.main()
