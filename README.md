Deployed contract address: 0x2AEba18dB80D44c41ba6339cb9E0FCAef7A9766B

# GasVault Smart Contract

## Overview

The **GasVault** is a smart contract implemented in Solidity that allows users to deposit and withdraw GAS tokens (represented as Ether in this example). The contract keeps track of each user's deposit balance and the total amount of GAS tokens deposited by all users.

## Features

- **Deposit**: Users can deposit GAS tokens into the vault.
- **Withdraw**: Users can withdraw a specified amount of their deposited GAS tokens.
- **Exit**: Users can withdraw their entire balance of GAS tokens from the vault.

## Contract Details

### `GasVault.sol`

The `GasVault` smart contract includes the following key functionalities:

- **Deposit**: Allows users to deposit Ether into the contract.
- **Withdraw**: Allows users to withdraw a specified amount of their Ether balance from the contract.
- **Exit**: Allows users to withdraw their entire balance from the contract.

#### Functions

- `deposit()`: Deposits GAS tokens (Ether) into the vault. Reverts if the deposit amount is zero.
- `withdraw(uint256 amount)`: Withdraws a specified amount of GAS tokens from the vault. Reverts if the withdrawal amount exceeds the user's balance.
- `exit()`: Withdraws the user's entire balance of GAS tokens. Reverts if the user's balance is zero.

#### Events

- `Deposited(address indexed addr, uint256 amount)`: Emitted when a user deposits GAS tokens into the vault.
- `Withdrawn(address indexed addr, uint256 amount)`: Emitted when a user withdraws GAS tokens from the vault.

## Installation

To get started with this repository, you need to have [Foundry](https://book.getfoundry.sh/) installed.

1. **Clone the repository**:

   ```sh
   git clone https://github.com/your-username/gas-vault.git
   cd gas-vault
   ```
2. **Install dependencies:**

   ```sh
   forge install
   ```
3. **Build smart contract:**
    ```sh
    forge build
    ```
## Running Tests
The repository includes comprehensive tests for the GasVault smart contract. The tests are written using Foundry's testing framework.

### Test Cases
1. **testDeposit**: Tests the deposit functionality to ensure that deposited Ether is correctly recorded.

2. **testWithdraw**: Tests the withdraw functionality to ensure that users can withdraw their deposited Ether.

3. **testExit**: Tests the exit functionality to ensure that users can withdraw their entire balance.

4. **testFailDepositZeroAmount**: Tests that depositing zero Ether reverts as expected.

5. **testFailWithdrawMoreThanBalance**: Tests that attempting to withdraw more than the available balance reverts.

6. **testFailExitWithZeroBalance**: Tests that attempting to exit with zero balance reverts.

7. **testMultipleDeposits**: Tests multiple deposits by the same user to ensure correct balance tracking.

8. **testWithdrawPartialAmount**: Tests withdrawing a partial amount from the user's balance.

## Running Tests

```sh
forge test
```
### Deployment
To deploy the GasVault contract on a local or public Ethereum network:

Configure your deployment script: Ensure you have the correct network configurations in place.
Deploy using Foundry: You can deploy your contract using Foundry's forge create command or by writing a deployment script.

sample deployment command
```sh
    forge create GasVault --private-key <YOUR_PRIVATE_KEY> --rpc-url <RPC_URL>
```