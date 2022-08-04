# Mint-and-Earn-NFT-Game

### This project was completed for the assignment three presentation of NFT Talents

`Please view the pdf powerpoint presentation located in the repo`

## Description

#### This project is an NFT minter as well as a play-2-earn game.

> The entire dapp can be interacted with on Goerli Etherscan here: https://goerli.etherscan.io/address/0xaA143964680239Ab244036c77713333Cbd223131#writeContract

#### Rules:
* <b> Only one NFT per Wallet Address </b>
* Votes to increase supply Cap can be given or taken
* Only an NFT holder can vote and/or increase the maximum supply cap
* Once at least 50% of the total NFT supply cap has voted to increase, an NFT owner can activate the supply cap increase and synchronously choose a (pseudo-)random winner that can redeem the entire balance of the contract, which exponentially grows each round as more nfts are minted.
* The winner must withdraw the balance of the contract before a new winner is selected, or they will not recieve their winnings
