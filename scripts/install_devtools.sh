#!bash

[ -z "$1" ] && { echo "❌ Error: Specify in which venv you want to install devtools."; exit 1; }
echo $1/bin/activate
source $1/bin/activate

sitepackages=$($1/bin/python -c "import site; print(site.getsitepackages()[0])")
sitecustomize=$sitepackages/sitecustomize.py

pip install --upgrade pip
pip install git+https://github.com/matschreiner/tbvaccine#
pip install lovely_tensors
pip install pdbpp

ln -s $HOME/dotfiles/misc/sitecustomize.py $sitecustomize
