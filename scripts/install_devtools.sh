#!bash

export python_bin=$(which python)

sitepackages=$($python_bin -c "import site; print(site.getsitepackages()[0])")
sitecustomize=$sitepackages/sitecustomize.py

pip install --upgrade pip
pip install git+https://github.com/matschreiner/tbvaccine#
pip install lovely_tensors
pip install pdbpp

ln -s $HOME/dotfiles/misc/sitecustomize.py $sitecustomize
