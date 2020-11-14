pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/drafts/Counters.sol";

contract KYC is ERC721Full {

    constructor() ERC721Full("ClientInfo", "KYC") public { }

    using Counters for Counters.Counter;
    Counters.Counter token_ids;
