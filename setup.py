from setuptools import setup, find_packages

setup(name='a_python',
      version='0.0.1',
      description='FR UTILS LIBRARY',
      packages=find_packages(),
      # package_data={'': ['utils/*.sh', 'utils/*.jar']},
      install_requires=[
          'pyspark==2.4.5',
          'pandas==0.24.2',
          'numpy',
          'boto3>=1.11.9',
          'psutil'
      ],
      include_package_data=True,
      zip_safe=False)
