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
        mapping(uint => VoteOption ) options; // mapping of index+1 to options (should start from 1)
        string[] option_names; // array of option names;
        mapping(address => uint ) votes; // mapping of address to option_id (should start from 1)
    }
}
