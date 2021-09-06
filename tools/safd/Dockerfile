FROM python:3.7-buster AS julia-downloader

WORKDIR /app

# Install julia and related packages
RUN apt-get -qq update && \
  apt-get -qq install -y --no-install-recommends wget && \
  wget -q https://julialang-s3.julialang.org/bin/linux/x64/1.2/julia-1.2.0-linux-x86_64.tar.gz && \
  tar -xzf julia-1.2.0-linux-x86_64.tar.gz && \
  rm julia-1.2.0-linux-x86_64.tar.gz && \
  apt-get -qq clean

FROM python:3.7-buster

COPY --from=julia-downloader /app /app
RUN ln -s /app/julia-1.2.0/bin/julia /bin/julia

WORKDIR /app

ENV HRMS_TOOL_KIT_SHA=$REV
# RUN julia -e "using Pkg; Pkg.add(PackageSpec(url=\"https://997c7d6e9177beef788f5ad51769dfb28bab5615:@github.com/NIVANorge/HrmsToolKit.jl\", rev=\"$REV\"))"

COPY requirements.txt /app
RUN pip install -r requirements.txt
COPY . /app/
RUN black --check .
RUN pycodestyle --config .pycodestyle src
RUN mypy --namespace-packages --ignore-missing-imports src
RUN pip install .
RUN pytest
COPY .pycodestyle /app
