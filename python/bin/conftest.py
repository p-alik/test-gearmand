import pytest

@pytest.hookimpl
def pytest_addoption(parser):
    parser.addoption("--host", action="store", dest="host", default="localhost")
    parser.addoption("--port", action="store", dest="port", default=4730)
    parser.addoption("--iteration", action="store", dest="iteration", default=10)
    parser.addoption("--start", action="store", dest="start", default=20000000)
    parser.addoption("--ssl", action="store", dest="ssl", default=False)
