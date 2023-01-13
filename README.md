[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/EvanGottschalk/ArbitrageAutomator">
    <img src="images/logo.png" alt="Logo" width="250" height="130">
  </a>

  <h3 align="center">ArbitrageAutomator</h3>

  <p align="center">
    A defi arbitrage bot that leverages flash loans
    <br />
    <a href="https://github.com/EvanGottschalk/ArbitrageAutomator"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/EvanGottschalk/ArbitrageAutomator">View Demo</a>
    ·
    <a href="https://github.com/EvanGottschalk/ArbitrageAutomator/issues">Report Bug</a>
    ·
    <a href="https://github.com/EvanGottschalk/ArbitrageAutomator/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

The `ArbitrageAutomator` is a trading bot built for decentralized exchanges on the Ethereum blockchain. It achieves profits by finding differing prices for the same tokens on different exchanges, and then trading them away on one platform and for them on the other for a positive return. This is known as "arbitrage".

These arbitrage opportunities exist for two reasons:
1. Liquidity Pool Size - most decentralized exchanges change their exchange rates for tokens based on how many tokens the exchange has itself. Thus, as tokens flow in and out of different exchanges' token pools, the prices on those exchanges fluctuate over time.
2. Trading Method - some decentralized exchanges use order books for trades, which means traders directly determine the possible trades available to the bot at any given time. Meanwhile, other decentralized exchanges have purely automated market prices based on their liquidity pool size. As a result, the prices of the same tokens can be different on exchanges whose prices are determined in one of these two ways.

In addition to taking advantage of automated market makers (AMMs), which are made possible thanks to blockchain, the `ArbitrageAutomator` also utilizes another blockchain innovation: flash loans.

Flash loans are zero risk, zero interest loans that can be taken out for very brief periods from decentralized exchanges. This is possible due to the nature of the Ethereum blockchain: when a transaction is attempted, it will either entirely be accepted by the blockchain, or entirely rejected if even one thing goes wrong. By including the borrowing and the repaying of the loan within the same transaction, the only outcomes are that the borrowing doesn't occur, or that the loan is taken out and repaid. There's no risk to the lender, and no risk or interest to the borrower.

Flash loans are used to fund the `ArbitrageAutomator`'s trades. First, it borrows tokens and uses them to buy a token on one exchange. It then sells those tokens at a higher price on a different decentralized exchange, and uses the returns to pay back the loan. By including all of these steps in one transaction, these loans and trades can be executed with zero risk.

### Built With

- `Web3`
- `Axios`


<!-- GETTING STARTED -->
### Installation

EXAMPLE FROM OPERATEEXCHANGEGUI

1. Clone the repository.

2. Navigate to the project folder in the command line and install the necessary packages.

```
npm install
```

3. Deploy the Solidity files for the TradingBot smart contract.

4. Fill in the .env file:
  * RPC_URL - public address of an Ethereum node
  * ADDRESS - bot account public address
  * PRIVATE_KEY - bot account private key
  * CONTRACT_ADDRESS - smart contract address

5. Run index.js

```
node src/index.js
```

6. Congratulations! Your bot is now up and running. It will check for a new arbitrage opportunity every 3 seconds by default. This value can be changed at the bottom of `index.js`


<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/EvanGottschalk/ArbitrageAutomator/issues) for a list of proposed features (and known issues).


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the GNU GPL-3 License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Evan Gottschalk - [@EvanOnEarth_eth](https://twitter.com/EvanOnEarth_eth) - evan.blockchain@gmail.com

Project Link: [https://github.com/EvanGottschalk/ArbitrageAutomator](https://github.com/EvanGottschalk/ArbitrageAutomator)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

Thinking about contributing to this project? Please do! Your Github username will then appear here.





<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/EvanGottschalk/ArbitrageAutomator.svg?style=for-the-badge
[contributors-url]: https://github.com/EvanGottschalk/ArbitrageAutomator/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/EvanGottschalk/ArbitrageAutomator.svg?style=for-the-badge
[forks-url]: https://github.com/EvanGottschalk/ArbitrageAutomator/network/members
[stars-shield]: https://img.shields.io/github/stars/EvanGottschalk/ArbitrageAutomator.svg?style=for-the-badge
[stars-url]: https://github.com/EvanGottschalk/ArbitrageAutomator/stargazers
[issues-shield]: https://img.shields.io/github/issues/EvanGottschalk/ArbitrageAutomator.svg?style=for-the-badge
[issues-url]: https://github.com/EvanGottschalk/ArbitrageAutomator/issues
[license-shield]: https://img.shields.io/github/license/EvanGottschalk/ArbitrageAutomator.svg?style=for-the-badge
[license-url]: https://github.com/EvanGottschalk/ArbitrageAutomator/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/EvanGottschalk
