pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

interface Structs {
    struct Val {
        uint256 value;
    }

    enum AssetDenomination {
        Wei
    }

    //trading and lending operations
    enum ActionType {
      Transfer,
      Deposit,
      Withdraw,
      Trade,
      Buy,
      Sell,
      Liquidate,
      Vaporize,
      Call
    }

    //delta from current token value
    enum AssetReference {
        Delta
    }

    struct AssetAmount {
        bool sign;
        AssetDenomination denomination;
        AssetReference ref;
        uint256 value;
    }

    //processes trading & lending actions
    struct ActionArgs {
        ActionType actionType;
        uint256 accountId;
        AssetAmount amount;
        uint256 primaryMarketId;
        uint256 secondaryMarketId;
        address otherAddress;
        uint256 otherAccountId;
        bytes data;
    }


    struct Info {
        address owner;
        uint256 number;
    }

    struct Wei {
        bool sign;
        uint256 value;
    }
}

contract DyDxPool is Structs {
    function getAccountWei(Info memory account, uint256 marketId) public view returns (Wei memory);
    function operate(Info[] memory, ActionArgs[] memory) public;
}


pragma solidity ^0.5.0;

interface IERC20 {

    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}


pragma solidity ^0.5.0;

contract DyDxFlashLoan is Structs {
    // mainnet addresses
    // add other token addresses here to include them in arbitrage
    address public USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address public DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public SAI = 0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359;
    address public WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    DyDxPool pool = DyDxPool(0x1E0447b19BB6EcFdAe1e4AE1694b0C3659614e4e);
    mapping(address => uint256) public currencies;
    constructor() public {
        currencies[WETH] = 1;
        currencies[SAI] = 2;
        currencies[USDC] = 3;
        currencies[DAI] = 4;
    }
    modifier onlyPool() {
        require(
            msg.sender == address(pool), "DyDx ONLY - flash loan failed"
        );_;
    }

    // checks currencies to see if the token is in the address list
    function tokenToMarketId(address token) public view returns (uint256) {
        uint256 marketId = currencies[token];
        require(marketId != 0, "INVALID Token - flash loan failed");
        return marketId - 1;
    }

    // takes out the flash loan
    function flashloan(address token, uint256 amount, bytes memory data)
        internal
    {
        // token is approved
        IERC20(token).approve(address(pool), 1 + amount);
        Info[] memory infos = new Info[](1);
        ActionArgs[] memory args = new ActionArgs[](3);
        infos[0] = Info(address(this), 0);

        // tokens are borrowed
        AssetAmount memory wamt = AssetAmount(
            false,
            AssetDenomination.Wei,
            AssetReference.Delta,
            amount);
        ActionArgs memory withdraw;

        withdraw.actionType = ActionType.Withdraw;
        withdraw.accountId = 0;
        withdraw.amount = wamt;

        withdraw.primaryMarketId = tokenToMarketId(token);
        withdraw.otherAddress = address(this);
        args[0] = withdraw;
        ActionArgs memory call;
        call.actionType = ActionType.Call;
        call.accountId = 0;

        call.otherAddress = address(this);
        call.data = data;

        args[1] = call;

        // tokens are paid back
        ActionArgs memory deposit;
        AssetAmount memory damt = AssetAmount(
            true,
            AssetDenomination.Wei,
            AssetReference.Delta,
            amount + 1);
        deposit.actionType = ActionType.Deposit;
        deposit.accountId = 0;
        deposit.amount = damt;
        deposit.primaryMarketId = tokenToMarketId(token);
        deposit.otherAddress = address(this);

        args[2] = deposit;
        pool.operate(infos, args);
    }
}

pragma solidity ^0.5.0;

//interfaces with the DyDx decentralized exchange
contract Flashloan is DyDxFlashLoan {
    uint256 public loan;
    constructor() public payable {
        (bool success, ) = WETH.call.value(msg.value)("");
        require(success, "fail to get weth");
    }

    // this is where funds are initially obtained
    function getFlashloan(address flashToken, uint256 flashAmount) external {
        uint256 balanceBefore = IERC20(flashToken).balanceOf(address(this));
        bytes memory data = abi.encode(flashToken, flashAmount, balanceBefore);
        flashloan(flashToken, flashAmount, data);
    }

    // enables receipt of the flash loan
    function callFunction(
        address,
        Info calldata,
        bytes calldata data
    ) external onlyPool {
        (address flashToken, uint256 flashAmount, uint256 balanceBefore) = abi
            .decode(data, (address, uint256, uint256));
        uint256 balanceAfter = IERC20(flashToken).balanceOf(address(this));
        require(
            balanceAfter - balanceBefore == flashAmount,
            "contract did not get the loan");
        loan = balanceAfter;
    }
}
