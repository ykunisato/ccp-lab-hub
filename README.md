# Dockerfile for JupyterHub in Computational Clinical Psychology Lab

This is a repository of Dockerfile for JupyterHub used in [Computational Clinical Psychology Lab](https://kunisatolab.github.io/english/index.html). This Dockerfile contains

- Julia
- Python 3 & Python packages(inferactively-pymdp,bokeh,scipy,seaborn,scikit-learn,sympy,mne,mecab-python3,pymc3,psychrnn,pyddm...)

## Usage
1.Install "Docker Desktop"

2.Open "terminal"(Mac or linux)

3.Type the following code to pull a Docker container. 

```
docker run -d -p 8000:8000 --name jupyterhub ykunisato/ccp-lab-hub jupyterhub
```

4.Add user to jupyterHub

```
# login container
docker exec -it jupyterhub bash
# change XXX to name of user  
adduser XXX
```

5.Install IJulia and Julia packages for each usr

```
# login as user
su XXX
# start julia on terminal
julia
```

Copy and paste the following code to install Julia packages.

```
ENV["PYTHON"] = "";using Pkg;Pkg.update();Pkg.add(["IJulia","PyCall"]);Pkg.build(["IJulia","PyCall"]);Pkg.add(["DataFrames","PyPlot","Distributions","Statistics","JuliaFormatter","CPUTime","Gadfly","GLM","Optim","Plots","Query","RDatasets","SpecialFunctions","StatisticalRethinking","StatsBase","StatsFuns","StatsPlots","AdvancedHMC","BAT","Bijectors","CmdStan","DiffEqBayes","DistributionsAD","ForwardDiff","MCMCChains","MeasureTheory","ParameterizedFunctions","Soss","Turing","LinearAlgebra","DifferentialEquations","Roots","SymPy","ForneyLab"]);Pkg.precompile()
```

6.pen the web browser and type "http://localhost:8000/" in the URL bar. 

You will see the JupyterLab on the web browser. Login as user.