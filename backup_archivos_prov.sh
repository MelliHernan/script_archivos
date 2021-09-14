#!/bin/bash

#- Backupear archivos y directorios designados
###########################################################
##################HERNAN VILLALOBOS################
# Recopilar fecha actual
today=$(date +%y%m%d)
#
# Establecer nombre
backupfile=archive$today.tar.gz
#
# Establecer configuración y archivo de destino
config_file=/archive/Archivos_a_backupear.txt
destination=/ruta/destino/$backupfile

######### PRINCIPAL ####################################
#
# Compruebe que el archivo de configuración de copia de seguridad existe
#
if [ -f $config_file ] #Asegúrese de que el archivo de configuración aún exista.
then # Si existe, no haga nada más que continuar.
     echo
else # Si no existe, emita el script de error y salida.
     echo
     echo "$config_file no existe."
     echo "Copia de seguridad no completada debido a que falta el archivo de configuración."
     echo
     exit 
fi
#
# Construya los nombres de todos los archivos para respaldar
file_no=1                   # Comience en la línea 1 del archivo de configuración.
exec 0< $config_file        # Redirigir la entrada estándar al nombre del archivo de configuración
#
read file_name              # Leer el primer registro
#
while [ $? -eq 0 ] # Crea una lista de archivos para respaldar.
do
        # Asegúrese de que el archivo o directorio exista.
      if [ -f $file_name -o -d $file_name ]
      then
           # Si el archivo existe, agregue su nombre a la lista.
           file_list="$file_list $file_name"
      else
           # Si el archivo no existe, emita una advertencia
           echo
           echo "$file_name, no existe".
           echo "Obviamente, no lo incluiré en este archivo".
           echo "Aparece en la línea $file_no del archivo de configuración".
           echo "Continuando con la creación de la lista de archivos..."
           echo
      fi
#
      file_no=$[$file_no + 1] # Aumente el número de línea/archivo en uno.
      read file_name # Leer el siguiente registro.
done
#
################################
#
# Haga una copia de seguridad de los archivos y comprima el archivo
#
echo "Empezando..."
echo
#
tar -czf $destination $file_list 2> /dev/null
#
echo "Backup completado"
echo "El archivo backup resultante es: $destination"
echo
exit
