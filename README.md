# docker-litmus

Docker image for [Litmus test suite](http://www.webdav.org/neon/litmus/).

## Usage

**NOTE:** replace <HOST_IP> with the real IP address of the test client.


### Run WsgiDAV on Local Host

```
> cd WSGIDAV-ROOT
> wsgidav --config tests\wsgidav-litmus.yaml -H <HOST_IP>
```


### Run Litmus Suite
```
docker pull mar10/docker-litmus
docker run --rm -ti mar10/docker-litmus https://<HOST_IP>:8080/ tester secret
```


## Build and Debug

`--network` option is required to enable accessing the client from withon the container:

```
docker build --rm --network host -f Dockerfile -t docker-litmus:latest .
```

Shell
```
docker run -ti --entrypoint bash mar10/docker-litmus
...
bash-4.4# litmus https:0.0.0.0:8080
-> running `basic':
 0. init.................. FAILED - segmentation fault
Segmentation fault
See debug.log for network/debug traces.
...
bash-4.4# less debug.log
```


## Credits

Inspired by https://github.com/owncloud-docker/litmus, with help from
[fngx](https://github.com/fngx)
