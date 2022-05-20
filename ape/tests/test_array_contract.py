from functools import reduce
from conftest import ARRAY


def test_array_contract(contracts):
    array_contract, _ = contracts
    calldata = [
        {"first_member": 1, "second_member": 2},
        {"first_member": 3, "second_member": 4},
    ]

    assert array_contract.view_product(1, calldata) == int(
        str(array_contract), 16
    ) + reduce(
        lambda x, y: x * y, [x for arg in calldata for x in arg.values()]
    ), "Contract is still not correct"


def test_mock_contract(contracts):
    _, mock_contract = contracts
    assert mock_contract.product_mapping() == reduce(
        lambda x, y: x * y, ARRAY
    ), "Contract is still not correct"
