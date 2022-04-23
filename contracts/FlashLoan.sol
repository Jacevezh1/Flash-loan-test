// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Is FlashLoanSimpleReceiverBase to setup you contract as the receiver of the Flash Loan
contract FlashLoan is FlashLoanSimpleReceiverBase {
    using SafeMath for uint;
    event Log(address asset, uint val);

    // El constructor toma el provider del IPoolAddressesProvider(el address del pool contract) 
    constructor(IPoolAddressesProvider provider) public FlashLoanSimpleReceiverBase(provider) {}

    function createFlashLoan(address asset, uint amount) external {
        address receiver = address(this);
        bytes memory params = ""; // Use this to pass arbitrary data to executeOperation
        uint16 referralCode = 0; // It's zero because this transaction was executed by user without middleman

        // Calll method of the pool contract, which is initialized in FlashLoanSimpleReceiverBase
        POOL.flashLoanSimple(
            receiver,
            asset,
            amount,
            params,
            referralCode
        );
    }

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external returns (bool){
        // do things like arbitrage, liquidation, etc
        // abi.decode(params) to decode params
        uint amountOwing = amount.add(premium);
        IERC20(asset).approve(address(POOL), amountOwing);
        emit Log(asset, amountOwing);
        return true;
    }
}
