# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func mapping(key) -> (value : felt):
end

@storage_var
func mapping_length() -> (value : felt):
end

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    array_len : felt, array : felt*
):
    mapping_length.write(array_len)
    fill_mapping(array_len, array)
    return ()
end

func fill_mapping{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    array_len : felt, array : felt*
) -> ():
    if array_len == 0:
        return ()
    end

    # This could be useful for debugging...
    let val = [array]
    %{
        print(f"Still {ids.array_len} values to save...") 
        print(f"Saving {ids.val} to the storage...")
        breakpoint()
    %}
    mapping.write(array_len, [array])
    fill_mapping(array_len - 1, array + 1)
    return ()
end

@view
func product_mapping{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    res : felt
):
    let (length) = mapping_length.read()
    let (res) = product_mapping_internal(length)
    return (res)
end

func product_mapping_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    len : felt
) -> (res : felt):
    if len == 0:
        let (res) = mapping.read(len)
        return (res)
    end
    let (temp) = product_mapping_internal(len - 1)
    let (mapping_val) = mapping.read(len)
    let res = temp * mapping_val
    return (res)
end
