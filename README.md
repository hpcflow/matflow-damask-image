# MatFlow-DAMASK

This repository hosts the dockerfile to create a container image that contains DAMASK and Matflow.

## Usage

If you have a workflow `./wd/simple_damask.yaml`, run the container with
```
docker run -v $PWD/wd:/wd ghcr.io/hpcflow/matflow-damask:latest matflow go simple_damask.yaml
```
This will mount the `./wd` directory in the container, so that `simple_damask.yaml` is accessible, and run the command `matflow go simple_damask.yaml`, which will generate outputs in the same directory.

### Interactive

If you want to run an interactive container use
```
docker run -it -v $PWD/wd:/wd ghcr.io/hpcflow/matflow-damask:latest bash
```
This should place you in `/wd` inside the container, where you can now run `matflow go simple_damask.yaml`.

**WARNING**: any files that you modify in `\wd` will also be modified in the host system.
