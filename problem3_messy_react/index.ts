enum Blockchain {
  Osmosis = "Osmosis",
  Ethereum = "Ethereum",
  Arbitrum = "Arbitrum",
  Zilliqa = "Zilliqa",
  Neo = "Neo",
}

interface WalletBalance {
  currency: string;
  amount: number;
  blockchain: Blockchain;
}

interface Props extends BoxProps {}

const WalletPage: React.FC<Props> = (props) => {
  const { ...rest } = props;
  const balances = useWalletBalances();
  const prices = usePrices();

  const getPriority = (blockchain: Blockchain): number => {
    switch (blockchain) {
      case Blockchain.Osmosis:
        return 100;
      case Blockchain.Ethereum:
        return 50;
      case Blockchain.Arbitrum:
        return 30;
      case Blockchain.Zilliqa:
      case Blockchain.Neo:
        return 20;
      default:
        return -99;
    }
  };

  const sortedBalances = useMemo(() => {
    return balances
      .filter(
        (balance) => getPriority(balance.blockchain) > -99 && balance.amount > 0
      )
      .sort((lhs, rhs) => {
        const leftPriority = getPriority(lhs.blockchain);
        const rightPriority = getPriority(rhs.blockchain);

        if (leftPriority > rightPriority) return -1;
        if (leftPriority < rightPriority) return 1;
        return 0; // Trường hợp bằng nhau, trả về 0 để giữ nguyên thứ tự
      });
  }, [balances]);

  return (
    <div {...rest}>
      {sortedBalances.map((balance, index) => (
        <WalletRow
          className={classes.row}
          key={${balance.currency}-${balance.blockchain}}
          amount={balance.amount}
          usdValue={prices[balance.currency] * balance.amount}
          formattedAmount={balance.amount.toFixed()}
        />
      ))}
    </div>
  );
};
