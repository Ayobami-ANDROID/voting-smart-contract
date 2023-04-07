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
}
