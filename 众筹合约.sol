// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // 导入OpenZeppelin的IERC20接口

// 定义CrowdFund众筹合约
contract CrowdFund {
    // 定义Campaign结构，用于存储众筹活动的信息
    struct Campaign{
        address creator;  // 活动创建者地址
        uint goal;   // 众筹目标金额
        uint pledged; // 已承诺的金额
        uint32 startAt;  // 活动开始时间
        uint32 endAt;  // 活动结束时间
        bool claimed;  // 是否已经领取资金
    }

    // 定义IERC20类型的token变量，用于指定合约只接收一种ERC20代币
    IERC20 public immutable token;
    uint public count;  // 活动计数器

    // 存储活动信息的映射，从活动ID映射到Campaign结构
    mapping(uint => Campaign) public campaigns;
    // 存储每个用户在每个活动中的承诺金额
    mapping (uint => mapping (address => uint)) public pledgedAmount;

    // 合约构造函数，初始化token变量
    constructor(address _token){
        token = IERC20(_token);
    }

    // 用户参与众筹项目的方法
    function pledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, "not started"); // 确保活动已经开始
        require(block.timestamp <= campaign.endAt, "ended"); // 确保活动尚未结束
        campaign.pledged += _amount; // 增加活动已承诺的金额
        pledgedAmount[_id][msg.sender] += _amount; // 记录用户在该活动的承诺金额
        token.transferFrom(msg.sender, address(this), _amount); // 从用户转移代币到合约地址
    }

    // 用户取消众筹承诺的方法
    function unpledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt, "ended"); // 确保活动尚未结束
        campaign.pledged -= _amount; // 减少活动已承诺的金额
        pledgedAmount[_id][msg.sender] -= _amount; // 减少用户在该活动的承诺金额
        token.transfer(msg.sender, _amount); // 将代币退还给用户
    }
}