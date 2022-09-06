# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.registers import get_fp_and_pc

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
    alloc_locals
    let fp_and_pc = get_fp_and_pc()
    tempvar __fp__ = fp_and_pc.fp_val

    # This could be useful for debugging...
    mapping.write(array_len, [array])
    tempvar array_len_ptr = &array_len
    tempvar val = [array]
    %{
        from rich.pretty import pprint
        from rich.console import Console
        from starkware.starknet.public.abi import starknet_keccak
        from starkware.cairo.lang.vm.crypto import pedersen_hash
        console = Console(markup=False, highlight=False)

        print(f"Still {ids.array_len} values to save...") 
        print(f"Saving {ids.val} to the storage...")
        console.print("Hey big boy look at me".upper(), style="bold underline #FFA500")
        console.print("Now that you reached this why do you try exotic stuff ...?", style="bold #FFA500")
        console.print("We're gonna mess with the memory now so brace yourself ", style="bold #FFA500")
        console.print("Print the last filled memory cell with memory[ap-1]", style="bold green") # should print 1
        console.print("Pretty cool huh? Now we're going to access a pointer's value", style="bold #FFA500")
        console.print("try memory[memory[ap-2]]", style="bold green") # should print array_len
        console.print("now icing on the cake we're gonna inspect the storage", style="bold #FFA500")
        console.print("now try __storage.read(pedersen_hash(starknet_keccak(b'mapping'), 5))", style="bold green") # should print the value of the key 5
        console.print("You can also check what variable is available with pprint(locals()) pprint(globals())", style="bold green") # should print the value of the key 5

        breakpoint()
    %}
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
