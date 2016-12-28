# -- chb@mz.co.kr -- # 

END=128

for number in {1..128};
do
  echo "Number is $number" 
done


for number in $(seq 1 $END);
do
  echo "Number is $number"
done 
