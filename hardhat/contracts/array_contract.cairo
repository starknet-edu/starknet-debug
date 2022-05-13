%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_contract_address

struct BasicStruct:
    member first_member : felt
    member second_member : felt
end

@view
func view_product{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    array_len : felt, array : BasicStruct*
) -> (res : felt):
    # This could be useful for debugging...
    %{ print(f"computing the product of a {ids.array_len} elements list") %}
    let (res) = array_product(array_len, array)
    let (add) = get_contract_address()
    return (res + add)
end

func array_product{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    array_len : felt, array : BasicStruct*
) -> (res : felt):
    if array_len == 0:
        return (0)
    end
    let temp = [array].first_member * [array].second_member
    let (temp2) = array_product(array_len - 1, array)
    let res = temp * temp2
    return (res)
end
