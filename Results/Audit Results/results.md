Here the results of the audits are presented.

They were generated with npx hardhat test.
For regeneration an own Goerli network key from Alchemy needs to be created.

Output:

 npx hardhat test


  Test Akutar
Original Contract 1619430 Audited Contract 1324998 Gas Difference 294432
    ✔ Deployment costs (1290ms)

  Test NWGs
Original Contract 3924686 Audited Contract 2142770 Gas Difference 1781916
        Original Contract with transaction setDonationRatio:
        Gas cost for transaction: 27070
        Audited Contract with transaction setDonationRatio:
        Gas cost for transaction: 26711
        Difference:  359
        Original Contract with transaction setPublicSaleOpen:
        Gas cost for transaction: 27019
        Audited Contract with transaction setPublicSaleOpen:
        Gas cost for transaction: 26833
        Difference:  186
        Original Contract with transaction mint:
    ✔ Deployment costs and changed functions (546ms)
        Gas cost for transaction: 101284
        Audited Contract with transaction mint:
        Gas cost for transaction: 99705
        Difference:  1579

  Test RoadsToDreams
Original Contract 2720637 Audited Contract 2685912 Gas Difference 34725
    ✔ Deployment costs (222ms)

  Test Soccer
Original Contract 3125578 Audited Contract 1769748 Gas Difference 1355830
        Original Contract with transaction mint:
    ✔ Deployment costs and changed functions (233ms)
        Gas cost for transaction: 101902
        Audited Contract with transaction mint:
        Gas cost for transaction: 100415
        Difference:  1487

  OpenZeppelin ERC721Enumerable
        Gas cost for minting 1: 103135
        Gas cost for minting 2: 217921
        Gas cost for minting 3: 332707
        Gas cost for minting 4: 447493
        Gas cost for minting 5: 562279
    ✔ can batch mint (523ms)
    ✔ Try mint more then maxBatchSize (135ms)
        Minted 1, transferred Token with id: 0, cost: 68375
        Minted 2, transferred Token with id: 1, cost: 89087
        Minted 2, transferred Token with id: 0, cost: 93769
        Minted 3, transferred Token with id: 2, cost: 89087
        Minted 3, transferred Token with id: 1, cost: 99381
        Minted 3, transferred Token with id: 0, cost: 93769
        Minted 4, transferred Token with id: 3, cost: 89087
        Minted 4, transferred Token with id: 2, cost: 99381
        Minted 4, transferred Token with id: 1, cost: 99381
        Minted 4, transferred Token with id: 0, cost: 93769
        Minted 5, transferred Token with id: 4, cost: 89087
        Minted 5, transferred Token with id: 3, cost: 99381
        Minted 5, transferred Token with id: 2, cost: 99381
        Minted 5, transferred Token with id: 1, cost: 99381
        Minted 5, transferred Token with id: 0, cost: 93769
    ✔ Transfer token after minting a batch of NFTs (2225ms)

  Azuki ERC721A
        Gas cost for minting 1: 91957
        Gas cost for minting 2: 94285
        Gas cost for minting 3: 96613
        Gas cost for minting 4: 98941
        Gas cost for minting 5: 101269
    ✔ can batch mint (433ms)
    ✔ Try mint more then maxBatchSize (83ms)
        Minted 1, transferred Token with id: 0, cost: 69746
        Minted 2, transferred Token with id: 1, cost: 89270
        Minted 2, transferred Token with id: 0, cost: 90121
        Minted 3, transferred Token with id: 2, cost: 91682
        Minted 3, transferred Token with id: 1, cost: 109645
        Minted 3, transferred Token with id: 0, cost: 90121
        Minted 4, transferred Token with id: 3, cost: 94094
        Minted 4, transferred Token with id: 2, cost: 112057
        Minted 4, transferred Token with id: 1, cost: 109645
        Minted 4, transferred Token with id: 0, cost: 90121
        Minted 5, transferred Token with id: 4, cost: 96506
        Minted 5, transferred Token with id: 3, cost: 114469
        Minted 5, transferred Token with id: 2, cost: 112057
        Minted 5, transferred Token with id: 1, cost: 109645
        Minted 5, transferred Token with id: 0, cost: 90121
    ✔ Transfer token after minting a batch of NFTs (1780ms)

  Tiny ERC721
        Gas cost for minting 1: 68570
        Gas cost for minting 2: 70627
        Gas cost for minting 3: 72684
        Gas cost for minting 4: 74741
        Gas cost for minting 5: 76798
    ✔ can batch mint (400ms)
        Minted 1, transferred Token with id: 0, cost: 39253
        Minted 2, transferred Token with id: 1, cost: 58597
        Minted 2, transferred Token with id: 0, cost: 61530
        Minted 3, transferred Token with id: 2, cost: 60829
        Minted 3, transferred Token with id: 1, cost: 80874
        Minted 3, transferred Token with id: 0, cost: 61530
        Minted 4, transferred Token with id: 3, cost: 63061
        Minted 4, transferred Token with id: 2, cost: 83106
        Minted 4, transferred Token with id: 1, cost: 80874
        Minted 4, transferred Token with id: 0, cost: 61530
        Minted 5, transferred Token with id: 4, cost: 65293
        Minted 5, transferred Token with id: 3, cost: 85338
        Minted 5, transferred Token with id: 2, cost: 83106
        Minted 5, transferred Token with id: 1, cost: 80874
        Minted 5, transferred Token with id: 0, cost: 61530
    ✔ Transfer token after minting a batch of NFTs (1716ms)

  ERC 1155
        Gas cost for minting 1: 48417
        Gas cost for minting 2: 48417
        Gas cost for minting 3: 48417
        Gas cost for minting 4: 48417
        Gas cost for minting 5: 48417
    ✔ can batch mint (431ms)
    ✔ Try mint more then maxBatchSize (86ms)
        Minted 1, transferred Token with id: 1, cost: 51692
        Minted 2, transferred Token with id: 1, cost: 56492
        Minted 2, transferred Token with id: 1, cost: 56492
        Minted 3, transferred Token with id: 1, cost: 56492
        Minted 3, transferred Token with id: 1, cost: 56492
        Minted 3, transferred Token with id: 1, cost: 56492
        Minted 4, transferred Token with id: 1, cost: 56492
        Minted 4, transferred Token with id: 1, cost: 56492
        Minted 4, transferred Token with id: 1, cost: 56492
        Minted 4, transferred Token with id: 1, cost: 56492
        Minted 5, transferred Token with id: 1, cost: 56492
        Minted 5, transferred Token with id: 1, cost: 56492
        Minted 5, transferred Token with id: 1, cost: 56492
        Minted 5, transferred Token with id: 1, cost: 56492
        Minted 5, transferred Token with id: 1, cost: 56492
    ✔ Transfer token after minting a batch of NFTs (1739ms)


  15 passing (12s)