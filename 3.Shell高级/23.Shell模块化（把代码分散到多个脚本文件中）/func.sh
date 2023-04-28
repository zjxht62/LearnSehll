#计算所有参数的和
function sum(){
    local total=0
    for n in $@
    do
         ((total+=n))
    done
    echo $total
    return 0
}