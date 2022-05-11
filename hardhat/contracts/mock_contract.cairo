# # Declare this file as a StarkNet contract.
# %lang starknet

# from starkware.cairo.common.cairo_builtins import HashBuiltin

# struct Struct:
#     member first_member : felt
#     member second_member : felt
# end

# # Define a storage variable.
# @storage_var
# func mapping(key) -> (value : Struct):
# end

# @storage_var
# func mapping_length() -> (value : felt):
# end

# @constructor
# func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
#     array_len : felt, array : Struct*
# ):
#     mapping_length.write(array_len)
#     fill_mapping(array_len, array)
#     return ()
# end

# func fill_mapping{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
#     array_len : felt, array : Struct*
# ) -> ():
#     if array_len == 0:
#         return ()
#     end
#     let val = [array]
#     %{ print("here", ids.val) %}
#     mapping.write(array_len, [array])
#     fill_mapping(array_len - 1, array + 1)
#     return ()
# end

# @view
# func product_mapping{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
#     res : felt
# ):
#     let (length) = mapping_length.read()
#     let (res) = product_mapping_internal(length)
#     return (res)
# end

# func product_mapping_internal{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
#     len : felt
# ) -> (res : felt):
#     if len == 0:
#         let (res) = mapping.read(len)
#         return (res)
#     end
#     let (temp) = product_mapping_internal(len - 1)
#     %{ print(ids.temp) %}
#     let (mapping_val) = mapping.read(len)
#     let res = temp * mapping_val
#     return (res)
# end
