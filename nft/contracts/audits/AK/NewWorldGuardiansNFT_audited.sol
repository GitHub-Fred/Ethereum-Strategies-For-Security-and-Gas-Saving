// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "../../standards/ERC721A.sol";
import "./MerkleProof.sol"; //new version not compatible
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

/// @author ahoikapptn.com
/// @title New World Guardians NFT
contract NewWorldGuardiansNFTAudited is ERC721A, Ownable, Pausable {
    bool public publicSaleOpen;

    /**
     @dev maximum number of NFTs
     */
    uint256 public constant MAX_MINT = 888;

    /**
     @dev maximum number NFTs per transaction
     */
    uint256 public constant MAX_TRANSACTION_AMOUNT = 10;
    address public constant DONATION_WALLET =
        0x677d7C8020Eb61c5fd5c27E7754F579e1C4e0c38;

    /**
     @dev The percentage of the income that will be donated to the charities
     */
    uint16 public donationRatio = 1666;

    /**
    @dev open sale on 1st November 08:00 CET (UTC+1)
     */
    uint32 public openSaleTimestamp = 1667286000;

    /**
     @dev the currentPrice of the NFT
     */
    uint128 public currentPrice = 0.16 ether;

    /**
     @dev the merkle root node for whitelist validation
     */
    bytes32 public merkleRoot;

    /**
     @dev the base url - initially pointing to unrevealed data and later to revealed uri,
     */
    string public baseURIString =
        "ipfs://QmZCSFaRStj5yKSyhPTDbx1Eoh9vkphw2KdvYyFfUfp24M/";

    /**
     @dev events
     */
    event ReceivedETH(address, uint256);
    event NewTokenURI(string);

    constructor() ERC721A("New World Guardians", "NWG NFT") {}

    function mintNFT(address to, uint8 amount) external payable {
        checkMintCondition(msg.value, amount);
        require(publicSaleOpen, "Public sale not open");

        _mint(to, amount);
    }

    function whitelistMintNFT(
        address to,
        uint8 amount,
        bytes32[] calldata _merkleProof
    ) external payable {
        checkMintCondition(msg.value, amount);
        require(!publicSaleOpen, "Public sale already open");
        bytes32 leaf = keccak256(abi.encodePacked(to));
        require(
            MerkleProof.verifyCalldata(_merkleProof, merkleRoot, leaf),
            "Not on whitelist"
        );

        _mint(to, amount);
    }

    function getLeaf(address to) public pure returns (bytes32 leaf) {
        return keccak256(abi.encodePacked(to));
    }

    function mintOwner(address to, uint8 amount) external onlyOwner {
        require(amount > 0, "No amount specified");
        require(_totalMinted() + amount <= MAX_MINT, "No more NFTs"); // possible to use only < or >
        _mint(to, amount);
    }

    function checkMintCondition(uint256 value, uint8 amount) public view {
        require(value >= currentPrice * amount, "Not enough ETH sent"); // possible to use only < or >
        require(amount > 0, "No amount specified");
        require(amount <= MAX_TRANSACTION_AMOUNT, "Max amount exceeded"); // possible to use only < or >
        require(_totalMinted() + amount <= MAX_MINT, "No more NFTs"); // possible to use only < or >
        require(saleIsOpen(), "Sale not open");
    }

    /**
     * @dev set a new baseURI
     */
    function setNewURI(string memory _newURI) external onlyOwner {
        baseURIString = _newURI;
        emit NewTokenURI(_newURI);
    }

    function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        merkleRoot = _merkleRoot;
    }

    function setOpenSaleTimestamp(uint32 _timestamp) external onlyOwner {
        openSaleTimestamp = _timestamp;
    }

    function setPublicSaleOpen(bool _sale) external onlyOwner {
        publicSaleOpen = _sale;
    }

    /**
     * @dev set in 10000th of the wanted value (e.g. 16.66% are 1666)
     */
    function setDonationRatio(uint16 _donationRatio) external onlyOwner {
        // unequal variable
        donationRatio = _donationRatio;
    }

    function setCurrentPrice(uint128 _newPrice) external onlyOwner {
        currentPrice = _newPrice;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURIString;
    }

    /**
     * @dev disable ownership renouncing
     */
    function renounceOwnership() public view override onlyOwner {
        revert("Ownership cannot be renounced");
    }

    /**
    @dev withdraw all eth from contract to owner address
    */
    function withdrawAll() external onlyOwner {
        uint256 balance = address(this).balance;
        uint256 donation = (balance / 10000) * donationRatio;
        uint256 withdraw = balance - donation;

        payable(msg.sender).transfer(withdraw);
        payable(DONATION_WALLET).transfer(donation);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function saleIsOpen() public view returns (bool open) {
        return !paused() && (block.timestamp >= openSaleTimestamp);
    }

    /**
     @dev overrides
     */
    /**
     * @dev override ERC721A

     * Requirements:
     * - the contract must not be paused.
     */
    function _beforeTokenTransfers(
        address from,
        address to,
        uint256 startTokenId,
        uint256 quantity
    ) internal override {
        // no virtual required
        super._beforeTokenTransfers(from, to, startTokenId, quantity);
        require(!paused(), "Token transfer while paused");
    }

    /**
    @dev receive ether if sent directly to this contract
    */
    receive() external payable {
        if (msg.value > 0) {
            emit ReceivedETH(msg.sender, msg.value);
        }
    }
}
