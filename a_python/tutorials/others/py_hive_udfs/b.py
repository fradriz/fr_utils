#!/usr/bin/env python
""" prueba: 
	hadoop fs -put ./b.py /user/cambrian/ops_dev/efx/paraguay/py_efx_indicadores/fpy/b.py  
	hadoop fs -copyFromLocal -f ./b.py /user/cambrian/ops_dev/efx/paraguay/py_efx_indicadores/fpy/bb.py  """
#import sys

import os
#import pandas

resp = os.popen('hadoop fs -stat /user/cambrian/ops_dev/efx/paraguay/py_efx_indicadores/fpy/a.py').read().strip()

print(resp)