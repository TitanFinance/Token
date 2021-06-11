// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SafeMath.sol";
import "./Address.sol";
import "./Ownable.sol";
import "./IBEP20.sol";

contract LockContract is Ownable {
    using SafeMath for uint256;
    using Address for address;

    uint256 public _startedLockedTime;
    uint256 public _lockedPeriodForStaking = 4 weeks;
    uint256 public _lockedPeriodForTeamAndDevelopmentAndMarketing = 6 * 4 weeks;
    uint256 public _lockedPeriodForReserve = 12 * 4 weeks;
    uint256 public _lockedPeriodLP = 12 * 4 weeks;

    uint256 public _stakignAmount = 10 * 10**9 * 10**9;
    uint256 public _teamAmount = 5 * 10**9 * 10**9;
    uint256 public _developAmount = 5 * 10**9 * 10**9;
    uint256 public _marketingAmount = 5 * 10**9 * 10**9;
    uint256 public _reserveAmount = 25 * 10**9 * 10**9;

    address public _tokenAddress;
    address public _lpAddress;

    address public _stakingAddress;
    address public _teamAddress;
    address public _developAddress;
    address public _marketingAddress;
    address public _reserveAddress;

    constructor() {}

    function startLock() external onlyOwner {
        _startedLockedTime = block.timestamp;
    }

    function setTokenAddress(address tokenAddress) external onlyOwner {
        require(_startedLockedTime != 0);
        _tokenAddress = tokenAddress;
    }

    function setLpAddress(address lpAddress) external onlyOwner {
        require(_startedLockedTime != 0);
        _lpAddress = lpAddress;
    }

    function setStakingAddress(address stakingAddress) external onlyOwner {
        _stakingAddress = stakingAddress;
    }

    function setTeamAddress(address teamAddress) external onlyOwner {
        _teamAddress = teamAddress;
    }

    function setDevelopAddress(address developAddress) external onlyOwner {
        _developAddress = developAddress;
    }

    function setMarketingAddress(address marketingAddress) external onlyOwner {
        _marketingAddress = marketingAddress;
    }

    function setReserveAddress(address reserveAddress) external onlyOwner {
        _reserveAddress = reserveAddress;
    }

    function withdrawStakingToken() external {
        require(_tokenAddress != address(0));
        require(
            _stakingAddress != address(0) && _stakingAddress == _msgSender()
        );
        require(
            block.timestamp > _startedLockedTime.add(_lockedPeriodForStaking)
        );
        uint256 balance = IBEP20(_tokenAddress).balanceOf(address(this));
        if (_stakignAmount > balance) {
            _stakignAmount = balance;
        }
        IBEP20(_tokenAddress).transfer(_msgSender(), _stakignAmount);
        _stakignAmount = 0;
    }

    function withdrawTeamToken() external {
        require(_tokenAddress != address(0));
        require(_teamAddress != address(0) && _teamAddress == _msgSender());
        require(
            block.timestamp >
                _startedLockedTime.add(
                    _lockedPeriodForTeamAndDevelopmentAndMarketing
                )
        );
        uint256 balance = IBEP20(_tokenAddress).balanceOf(address(this));
        if (_teamAmount > balance) {
            _teamAmount = balance;
        }
        IBEP20(_tokenAddress).transfer(_msgSender(), _teamAmount);
        _teamAmount = 0;
    }

    function withdrawDevelopToken() external {
        require(_tokenAddress != address(0));
        require(
            _developAddress != address(0) && _developAddress == _msgSender()
        );
        require(
            block.timestamp >
                _startedLockedTime.add(
                    _lockedPeriodForTeamAndDevelopmentAndMarketing
                )
        );
        uint256 balance = IBEP20(_tokenAddress).balanceOf(address(this));
        if (_developAmount > balance) {
            _developAmount = balance;
        }
        IBEP20(_tokenAddress).transfer(_msgSender(), _developAmount);
        _developAmount = 0;
    }

    function withdrawMarketingToken() external {
        require(_tokenAddress != address(0));
        require(
            _marketingAddress != address(0) && _marketingAddress == _msgSender()
        );
        require(
            block.timestamp >
                _startedLockedTime.add(
                    _lockedPeriodForTeamAndDevelopmentAndMarketing
                )
        );
        uint256 balance = IBEP20(_tokenAddress).balanceOf(address(this));
        if (_marketingAmount > balance) {
            _marketingAmount = balance;
        }
        IBEP20(_tokenAddress).transfer(_msgSender(), _marketingAmount);
        _marketingAmount = 0;
    }

    function withdrawReserveToken() external {
        require(_tokenAddress != address(0));
        require(
            _reserveAddress != address(0) && _reserveAddress == _msgSender()
        );
        require(
            block.timestamp > _startedLockedTime.add(_lockedPeriodForReserve)
        );
        uint256 balance = IBEP20(_tokenAddress).balanceOf(address(this));
        IBEP20(_tokenAddress).transfer(_msgSender(), balance);
    }

    function withdrawLpToken() external onlyOwner {
        require(_lpAddress != address(0));
        require(block.timestamp > _startedLockedTime.add(_lockedPeriodLP));
        uint256 balance = IBEP20(_lpAddress).balanceOf(address(this));
        IBEP20(_tokenAddress).transfer(_msgSender(), balance);
    }
}
