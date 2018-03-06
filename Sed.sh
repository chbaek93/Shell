#!/bin/sh

# --  Nov 10, 2016

# -- Execute 'ls -l ' -- # 
sed 's/^/ls -l /e' data.txt

# -- Change Multiple word -- #
sed '{
  s/This/That/
  s/What/Where/
}' data.txt

# -- Enclose the number -- #
sed 's/^[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9]/[&]/g' data.txt

# -- Enclose the whole line -- #
sed 's/^.*/[&]/' data.txt

# -- Choice User Name -- #
sed 's/\([^:]*\).*/\1/' /etc/passwd

# -- Enclose first character -- #
sed 's/\(\b[A-Z]\)/\(\1\)/g' data.txt

# -- Swap field -- #
sed 's/\([^,]*\),\([^,]*\),\(.*\).*/\2,\1,\3/g' data.txt


