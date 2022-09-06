%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from src.array_contract import BasicStruct

@contract_interface
namespace IContract {
    func view_product(arr_len: felt, arr: BasicStruct*) -> (res: felt) {
    }
}

@view
func __setup__{syscall_ptr: felt*, range_check_ptr}() {
    alloc_locals;
    local contract_address: felt;
    %{
        context.contract_address = deploy_contract("./src/array_contract.cairo",).contract_address
        ids.contract_address = context.contract_address
    %}
    return ();
}

@external
func test_view_product{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() {
    alloc_locals;
    local contract_address: felt;
    %{ ids.contract_address = context.contract_address %}
    let (local arr: BasicStruct*) = alloc();
    assert arr[0] = BasicStruct(1, 2);
    assert arr[1] = BasicStruct(3, 4);
    assert arr[2] = BasicStruct(5, 6);
    let (res) = IContract.view_product(contract_address=contract_address, arr_len=3, arr=arr);
    assert res = 720 + contract_address;
    return ();
}
