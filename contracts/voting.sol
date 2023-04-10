//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract voting{

    struct voteOption{
        string name;
        uint count;
    }

      struct Poll {
        address owner;
        string name;
        string description;
        uint start_time;
        uint end_time;
        uint fee;
        uint option_count; // Number of options
        mapping(uint => voteOption ) options; // mapping of index+1 to options (should start from 1)
        string[] option_names; // array of option names;
        mapping(address => uint ) votes; // mapping of address to option_id (should start from 1)
    }

    struct GetVotesReturn {
       address[] poll_owners;
       string[] poll_names;
       string[] poll_descriptions;
       uint[] poll_start_times;
       uint[] poll_end_times;
       uint[] poll_fees;
       uint[] poll_ids;
       string[][] poll_options;
       uint[][] poll_options_votes;
       uint[] poll_voted_idxs;
    }
      uint polls_created;
    // Mapping of addresses to usernames
    mapping(address => string ) address_to_username;
    mapping(string => address ) username_to_address;

    mapping(uint => Poll) polls;


    // variables    
    address public owner;

     event createPollEvt(uint pollId, address owner, string name, string description, uint start_time, uint end_time, uint fee, string[] options);

    constructor() {
        owner = msg.sender;
    }

      function validStr(string memory str) private pure returns(bool isValid) {
        return bytes(str).length >= 1;
    }

       function createPoll(string memory name, string memory description, uint start_time, uint end_time, uint fee, string[] memory options) public {
        // Check string length
        require(validStr(name) && validStr(description));
        // Check end time after start time
        require(end_time >= start_time);
        // Check more than one option
        require(options.length >= 2);
        // Check that options have valid names
        for (uint i=0; i<options.length; i++) {
            require(validStr(options[i]));
        }

        // Adding the poll
        Poll storage newPoll = polls[polls_created];
        newPoll.owner = msg.sender;
        newPoll.name = name;
        newPoll.description = description;
        newPoll.start_time = start_time;
        newPoll.end_time = end_time;
        newPoll.fee = fee;
        newPoll.option_count = options.length;
        newPoll.option_names = options;

        // Adding the poll options
        for (uint i=0; i<options.length; i++) {
            voteOption storage option = newPoll.options[newPoll.option_count+1];
            option.name = options[i];   
        }


        emit createPollEvt(polls_created, msg.sender, name, description, start_time, end_time, fee, options);

        // Increment poll id
        polls_created++;
    }

    function getUser() public view returns(string memory username) {
        return address_to_username[msg.sender];
    }

    function createUser(string memory username) public{
        // Make checks to ensure user name is not empty && not taken && address not registered
        require(validStr(username));
        address_to_username[msg.sender] = username;
        username_to_address[username] = msg.sender;
    }
}
