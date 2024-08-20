// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/vault.sol"; // Adjust the path as necessary

contract GasVaultTest is Test {
    GasVault vault;
    address user;

    function setUp() public {
        vault = new GasVault();
        uint256 userPrivateKey = uint256(keccak256(abi.encodePacked("user_private_key")));
        user = vm.addr(userPrivateKey);
        vm.deal(user, 10 ether);
    }

    function testDeposit() public {
        // Arrange
        uint256 depositAmount = 1 ether;

        // Act
        vault.deposit{value: depositAmount}();

        // Assert
        assertEq(vault.totalGas(), depositAmount);
        assertEq(vault.balances(address(this)), depositAmount);
    }

    function testFailDepositZeroAmount() public {
        // Act & Assert
        vault.deposit{value: 0}(); // This should revert with InvalidAmount error
    }

    function testWithdraw() public {
    vm.startPrank(user);
    // Arrange
    uint256 depositAmount = 1 ether;
    uint256 withdrawAmount = 0.5 ether;
    vault.deposit{value: depositAmount}();

    // Debugging: Check balances before withdrawal
    emit log_named_uint("User Balance Before Withdrawal", vault.balances(address(this)));
    emit log_named_uint("Total Gas Before Withdrawal", vault.totalGas());

    // Act
    vault.withdraw(withdrawAmount);

    vm.stopPrank();

    // Assert
    assertEq(vault.totalGas(), depositAmount - withdrawAmount);
    assertEq(vault.balances(user), depositAmount - withdrawAmount);
}


    function testFailWithdrawMoreThanBalance() public {
        // Arrange
        uint256 depositAmount = 1 ether;
        vault.deposit{value: depositAmount}();

        // Act & Assert
        vault.withdraw(depositAmount + 1 ether); // This should revert with InvalidAmount error
    }

    function testExit() public {
    vm.startPrank(user);
    // Arrange
    uint256 depositAmount = 1 ether;
    vault.deposit{value: depositAmount}();

    // Debugging: Check balances before exit
    emit log_named_uint("User Balance Before Exit", vault.balances(address(this)));
    emit log_named_uint("Total Gas Before Exit", vault.totalGas());

    // Act
    vault.exit();

    vm.stopPrank();

    // Assert
    assertEq(vault.totalGas(), 0);
    assertEq(vault.balances(user), 0);
}

    function testFailExitWithZeroBalance() public {
        // Act & Assert
        vault.exit(); // This should revert with ZeroBalance error
    }

    function testMultipleDeposits() public {
        // Arrange
        uint256 firstDeposit = 1 ether;
        uint256 secondDeposit = 2 ether;

        // Act
        vault.deposit{value: firstDeposit}();
        vault.deposit{value: secondDeposit}();

        // Assert
        assertEq(vault.totalGas(), firstDeposit + secondDeposit);
        assertEq(vault.balances(address(this)), firstDeposit + secondDeposit);
    }

    function testWithdrawPartialAmount() public {
        vm.startPrank(user);
        // Arrange
        uint256 depositAmount = 3 ether;
        uint256 withdrawAmount = 1 ether;
        vault.deposit{value: depositAmount}();

        // Act
        vault.withdraw(withdrawAmount);

        vm.stopPrank();

        // Assert
        assertEq(vault.totalGas(), depositAmount - withdrawAmount);
        assertEq(vault.balances(user), depositAmount - withdrawAmount);
    }
}