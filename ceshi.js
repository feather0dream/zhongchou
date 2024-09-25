// 假设部署已经成功，以下是使用Hardhat的测试脚本示例。

const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CrowdFund Contract Tests", function () {
    let token;
    let crowdFund;
    let owner;
    let addr1;
    let addr2;
    let campaignId;

    beforeEach(async function () {
        // 获取合约部署者和另一个账户
        [owner, addr1, addr2] = await ethers.getSigners();

        // 部署ERC20代币合约（假设有一个代币合约）
        const Token = await ethers.getContractFactory("YourERC20Token");
        token = await Token.deploy("Test Token", "TTK", 18, 1000000);

        // 部署CrowdFund合约
        const CrowdFund = await ethers.getContractFactory("CrowdFund");
        crowdFund = await CrowdFund.deploy(token.address);
    });

    it("Should create a campaign", async function () {
        // 创建众筹活动
        const tx = await crowdFund.createCampaign(1000, 100, 1, 100);
        await tx.wait();

        // 获取活动ID
        campaignId = tx.events[0].args.campaignId;

        // 验证活动是否创建
        const campaign = await crowdFund.campaigns(campaignId);
        expect(campaign.creator).to.equal(owner.address);
        expect(campaign.goal).to.equal(1000);
    });

    it("Should pledge to a campaign", async function () {
        // 假设已经创建了活动
        const tx = await crowdFund.connect(addr1).pledge(campaignId, 50);
        await tx.wait();

        // 验证承诺金额是否正确
        const pledgedAmount = await crowdFund.pledgedAmount(campaignId, addr1.address);
        expect(pledgedAmount).to.equal(50);
    });

    it("Should fail to pledge before campaign starts", async function () {
        // 尝试在活动开始前参与众筹
        await expect(crowdFund.connect(addr1).pledge(campaignId, 50)).to.be.revertedWith("not started");
    });

    // 添加其他测试用例...
});