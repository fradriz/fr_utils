# Python Virtual Environments
# Link: https://www.youtube.com/watch?v=N5vscPTWKOk&t=1s

# Useful to separate packages - Do not put the code inside the environment folder !

# 1) Check if 'virtualenv' package if installed
$ virtualenv --version
$ pip install virtualenv

# 2) Create a the folder to store the packages of the environment and cd into it.
mkdir PyVirtualenv
cd PyVirtualenv

# 3) Create the project
$ virtualenv <NAME_OF_THE_ENV>
created virtual environment CPython3.7.5.final.0-64 in 553ms
  creator CPython3Posix(dest=/Users/user_name/Documents/PyEnvironments/project1_env, clear=False, global=False)
  seeder FromAppData(download=False, pip=latest, setuptools=latest, wheel=latest, via=copy, app_data_dir=/Users/user_name/Library/Application Support/virtualenv/seed-app-data/v1.0.1)
  activators BashActivator,CShellActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator

# 3) Activate the new environment
$ source <NAME_OF_THE_ENV>/bin/activate

# 3.1) The first part of the prompt tells us we are in a new env:
(<NAME_OF_THE_ENV>) hostname:PyEnvironments user_name$

# 3.2) Another way to check we are using the new env python and not the global one !!
$ which python
/Users/user_name/Documents/PyEnvironments/<NAME_OF_THE_ENV>/bin/python

# 3.3) Same with pip
$ which pip
/Users/user_name/Documents/PyEnvironments/<NAME_OF_THE_ENV>/bin/pip

# 3.4) Listing which packages we have now ...
(<NAME_OF_THE_ENV>) hostname:<NAME_OF_THE_ENV> user_name$ pip list
Package    Version
---------- -------
pip        20.0.2 
setuptools 46.1.3 
wheel      0.34.2 

# 3.5) Install a package in our new env
(<NAME_OF_THE_ENV>) hostname:<NAME_OF_THE_ENV> user_name$ pip install psutil
(<NAME_OF_THE_ENV>) hostname:<NAME_OF_THE_ENV> user_name$ pip list
Package    Version
---------- -------
pip        20.0.2 
psutil     5.7.0  
setuptools 46.1.3 
wheel      0.34.2 

# 4) To export all these packages so we can use it in a new env
$ pip freeze --local > requirements.txt
$ cat requirements.txt 
psutil==5.7.0

# 5) Get out of the env
$ deactivate

------------------
# Now if we want to create a new env with python2.6 (I don't have it in my machine so I can't do it)
virtualenv -p /usr/bin/python2.6 new_env_py26

Now the new env is going to use python 2 !

# Using requierments.txt:
pip install -r requirements.txt
-------------------
# To have system packages available in virtual_env (don't see the point!)
$ virtualenv test_env --system-site-packages

# Then doing a pip list will list the same packages that we have in the system (and don't need to download them again !!)
$ source test_env/bin/activate
(test_env) $ pip list
-------------------
# Another was: https://snarky.ca/a-quick-and-dirty-guide-on-how-to-install-packages-for-python/

# Step 1: Create a virtual environment (with customized prompt)
python3.8 -m venv --prompt (basename $PWD) .venv
python3.8 -m venv --prompt `basename $PWD` .venv

# Step 2: Activate your virtual environment
# fish shell
source .venv/bin/activate.fish

# bash shell
source .venv/bin/activate

# Step 3: Install your package(s)
python -m pip install --upgrade pip







