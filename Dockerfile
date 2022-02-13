FROM jupyterhub/jupyterhub
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

RUN apt -y update && apt -y upgrade
RUN apt install -y wget \
    git

# Intall Python packages
RUN pip3 install notebook \
    jupyterlab \
    jupyterlab-git \
    jupyter_contrib_nbextensions \
    lckr-jupyterlab-variableinspector \
    scipy \
    seaborn \
    scikit-learn \
    sympy \
    mne \
    axelrod \
    deap \
    japanize-matplotlib \
    mecab-python3 \
    unidic-lite \
    networkx \
    PuLP \
    pymc3 \
    simpy \
    psychrnn \
    pyddm \
    inferactively-pymdp

# Install Julia
# Install Julia
ARG JULIA_VERSION="1.7.2"
ENV JULIA_DEPOT_PATH=/opt/julia
RUN JULIA_MAJOR=`echo $JULIA_VERSION | sed -E  "s/\.[0-9]+$//g"` && \
    wget https://julialang-s3.julialang.org/bin/linux/x64/$JULIA_MAJOR/julia-$JULIA_VERSION-linux-x86_64.tar.gz && \
    tar -xvzf julia-$JULIA_VERSION-linux-x86_64.tar.gz && \
    cp -r julia-$JULIA_VERSION /opt/ && \
    ln -s /opt/julia-$JULIA_VERSION/bin/julia /usr/local/bin/julia && \
    rm -r julia-$JULIA_VERSION-linux-x86_64.tar.gz

# Install Julia packages
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("HDF5")' && \
    julia -e 'using Pkg; pkg"add IJulia"; pkg"precompile"' && \
    mv "/root/.local/share/jupyter/kernels/julia-1.7" "/usr/local/share/jupyter/kernels/" && \
    chmod -R go+rx "/usr/local/share/jupyter" && \
    rm -rf "/root/.local"

RUN julia -e 'ENV["PYTHON"]="/usr/local/bin/python3"'

## Install julia Pkgs
# Stats
RUN julia -e 'using Pkg; Pkg.add("CPUTime")' && \
    julia -e 'using Pkg; Pkg.add("Distributions")' && \
    julia -e 'using Pkg; Pkg.add("Gadfly")' && \
    julia -e 'using Pkg; Pkg.add("GLM")' && \
    julia -e 'using Pkg; Pkg.add("Optim")' && \
    julia -e 'using Pkg; Pkg.add("Plots")' && \
    julia -e 'using Pkg; Pkg.add("Query")' && \
    julia -e 'using Pkg; Pkg.add("RDatasets")' && \
    julia -e 'using Pkg; Pkg.add("SpecialFunctions")' && \
    julia -e 'using Pkg; Pkg.add("StatisticalRethinking")' && \
    julia -e 'using Pkg; Pkg.add("StatsBase")' && \
    julia -e 'using Pkg; Pkg.add("StatsFuns")' && \
    julia -e 'using Pkg; Pkg.add("StatsPlots")'
# julia -e 'using Pkg; Pkg.add("PyCall")' && \
# julia -e 'using Pkg; Pkg.add("PyPlot")'
# stan and turing
RUN julia -e 'using Pkg; Pkg.add("AdvancedHMC")' && \
    julia -e 'using Pkg; Pkg.add("BAT")' && \
    julia -e 'using Pkg; Pkg.add("Bijectors")' && \
    julia -e 'using Pkg; Pkg.add("CmdStan")' && \
    julia -e 'using Pkg; Pkg.add("DiffEqBayes")' && \
    julia -e 'using Pkg; Pkg.add("DistributionsAD")' && \
    julia -e 'using Pkg; Pkg.add("ForwardDiff")' && \
    julia -e 'using Pkg; Pkg.add("MCMCChains")' && \
    julia -e 'using Pkg; Pkg.add("MeasureTheory")' && \
    julia -e 'using Pkg; Pkg.add("ParameterizedFunctions")' && \
    julia -e 'using Pkg; Pkg.add("Soss")' && \
    julia -e 'using Pkg; Pkg.add("Turing")' && \
## ODE
    julia -e 'using Pkg; Pkg.add("LinearAlgebra")' && \
    julia -e 'using Pkg; Pkg.add("DifferentialEquations")'  && \
    julia -e 'using Pkg; Pkg.add("Roots")' && \
# RUN julia -e 'using Pkg; Pkg.add("CalculusWithJulia")'
# RUN julia -e 'using Pkg; Pkg.add("SymPy")' 
## Active Inference
    julia -e 'using Pkg; Pkg.add("ForneyLab")'
RUN julia -e 'using Pkg; Pkg.precompile()'

RUN chown -hR root:staff /opt/julia-$JULIA_VERSION
RUN chown -hR root:staff /opt/julia