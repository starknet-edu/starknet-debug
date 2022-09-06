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
    // This will print first member of the first value of the array
    %{ print(f"Printing {ids.val.first_member=}") %}
    // You can use tempvars to print values further down the array
    tempvar last_val = array[array_len - 1];
    %{ print(f"Printing {ids.last_val.first_member=}") %}
    let (res) = array_product(array_len, array);
    let (add) = get_contract_address();
    return (res + add,);
}

// TODO: Fix the contract so that it returns the product of all the tuples in
// the array. Example:
// For the array [{2,3}, {4,5}] the result should be: (2*3)*(4*5) etc.
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
