%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_contract_address
from starkware.cairo.common.registers import get_fp_and_pc

struct BasicStruct:
    member first_member : felt
    member second_member : felt
end

@view
func view_product{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    array_len : felt, array : BasicStruct*
) -> (res : felt):
    alloc_locals
    let fp_and_pc = get_fp_and_pc()
    tempvar __fp__ = fp_and_pc.fp_val
    tempvar ptr = array
    local dummy = 9
    # This could be useful for debugging...
    tempvar val = [array]
    %{
        from rich.pretty import pprint
        from rich.console import Console
        from starkware.starknet.public.abi import starknet_keccak
        from starkware.cairo.lang.vm.crypto import pedersen_hash
        console = Console(markup=False, highlight=False)
        console.print("\nHey big boy look at me".upper(), style="bold underline #FFA500")
        console.print(f"Printing {ids.val.first_member=}", style="bold #FFA500") 
        console.print("Now that you reached this why do you try exotic stuff ...?", style="bold #FFA500")
        console.print("We're gonna mess with the memory now so brace yourself ", style="bold #FFA500")
        console.print("Print the last filled memory cell with memory[ap-1]", style="bold green") # should print 1
        console.print("This is the 2nd member of the struct element guess what would output memory[ap-2] ??", style="bold green") # should print 1
        console.print("Pretty cool huh? Now we're going to access a pointer's value", style="bold #FFA500")
        console.print("Lets access a local that relies on fp's value", style="bold #FFA500")
        console.print("try memory[memory[fp+1]]", style="bold green") # should print array_len
        console.print("if you don't understand why it works like this you might want to read this https://www.cairo-lang.org/docs/how_cairo_works/consts.html#local-variables", style="bold green")
        breakpoint()
    %}
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
