from jupyter_core.paths import jupyter_data_dir
import os
import sys


c = get_config()


# specify iPython server IP range & listening port
c.NotebookApp.ip = '*'
c.NotebookApp.port = 8133


# do not open browser as Amazon Linux EC2 server instances do not have browsers
c.NotebookApp.open_browser = False


# enable iPython Notebook Extensions
sys.path.append(os.path.join(jupyter_data_dir(), 'extensions'))
c.NotebookApp.extra_template_paths = [os.path.join(jupyter_data_dir(), 'templates')]
