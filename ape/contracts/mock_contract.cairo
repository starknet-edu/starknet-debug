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
    arr_len: felt, arr: felt*
) {
    mapping_length.write(arr_len);
    %{
        # creating the file not to have the old logs
        with open("mock_logs.txt", "w") as f:
            f.write("")
    %}
    fill_mapping(arr_len, arr);

    return ();
}

func fill_mapping{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    arr_len: felt, arr: felt*
) -> () {
    if (arr_len == 0) {
        return ();
    }

    // This could be useful for debugging...
    let val = [arr];
    %{
        # append the newly created file to have all the logs for this run
        with open("mock_logs.txt", "a+") as f:
            f.write(f"Still {ids.arr_len} values to save...\n")
            f.write(f"Saving {ids.val} to the storage...\n")
    %}
    mapping.write(arr_len, [arr]);
    fill_mapping(arr_len - 1, arr + 1);
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
