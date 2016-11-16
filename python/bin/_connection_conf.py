import os


class ConnectionConf:
    host_list = None

    def __init__(self, host, port, use_ssl):
        self.host = host
        self.port = port
        self.use_ssl = bool(use_ssl)

    def host_list(self):
        if self.use_ssl is True:
            return self._ssl_host_list()
        else:
            return self._host_list()

    def _host_list(self):
        return [':'.join([self.host, self.port])]

    def _ssl_host_list(self):
        dir = "/home/palik/workspace/Gearman/python-gearman"
        keyfile = os.path.join(
            dir, "ca/intermediate/private/gearman-client.open.key.pem")
        certfile = os.path.join(
            dir, "ca/intermediate/certs/gearman-client.cert.pem")
        cafile = os.path.join(dir,  "ca/intermediate/certs/ca-chain.cert.pem")
        return [{"host": self.host, "port": int(self.port), "keyfile": keyfile, "certfile": certfile, "ca_certs": cafile}]
