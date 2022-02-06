FROM jupyterhub/jupyterhub
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

RUN apt -y update && apt -y upgrade
RUN apt install -y wget \
    git

# Intall Python packages
RUN pip3 install notebook
RUN pip3 install jupyterlab
RUN pip3 install scipy
RUN pip3 install seaborn
RUN pip3 install scikit-learn
RUN pip3 install sympy
RUN pip3 install mne
RUN pip3 install axelrod
RUN pip3 install deap
RUN pip3 install japanize-matplotlib
RUN pip3 install mecab-python3
RUN pip3 install unidic-lite
RUN pip3 install --upgrade mplfinance
RUN pip3 install networkx
RUN pip3 install PuLP
RUN pip3 install pymc3
RUN pip3 install simpy
RUN pip3 install psychrnn
RUN pip3 install pyddm
RUN pip3 install inferactively-pymdp

# Install Julia
RUN cd /opt/
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.1-linux-x86_64.tar.gz
RUN gunzip julia-1.7.1-linux-x86_64.tar.gz
RUN tar -xvf julia-1.7.1-linux-x86_64.tar -C "/opt/"
RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia
RUN rm julia-1.7.1-linux-x86_64.tar

# Install Julia packages
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("HDF5")' && \
    julia -e 'using Pkg; pkg"add IJulia"; pkg"precompile"' && \
    mv "/root/.local/share/jupyter/kernels/julia-1.7" "/usr/local/share/jupyter/kernels/" && \
    chmod -R go+rx "/usr/local/share/jupyter" && \
    rm -rf "/root/.local"

## Install julia Pkgs
# Stats
RUN julia -e 'using Pkg; Pkg.add("CPUTime")'
RUN julia -e 'using Pkg; Pkg.add("Distributions")'
RUN julia -e 'using Pkg; Pkg.add("Gadfly")'
RUN julia -e 'using Pkg; Pkg.add("GLM")'
RUN julia -e 'using Pkg; Pkg.add("Optim")'
RUN julia -e 'using Pkg; Pkg.add("Plots")'
# RUN julia -e 'using Pkg; Pkg.add("PyCall")'
# RUN julia -e 'using Pkg; Pkg.add("PyPlot")'
RUN julia -e 'using Pkg; Pkg.add("Query")'
RUN julia -e 'using Pkg; Pkg.add("RDatasets")'
RUN julia -e 'using Pkg; Pkg.add("SpecialFunctions")'
RUN julia -e 'using Pkg; Pkg.add("StatisticalRethinking")'
RUN julia -e 'using Pkg; Pkg.add("StatsBase")'
RUN julia -e 'using Pkg; Pkg.add("StatsFuns")'
RUN julia -e 'using Pkg; Pkg.add("StatsPlots")'
# stan and turing
RUN julia -e 'using Pkg; Pkg.add("AdvancedHMC")'
RUN julia -e 'using Pkg; Pkg.add("BAT")'
RUN julia -e 'using Pkg; Pkg.add("Bijectors")'
RUN julia -e 'using Pkg; Pkg.add("CmdStan")'
RUN julia -e 'using Pkg; Pkg.add("DiffEqBayes")'
RUN julia -e 'using Pkg; Pkg.add("DistributionsAD")'
RUN julia -e 'using Pkg; Pkg.add("ForwardDiff")'
RUN julia -e 'using Pkg; Pkg.add("MCMCChains")'
RUN julia -e 'using Pkg; Pkg.add("MeasureTheory")'
RUN julia -e 'using Pkg; Pkg.add("ParameterizedFunctions")'
RUN julia -e 'using Pkg; Pkg.add("Soss")'
RUN julia -e 'using Pkg; Pkg.add("Turing")'
## ODE
# RUN julia -e 'using Pkg; Pkg.add("CalculusWithJulia")'
RUN julia -e 'using Pkg; Pkg.add("LinearAlgebra")'
RUN julia -e 'using Pkg; Pkg.add("DifferentialEquations")' 
RUN julia -e 'using Pkg; Pkg.add("Roots")' 
# RUN julia -e 'using Pkg; Pkg.add("SymPy")' 
## Active Inference
RUN julia -e 'using Pkg; Pkg.add("ForneyLab")'

# notebook extentions
RUN pip3 install jupyterlab-git
RUN pip3 install jupyter_contrib_nbextensions
RUN pip3 install lckr-jupyterlab-variableinspector
