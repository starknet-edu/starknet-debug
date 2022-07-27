import os
import pytest
from asynctest import TestCase
from functools import reduce
from starkware.starknet.testing.starknet import Starknet

# The path to the contract source code.
CONTRACT_FILE = os.path.join("contracts", "array_contract.cairo")
PRODUCT_ARRAY = [(x, x + 1) for x in range(1, 6, 2)]


class CairoContractTest(TestCase):
    @classmethod
    async def setUp(cls):
        cls.starknet = await Starknet.empty()

        cls.contract = await cls.starknet.deploy(
            source=CONTRACT_FILE, disable_hint_validation=True
        )

    @pytest.mark.asyncio
    async def test_array_contract(self):
        res = await self.contract.view_product(array=PRODUCT_ARRAY).call()
        self.assertEqual(
            res.call_info.result.pop(),
            self.contract.contract_address
            + reduce(lambda x, y: x * y, list(sum(PRODUCT_ARRAY, ()))),
            "Contract is still not correct",
        )
