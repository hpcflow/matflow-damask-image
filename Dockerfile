FROM eisenforschung/damask-grid:3.0.0-alpha7

SHELL ["/bin/bash", "-c"]

RUN <<SysReq
    apt-get update
    apt-get install -y curl libgl1-mesa-glx libxrender1
SysReq

RUN <<matflow
    touch tmp.sh
    curl -fsSL https://raw.githubusercontent.com/hpcflow/install-scripts/main/src/install-matflow.sh > tmp.sh
    bash tmp.sh --prerelease --path --onefile
    rm tmp.sh
matflow

WORKDIR /
RUN <<install_micromamba
    apt-get install -y wget bzip2
    wget -qO-  https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
    touch /root/.bashrc
    ./bin/micromamba shell init -s bash -p /micromamba
install_micromamba
ENV MAMBA_ROOT_PREFIX=/micromamba

COPY envs.yaml /root/.matflow-new/envs.yaml
RUN <<activate_micromamba
    micromamba create -n matflow_damask_parse_env python -y -c conda-forge
    eval "$(micromamba shell hook -s bash )"
    micromamba activate matflow_damask_parse_env
    pip install matflow-new damask-parse
    matflow config append environment_sources envs.yaml
activate_micromamba
RUN echo "micromamba activate matflow_damask_parse_env" >> ~/.bashrc

WORKDIR /wd/
ENTRYPOINT ["micromamba", "run", "-n", "matflow_damask_parse_env"]
CMD [ "" ]
