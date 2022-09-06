// Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func mapping(key) -> (value: felt) {
}

@storage_var
func mapping_length() -> (value: felt) {
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    array_len: felt, array: felt*
) {
    mapping_length.write(array_len);
    fill_mapping(array_len, array);
    return ();
}

func fill_mapping{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    array_len: felt, array: felt*
) -> () {
    if (array_len == 0) {
        return ();
    }

    // This could be useful for debugging...
    let val = [array];
    %{
        print(f"Still {ids.array_len} values to save...") 
        print(f"Saving {ids.val} to the storage...")
    %}
    mapping.write(array_len, [array]);
    fill_mapping(array_len - 1, array + 1);
    return ();
}

@view
func product_mapping{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    res: felt
) {
    let (length) = mapping_length.read();
    let (res) = product_mapping_internal(length);
    return (res,);
}

// TODO: Fix the contract so that it returns the product of all the values in
// the stored array. Example:
// For the array [7,8,10], the result should be (7*8*10)=560
func product_mapping_internal{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    len: felt
) -> (res: felt) {
    if (len == 0) {
        let (res) = mapping.read(len);
        return (res,);
    }
    let (temp) = product_mapping_internal(len - 1);
    let (mapping_val) = mapping.read(len);
    let res = temp * mapping_val;
    return (res,);
}
