# MatFlow-DAMASK

This repository hosts the dockerfile to create a container image that contains DAMASK and Matflow.

## Usage

If you have a workflow `./wd/simple_damask.yaml`, run the container with
```
docker run --rm -v $PWD/wd:/wd ghcr.io/hpcflow/matflow-damask:latest matflow go simple_damask.yaml --wait
```
This will mount the `./wd` directory in the container, so that `simple_damask.yaml` is accessible, and run the command `matflow go simple_damask.yaml --wait`, which will generate outputs in the same directory (`./wd`).
The `--wait` flag is important, if it is not used the container will terminate before the workflow finishes.

### Interactive

If you want to run an interactive container use
```
docker run --rm -it -v $PWD/wd:/wd ghcr.io/hpcflow/matflow-damask:latest bash
```
This should place you in `/wd` inside the container, where you can now run `matflow go simple_damask.yaml`.
In this case, the `--wait` flag is not essential, as the container will stay alive until you exit.

**WARNING**: any files that you modify in `/wd` will also be modified in the host system (`./wd`).

## Build

The easiest way to build and deploy the image is through the [build-test-push](https://github.com/hpcflow/matflow-damask-image/actions/workflows/build-test-push.yml) action, which can be manually triggered.

The image can be built and tested without pushing to ghcr.io by setting both inputs to false.

### Building locally

Because matflow is installed using the single liner, with no reference to the version, it installs the latest version, but docker does not detect the version change, so new images need to be built with the `--no-cache` option:
```
docker build --no-cache -t ghcr.io/hpcflow/matflow-damask:latest .
```
Once the build is finished, push to ghcr with
```
docker push ghcr.io/hpcflow/matflow-damask:latest
```
Rmember to also push a version tagged with the damask and matflow version, e.g.:
```
docker build -t ghcr.io/hpcflow/matflow-damask:d3.0.0a7_m0.3.0a30 .
docker push ghcr.io/hpcflow/matflow-damask:d3.0.0a7_m0.3.0a30
```

