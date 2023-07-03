FROM eisenforschung/damask-grid:3.0.0-alpha7

RUN <<SysReq
    apt-get update
    apt-get install -y curl
SysReq

RUN <<matflow
    touch tmp.sh
    curl -fsSL https://raw.githubusercontent.com/hpcflow/install-scripts/main/src/install-matflow.sh > tmp.sh
    bash tmp.sh --prerelease --path --onefile
    rm tmp.sh
    cp /root/.local/share/matflow/links/matflow* /bin/matflow
matflow

RUN matflow --help

CMD [ "bash" ]
ENTRYPOINT [ "matflow" ]
