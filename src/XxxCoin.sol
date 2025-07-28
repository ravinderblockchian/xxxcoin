// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {ERC20BurnableUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import {ERC20PausableUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PausableUpgradeable.sol";
import {ERC20PermitUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract XxxCoin is Initializable,
                   ERC20Upgradeable,
                   ERC20BurnableUpgradeable,
                   ERC20PausableUpgradeable,
                   OwnableUpgradeable,
                   ERC20PermitUpgradeable,
                   UUPSUpgradeable {

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address recipient, address owner_) public initializer {
        __ERC20_init("XXXCoin", "XXX");
        __ERC20Burnable_init();
        __ERC20Pausable_init();
        __Ownable_init(owner_);
        __ERC20Permit_init("XXXCoin");
        __UUPSUpgradeable_init();

        _mint(recipient, 100_000 * 10 ** decimals());
    }

    // Required by Solidity due to multiple inheritance of _update
    function _update(address from, address to, uint256 value)
        internal
        override(ERC20Upgradeable, ERC20PausableUpgradeable)
    {
        super._update(from, to, value);
    }

    // Required for UUPSUpgradeable
    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyOwner
    {}

    // Optional: pause/unpause functions
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // Optional: additional minting
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
