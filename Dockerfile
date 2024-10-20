# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# A image for building/testing brpc
FROM ubuntu:20.04

# prepare env
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        apt-utils \
        openssl \
        ca-certificates

# install deps
RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        g++ \
        make \
        libssl-dev \
        libgflags-dev \
        libprotobuf-dev \
        libprotoc-dev \
        protobuf-compiler \
        libleveldb-dev \
        libsnappy-dev && \
        apt-get clean -y

RUN git clone https://github.com/apache/brpc.git
RUN cd brpc && git checkout 1.6.0 && sh config_brpc.sh --headers=/usr/include --libs=/usr/lib && \
    make -j "$(nproc)"
