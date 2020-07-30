# Search and replace
$ sed -i -e 's/<texto_buscado>/<texto_a_insertar>/g' <archivo>
  -i: edit files in place
  -e: add the script to the commands to be executed

Ejemplos:

Cambiar yes x no en el archivo hostsrvr.xml: sed -i -e 's/send_cdrs="yes"/send_cdrs="no"/g' /hpadir/config/hostsrvr.xml
La inversa, no x yes y reiniciar: sed -i -e 's/send_cdrs="no"/send_cdrs="yes"/g' /hpadir/config/hostsrvr.xml;

Cambiar 'false' por 'true' y '5-55\10' por '*/2' en archivo sysstat (usado por Sar).
El 'g' hace que busque todas las ocurrencias, sino busca solo la primera y sale.
$ sed -i 's/false/true/g' /etc/default/sysstat; cat /etc/default/sysstat
$ sed -i 's/5-55\/10/*\/2/g' /etc/cron.d/sysstat; cat /etc/cron.d/sysstat

# XML - Search between tags
Show everything between <start> y <stop>:
  $ sed -n '/<start>/,/<stop>/p' file.xml

Show everything that is NOT between <start> y <stop>:
  $ sed -n '/<start>,/<stop>/!p' file.xml
