echo 'Hello world!'

#variable declaration
integer=15

#conditional
if [[ $integer -gt 10 ]] && [[ $integer -lt 20 ]]
then
  echo $integer is between 10 and 20
fi

#for loop
numbers='1 2 3 4 5 6 7 8 9 10'

for number in $numbers
do
  echo $number
done

#function
greeting () {
  echo Hello $1
}

greeting 'Peter' # outputs 'Hello Peter'
