// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract GasVault {

    /// @notice Error thrown when an invalid amount is provided for deposit or withdrawal.
    error InvalidAmount();

    /// @notice Error thrown when a user tries to exit with a zero balance.
    error ZeroBalance();

    /// @notice Emitted when a user deposits GAS tokens into the vault.
    /// @param addr The address of the user making the deposit.
    /// @param amount The amount of GAS tokens deposited.
    event Deposited(address indexed addr, uint256 amount);

    /// @notice Emitted when a user withdraws GAS tokens from the vault.
    /// @param addr The address of the user making the withdrawal.
    /// @param amount The amount of GAS tokens withdrawn.
    event Withdrawn(address indexed addr, uint256 amount);

    /// @notice Total amount of GAS tokens deposited in the vault by all users.
    uint256 public totalGas = 0;

    /// @notice Mapping to keep track of each user's deposited balance.
    mapping(address => uint256) public balances;

    /**
     * @notice Deposits GAS tokens into the vault.
     * @dev The amount to deposit is sent along with the transaction as msg.value.
     * @dev Emits a {Deposited} event upon success.
     * @dev Reverts with `InvalidAmount` if the deposit amount is zero.
     */
    function deposit() external payable {
        if (msg.value == 0) {
            revert InvalidAmount();
        }

        balances[msg.sender] += msg.value;
        totalGas += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    /**
     * @notice Withdraws a specified amount of GAS tokens from the vault.
     * @param amount The amount of GAS tokens to withdraw.
     * @dev Emits a {Withdrawn} event upon success.
     * @dev Reverts with `InvalidAmount` if the withdrawal amount exceeds the user's balance.
     */
    function withdraw(uint256 amount) external {
        if (balances[msg.sender] < amount) {
            revert InvalidAmount();
        }

        balances[msg.sender] -= amount;
        totalGas -= amount;

        emit Withdrawn(msg.sender, amount);

        payable(msg.sender).transfer(amount);
    }

    /**
     * @notice Withdraws the user's entire balance of GAS tokens from the vault.
     * @dev Emits a {Withdrawn} event upon success.
     * @dev Reverts with `ZeroBalance` if the user's balance is zero.
     */
    function exit() external {
        uint256 amount = balances[msg.sender];
        if (amount == 0) {
            revert ZeroBalance();
        }
        
        balances[msg.sender] = 0;
        totalGas -= amount;

        emit Withdrawn(msg.sender, amount);

        payable(msg.sender).transfer(amount);
    }
}