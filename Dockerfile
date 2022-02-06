FROM jupyterhub/jupyterhub
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

RUN apt -y update && apt -y upgrade
RUN apt install -y wget

RUN pip3 install notebook
RUN pip3 install jupyterlab
RUN pip3 install scipy
RUN pip3 install seaborn
RUN pip3 install scikit-learn
RUN pip3 install sympy


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
    julia -e 'using Pkg; pkg"add IJulia"; pkg"precompile"'

