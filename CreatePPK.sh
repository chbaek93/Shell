# -- Jul 14, 2017 -- # 
# -- chb @ mz.co.kr -- # 

# puttygen input.pem  -O private -o output.ppk
input=$1

puttygen $input.pem  -O private -o $input.ppk

