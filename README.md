# zhongchou
管理众筹活动

使用说明：
1. 部署合约
首先，你需要部署 CrowdFund 合约到以太坊网络（测试网或主网），选择一个 ERC20 代币合约，这个合约将被用作众筹活动中的货币单位。部署 CrowdFund 合约，并在构造函数中传入 ERC20 代币合约的地址。
2. 创建众筹活动
活动创建者可以创建一个新的众筹活动：调用 CrowdFund 合约的创建活动功能，提供必要的参数，如目标金额、活动开始和结束的时间等。确保活动开始时间和结束时间设置正确，以便参与者知道何时可以进行众筹。
3. 参与众筹-用户可以参与众筹活动：
调用 pledge 函数，传入活动ID和用户想要投入的代币金额。用户的代币将从其地址转移到 CrowdFund 合约地址，同时记录用户的承诺金额。
4. 取消众筹承诺
如果活动尚未结束，用户可以取消其众筹承诺：调用 unpledge 函数，传入活动ID和用户想要取消的代币金额。用户的代币将从 CrowdFund 合约地址退还到用户地址，同时减少用户的承诺金额。
5. 检查活动状态
任何人都可以查看活动的详细信息：使用 campaigns 映射函数查看特定活动的状态，包括活动创建者、目标金额、已承诺金额、开始和结束时间等。
6. 领取资金
活动结束后，如果达到了目标金额，活动创建者可以领取资金：调用 claim 函数（该函数在提供的代码中未定义，但通常在众筹合约中会有这样的功能）。
资金将从 CrowdFund 合约地址转移到活动创建者的地址。

注意事项：
1.确保在参与众筹之前，活动已经开始且尚未结束。
2.确保在取消众筹承诺之前，活动尚未结束。
3.确保使用正确的活动ID进行操作。
4.确保你有足够的代币余额来参与众筹或取消众筹承诺。

安全提醒
1.在参与众筹之前，确保合约已通过安全审计。
2.不要向不熟悉的合约发送大量代币。
3.在主网上操作之前，在测试网上测试所有交易。

使用工具
1.使用 MetaMask 或其他以太坊钱包来与合约交互。
2.使用 Remix、Truffle、Hardhat 或其他开发环境来部署合约和测试交易。
