# arg: vhd_file 
vhd_file=$1

#Separo con el delimitador, '/'
readarray -d / -t strarr <<< "$vhd_file"
# Print each value of the array by using loop
# Puedo imprimir cada valor del array o en este caso hacer algo nulo solo para contar
for (( n=0; n < ${#strarr[*]}; n++))
do
  #echo "${strarr[n]}"
  null=1
done
# Tomo ultimo elemento algo.vhd]
fn=${strarr[n-1]}
#Separo con el delimitador, '.'
readarray -d . -t file <<< "$fn"
echo "file name: ${file}"

# Generate a json file
export PATH="/home/aortiz/fpga-toolchain/bin:$PATH"
export GHDL_PREFIX=/home/aortiz/fpga-toolchain/lib/ghdl
yosys -p "ghdl --std=08 -fsynopsys ${vhd_file} -e; proc; opt; write_json $file.json; stat"
# https://github.com/nturley/netlistsvg
# Need a json file file from Yosys
netlistsvg $file.json -o $file.svg