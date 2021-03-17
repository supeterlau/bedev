class=$(echo $1 | grep -o -E 'Demo\d+')
javac $1
java demo.$class
