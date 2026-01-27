FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/universal:5-noble

COPY . /root/devcontainer-build
RUN cd /root/devcontainer-build && bash ./setup.sh && rm -fr /root/devcontainer-build
