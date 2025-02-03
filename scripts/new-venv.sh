python -m venv venv
source venv/bin/activate

pip install --upgrade pip
pip install pdbpp
pip install pytest
pip install git+https://github.com/matschreiner/tbvaccine.git

ln -s $HOME/dotfiles/misc/sitecustomize.py $(python -c "import site; print(site.getsitepackages()[0])")/sitecustomize.py
