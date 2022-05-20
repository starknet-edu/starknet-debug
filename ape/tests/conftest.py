from re import A
import pytest

ARRAY = [1, 2, 3, 4, 5, 6]


@pytest.fixture
def contracts_type(project):
    return project.array_contract, project.mock_contract


@pytest.fixture
def contracts(contracts_type):
    array_contract = contracts_type[0].deploy()
    mock_contract = contracts_type[1].deploy(len(ARRAY), ARRAY)
    return (array_contract, mock_contract)
