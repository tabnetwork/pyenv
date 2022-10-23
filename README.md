# pyenv
Integrated pyenv for linux and windows platform


## if linux platform, you can use python 3.10.8 after execute following command
source linux/2.3.5/setenv

pybuild 3.10.8

pyenv local 3.10.8

for more detail, please see linux/2.3.5/README.md


## if windows platform, you can use python 3.10.8 after execute following action
firstly, execute windows/3.1.1/setenv.bat， it will auto configure environment varibles in path.

then, execute install.ps1 scripts to select the python version you need.
there are some useful command line

pyenv.bat versions

pyenv.bat local 3.10.8

pyenv.bat rehash

for more detail, please see windows/3.1.1/README.md

