import os
import pytest
from asynctest import TestCase
from functools import reduce
from starkware.starknet.testing.starknet import Starknet

# The path to the contract source code.
CONTRACT_FILE = os.path.join("contracts", "mock_contract.cairo")
PRODUCT_ARRAY = [1, 2, 3, 4, 5]


class CairoContractTest(TestCase):
    @classmethod
    async def setUp(cls):
        cls.starknet = await Starknet.empty()

        cls.contract = await cls.starknet.deploy(
            source=CONTRACT_FILE,
            constructor_calldata=[len(PRODUCT_ARRAY), *PRODUCT_ARRAY],
            disable_hint_validation=True,
        )

    @pytest.mark.asyncio
    async def test_mock_contract(self):
        res = await self.contract.product_mapping().call()
        self.assertEqual(
            res.call_info.result.pop(),
            reduce(lambda x, y: x * y, PRODUCT_ARRAY),
            "Contract is still not correct",
        )
