%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_contract_address

struct BasicStruct {
    first_member: felt,
    second_member: felt,
}

@view
func view_product{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    array_len: felt, array: BasicStruct*
) -> (res: felt) {
    // This could be useful for debugging...
    let val = [array];
    %{
        print(f"Printing {ids.val.first_member=}") 
        breakpoint()
    %}
    let (res) = array_product(array_len, array);
    let (add) = get_contract_address();
    return (res + add,);
}

func array_product{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    array_len: felt, array: BasicStruct*
) -> (res: felt) {
    if (array_len == 0) {
        return (0,);
    }
    let temp = [array].first_member * [array].second_member;
    let (temp2) = array_product(array_len - 1, array);
    let res = temp * temp2;
    return (res,);
}
