// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

contract MyBank {

    mapping(address => uint256) private _balances;

    address public owner;

    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);

    constructor() payable {
        owner = msg.sender;

        if (msg.value > 0) {
            _balances[msg.sender] = msg.value;
            emit Deposit(msg.sender, msg.value);
        }
    }

    function deposit() public payable {
        require(msg.value > 0, "Enter an amount to deposit");

        _balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");

        require(
            _balances[msg.sender] >= amount,
            "Insufficient user balance"
        );

        require(
            address(this).balance >= amount,
            "Bank does not have enough ETH"
        );

        // Update balance BEFORE transferring
        _balances[msg.sender] -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "ETH transfer failed");

        emit Withdrawal(msg.sender, amount);
    }

    function viewBalance() public view returns (uint256) {
        return _balances[msg.sender];
    }

    function bankBalance() public view returns (uint256) {
        return address(this).balance;
    }
}