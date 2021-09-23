# Dockerfile used by CI pipeline to publish doc site automatically
# https://docs.github.com/en/free-pro-team@latest/actions/creating-actions/dockerfile-support-for-github-actions
FROM python:3.7-slim-stretch
ENV MARP_VERSION=1.4.0
# ENV MARP_INPUT_PATH
# ENV MARP_OUTPUT_PATH
ENV PATH=$PATH:/usr/local/bin


COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh && \
    apt-get update -y && \
    apt-get install -y git \
        build-essential \
        python3-cffi \
        libcairo2 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libgdk-pixbuf2.0-0 \
        libffi-dev \
        shared-mime-info \
        jq \
        wget
RUN python3 -m pip install yq && \
    wget https://github.com/marp-team/marp-cli/releases/download/v${MARP_VERSION}/marp-cli-v${MARP_VERSION}-linux.tar.gz -O marp.tar.gz &&\
   	tar xvf marp.tar.gz -C /usr/local/bin && \
    pip install -r requirements.txt


ENTRYPOINT ["entrypoint.sh"] 