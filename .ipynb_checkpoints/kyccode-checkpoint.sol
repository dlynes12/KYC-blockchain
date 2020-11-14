pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/drafts/Counters.sol";

contract KYC is ERC721Full {

    constructor() ERC721Full("ClientInfo", "KYC") public { }

    using Counters for Counters.Counter;
    Counters.Counter token_ids;
 
     struct Client {
        string name;
        string email;
        string report_uri;
    }

    // Stores token_id => Client
    // Only permanent data that you would need to use within the smart contract later should be stored on-chain
    
    mapping(uint => Client) public Clientdatabase;
    
    event NewClient(uint token_id, string report_uri);
    event ChangeClientInfo(uint token_id, string report_uri);
    
    function registerKYC(address client, string memory name, string memory email, string memory report_uri) public returns(uint) {
        token_ids.increment();
        uint token_id = token_ids.current();

        _mint(client, token_id);
        emit NewClient(token_id, report_uri);

        Clientdatabase[token_id] = Client(name, email, report_uri);

        return token_id;
    }
    
    
    function updateKYC(uint token_id, string memory report_uri) public returns(string memory) {
        

        // Permanently associates the report_uri with the token_id on-chain via Events for a lower gas-cost than storing directly in the contract's storage.
        emit ChangeClientInfo(token_id, report_uri);
        
        return Clientdatabase[token_id].report_uri;
        

    }
    
     
}

