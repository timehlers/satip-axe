FROM jalle19/centos7-stlinux24

WORKDIR /build

# Use CERN mirror, everything official has been shut down long ago
COPY ./configs/docker/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum -y update && \
  yum -y install epel-release && \
  yum -y install wget make gcc git python wget tar \
                 bzip2 uboot-tools patch fakeroot \
                 file autoconf automake libtool \
                 texinfo ca-certificates cmake3

# Required for git operations when container is running as an UID that doesn't exist in /etc/passwd
ENV GIT_COMMITTER_NAME=nobody
ENV GIT_COMMITTER_EMAIL=nobody@example.com

ENTRYPOINT [ "make" ]
