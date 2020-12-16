FROM julia:1.5.3-buster

RUN apt-get update && apt-get install -yq \
    libc6-dev \
    libxml2-dev \
    && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN julia -e 'using Pkg;Pkg.add(PackageSpec(url="https://bitbucket.org/SSamanipour/ms_import.jl/src/master/"));Pkg.add(PackageSpec(url="https://bitbucket.org/SSamanipour/safd.jl/src/master/"))'