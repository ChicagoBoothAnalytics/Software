#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# change Home directory
export HOME=/mnt/home


# source script specifying environment variables
source ~/.EnvVars


# change directory to Programs directory
cd $APPS_DIR


# install/update SciPy stack, excl. Nose
sudo pip install --upgrade NumPy
sudo pip install --upgrade Pandas
sudo pip install --upgrade SciPy
sudo pip install --upgrade SymPy

# install iPython / Jupyter (plus extensions) & MatPlotLib on Master node only
if grep isMaster /mnt/var/lib/info/instance.json | grep true;
then
    # install iPython / Jupyter
    sudo pip install --upgrade iPython[all]
    sudo pip install --upgrade Jupyter

    # create symbolic links in /usr/bin to iPython / Jupyter binaries
    # because R does not search /usr/local/bin
    sudo ln -s /usr/local/bin/ipython* /usr/bin
    sudo ln -s /usr/local/bin/jupyter* /usr/bin


    # install Jupyter Notebook Extensions
    sudo pip install --upgrade iPyExt

    git clone https://github.com/ipython-contrib/IPython-notebook-extensions
    cd IPython-notebook-extensions
    mkdir -p ~/.local/share/jupyter

    # the following prefers Python 3.x to have been installed;
    # hence we temporarily turn off the error trap to force the installation
    set +e
    python setup.py install
    set -e


    # download & override Jupyter Notebook Config file
    curl $GITHUB_REPO_RAW_PATH/.config/$JUPYTER_NOTEBOOK_CONFIG_FILE_NAME --output $JUPYTER_DIR/$JUPYTER_NOTEBOOK_CONFIG_FILE_NAME
    cd $APPS_DIR


    # install MatPlotLib
    sudo pip install --upgrade MatPlotLib
fi
