#!usr/bin/python3
# -*- coding: utf-8 -*-

import os

 # Get slave peer state, assuming Fail if we can't
# s=`ssh -o ConnectionAttempts=5 root\@$PEER_IP cat $STATE_FILE 2>&1`
from pip._internal import commands

cmd="ssh -o ConnectionAttempts=5 root\@$PEER_IP cat $STATE_FILE 2>&1"
os.popen(cmd).read()

# ssh root@OLV2_210 cat /etc/gateway/x25tcp.map|wc -l
# scp -o ConnectionAttempts=5 root@$PEER_IP:$STATE_FILE $TMP_DIR/peer.state 2>&1
# scp root@172.18.24.210:/archivo_original /archivo_destino
# os.popen('ssh root@OLV2_210 cat /etc/gateway/x25tcp.map').read()


commands.getstatusoutput(cmd)
os.popen('scp root@172.18.24.210:/opt/scr/loadxot/x25tcp.map /etc/gateway/TEST_x25tcp.map').read()
commands.getstatusoutput('scp root@172.18.24.210:/opt/scr/loadxot/x25tcp.map /etc/gateway/TEST_x25tcp.map')


'''		
>>> os.popen('ssh root@172.18.24.212 cat /etc/gateway/x25tcp.map').read()
'0,10.3.44.160,1998,*,*,hdlc0,*,70000500050800,XOT,0,0,0,0,0,0,0,*,*,*,*,NONE\n0,10.3.44.167,1998,*,*,hdlc0,*,70000500050700,XOT,0,0,0,0,0,0,0,*,*,*,*,NONE\n0,10.3.44.168,1998,*,*,hdlc0,*,70000500074300,XOT,0,0,0,0,0,0,0,*,*,*,*,NONE\n'
>>> os.popen('ssh root@172.18.24.60 cat /etc/gateway/x25tcp.map').read()
'0,10.3.44.160,1998,*,*,hdlc0,*,70000500050800,XOT,0,0,0,0,0,0,0,*,*,*,*,NONE\n'
>>> commands.getstatusoutput('ssh root@172.18.24.60 cat /etc/gateway/x25tcp.map')
(0, '0,10.3.44.160,1998,*,*,hdlc0,*,70000500050800,XOT,0,0,0,0,0,0,0,*,*,*,*,NONE')

>>> commands.getstatusoutput('ssh root@172.18.24.63 cat /etc/gateway/x25tcp.map') #este comando da el codigo de error y la salida !
(65280, 'ssh: connect to host 172.18.24.63 port 22: Connection timed out\r')
>>> os.popen('ssh root@172.18.24.63 cat /etc/gateway/x25tcp.map').read()
ssh: connect to host 172.18.24.63 port 22: Connection timed out

		
commands.getstatusoutput('ls -l /bin/ls')
(0, '-rwxr-xr-x. 1 root root 117048 May 11  2016 /bin/ls')


>>> commands.getoutput('ls -l /bin/ls')
'-rwxr-xr-x. 1 root root 117048 May 11  2016 /bin/ls'


>>> import os
>>> os.popen('ls -l /bin/ls')
<open file 'ls -l /bin/ls', mode 'r' at 0x7ff9fd481c00>

>>> os.popen('ls -l /bin/ls').read()
'-rwxr-xr-x. 1 root root 117048 May 11  2016 /bin/ls\n'

accmgr.cgi
-----------
for a1k in device:
	salida = os.popen('ping -q -c 1 %s |grep -w \'0%% packet loss\'' % (a1k)).read()
	if "0%" in salida:
		#print "Llego por ping !!"
		ping = 'OK'
		if "DGW" not in a1k:
			estadoTCP = os.popen('nmap --system-dns -p %s %s |grep /|grep -v Nmap' % (puertosTCP,a1k)).read()
			estadoUDP = os.popen('nmap --system-dns -sU -p %s %s |grep /|grep -v Nmap' % (puertosUDP,a1k)).read()
		#out = estadoTCP_UDP(ping, estadoTCP,estadoUDP,a1k)
	else: 
		#print "No llego por ping"
		ping = 'No hay conexion por ping'		
	
	#print estadoUDP
	#sys.exit()
	
	out = estadoTCP_UDP(ping, estadoTCP,estadoUDP,a1k)
	#sys.exit()      #die - DEBUG
'''