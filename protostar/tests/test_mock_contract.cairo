%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from src.array_contract import BasicStruct

@contract_interface
namespace IContract {
    func product_mapping() -> (res: felt) {
    }
}

@view
func __setup__{syscall_ptr: felt*, range_check_ptr}() {
    alloc_locals;
    local contract_address: felt;
    %{
        context.contract_address = deploy_contract(
            contract_path="./src/mock_contract.cairo",
            constructor_args=[6, 1, 2, 3, 4, 5, 6]).contract_address
        ids.contract_address = context.contract_address
    %}
    return ();
}

@external
func test_view_product{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() {
    alloc_locals;
    local contract_address: felt;
    %{ ids.contract_address = context.contract_address %}
    let (res) = IContract.product_mapping(contract_address=contract_address);
    assert res = 720;
    return ();
}
