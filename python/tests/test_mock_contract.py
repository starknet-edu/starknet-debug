from functools import reduce
import os
import pytest
from starkware.starknet.testing.starknet import Starknet
from asynctest import TestCase
from starkware.starknet.compiler.compile import compile_starknet_files


# The path to the contract source code.
CONTRACT_FILE = os.path.join("contracts", "mock_contract.cairo")
PRODUCT_ARRAY = [1, 2, 3, 4, 5]


class CairoContractTest(TestCase):
    @classmethod
    async def setUp(cls):
        cls.starknet = await Starknet.empty()
        compiled_contract = compile_starknet_files(
            [CONTRACT_FILE], debug_info=True, disable_hint_validation=True
        )
        cls.contract = await cls.starknet.deploy(
            contract_def=compiled_contract,
            constructor_calldata=[len(PRODUCT_ARRAY), *PRODUCT_ARRAY],
        )

    @pytest.mark.asyncio
    async def test_mock_contract(self):
        res = await self.contract.product_mapping().call()
        self.assertEqual(
            res.call_info.result.pop(),
            reduce(lambda x, y: x * y, PRODUCT_ARRAY),
            "Contract is still not correct",
        )
