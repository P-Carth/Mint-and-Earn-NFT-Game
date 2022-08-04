// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract NFTTalentsCollection is ERC721, Ownable {
    uint256 public mintPrice = 0.02 ether; // ••••••••••••••••••••••••• Cost to Mint
    uint256 public totalSupply; // ------------------------------------ Current Number of Minted NFTs
    uint256 public maxSupply; // •••••••••••••••••••••••••••••••••••••• Current Supply Cap
    uint256 public votes; // ------------------------------------------ Number of Votes
    uint256 roundNumber = 0; // ••••••••••••••••••••••••••••••••••••••• Number of Iterations of Winner Selections
    address public winner; // ----------------------------------------- Winner of the Previous Round
    string _baseTokenURI; // •••••••••••••••••••••••••••••••••••••••••• Metadata Hash
    mapping(address => bool) public voterStatus; // ------------------- True = Voted; False = Has not Voted
    mapping(address => uint256) public mintedWallets; // •••••••••••••• Number of Minted NFTs per Wallet


    constructor(string memory baseURI) payable ERC721('NFT Talents', 'TLNT') {
        //baseURI = ('ipfs://QmVX3T4Gj2hDaJ6y6oE6wpqxvZ9RjZLkhH2bmxF1qaM2hd');
        _baseTokenURI = baseURI;
        // initial NFT supply cap
        maxSupply = 10;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return
            _baseTokenURI;
    }

    function selectRandomWinner() internal {
        // PseudoRandom Number Generator
        uint randomHash = uint(keccak256(abi.encodePacked(
            votes, // ••••••••••••••••••••••••••••••••••••••••••••••••• Number of Votes
            maxSupply, // --------------------------------------------- Current Supply Cap
            ownerOf(totalSupply), // •••••••••••••••••••••••••••••••••• Address of Newest NFT Owner
            winner, // ------------------------------------------------ Winner of the Previous Round
            roundNumber, // ••••••••••••••••••••••••••••••••••••••••••• Number of Iterations of Winner Selections
            msg.sender))); // ----------------------------------------- Caller of the Function
        winner = ownerOf(1 + (randomHash % totalSupply));
    }

    function increaseMaxSupply() external {
        // If at least 50% of the maximum number of NFT holders vote to increase the
        // maximum supply, then any owner of an NFT Talents token can activate an
        // "_increaseMaxSupply()" which increases the maxSupply by 50%
        require(balanceOf(msg.sender) > 0);
        require(votes >= (maxSupply / 2), 'Not enough votes');
        // select pseudo random winner
        selectRandomWinner();
        maxSupply = maxSupply * 3 / 2;
        roundNumber++;
    }

    function addVote() external {
        // adds vote to increase maxSupply
        require(balanceOf(msg.sender) > 0);
        require(voterStatus[msg.sender] == false, 'Address has already voted');
        voterStatus[msg.sender] = true;
        votes++;
    }

    function removeVote() external {
        require// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract NFTTalentsCollection is ERC721, Ownable {
    uint256 public mintPrice = 0.02 ether; // ••••••••••••••••••••••••• Cost to Mint
    uint256 public totalSupply; // ------------------------------------ Current Number of Minted NFTs
    uint256 public maxSupply; // •••••••••••••••••••••••••••••••••••••• Current Supply Cap
    uint256 public votes; // ------------------------------------------ Number of Votes
    uint256 roundNumber = 0; // ••••••••••••••••••••••••••••••••••••••• Number of Iterations of Winner Selections
    address public winner; // ----------------------------------------- Winner of the Previous Round
    string _baseTokenURI; // •••••••••••••••••••••••••••••••••••••••••• Metadata Hash
    mapping(address => bool) public voterStatus; // ------------------- True = Voted; False = Has not Voted
    mapping(address => uint256) public mintedWallets; // •••••••••••••• Number of Minted NFTs per Wallet


    constructor(string memory baseURI) payable ERC721('NFT Talents', 'TLNT') {
        //baseURI = ('ipfs://QmVX3T4Gj2hDaJ6y6oE6wpqxvZ9RjZLkhH2bmxF1qaM2hd');
        _baseTokenURI = baseURI;
        // initial NFT supply cap
        maxSupply = 10;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return
            _baseTokenURI;
    }

    function selectRandomWinner() internal {
        // PseudoRandom Number Generator
        uint randomHash = uint(keccak256(abi.encodePacked(
            votes, // ••••••••••••••••••••••••••••••••••••••••••••••••• Number of Votes
            maxSupply, // --------------------------------------------- Current Supply Cap
            ownerOf(totalSupply), // •••••••••••••••••••••••••••••••••• Address of Newest NFT Owner
            winner, // ------------------------------------------------ Winner of the Previous Round
            roundNumber, // ••••••••••••••••••••••••••••••••••••••••••• Number of Iterations of Winner Selections
            msg.sender))); // ----------------------------------------- Caller of the Function
        winner = ownerOf(1 + (randomHash % totalSupply));
    }

    function increaseMaxSupply() external {
        // If at least 50% of the maximum number of NFT holders vote to increase the
        // maximum supply, then any owner of an NFT Talents token can activate an
        // "_increaseMaxSupply()" which increases the maxSupply by 50%
        require(balanceOf(msg.sender) > 0);
        require(votes >= (maxSupply / 2), 'Not enough votes');
        // select pseudo random winner
        selectRandomWinner();
        maxSupply = maxSupply * 3 / 2;
        roundNumber++;
    }

    function addVote() external {
        // adds vote to increase maxSupply
        require(balanceOf(msg.sender) > 0);
        require(voterStatus[msg.sender] == false, 'Address has already voted');
        voterStatus[msg.sender] = true;
        votes++;
    }

    function removeVote() external {
        require(balanceOf(msg.sender) > 0);
        require(voterStatus[msg.sender] == true, 'You cannot remove your vote because you have not voted');
        voterStatus[msg.sender] = false;
        votes--;
    }

    function mint() external payable {
        require(mintedWallets[msg.sender] < 1, 'exceeds max per wallet');
        require(msg.value == mintPrice, 'wrong value');
        require(maxSupply > totalSupply, 'sold out');

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
    }

    // Remove Vote from Previous NFT Holder when NFT is Transferred to a New Account
    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721){
        super._beforeTokenTransfer(from,to,tokenId);
        require(balanceOf(to) == 0,"Recipient already owns an NFT Talents Token");
        if (voterStatus[from] == true) {
           voterStatus[from] = false;
           votes--;
        }
    }

    function withdraw() public payable {
		uint balance = address(this).balance;
        require(msg.sender == winner);
		require(balance > 0, "No ether left to withdraw");
		(bool success, ) = (msg.sender).call{value: balance}("");
		require(success, "Transfer failed.");
	}
}(balanceOf(msg.sender) > 0);
        require(voterStatus[msg.sender] == true, 'You cannot remove your vote because you have not voted');
        voterStatus[msg.sender] = false;
        votes--;
    }

    function mint() external payable {
        require(mintedWallets[msg.sender] < 1, 'exceeds max per wallet');
        require(msg.value == mintPrice, 'wrong value');
        require(maxSupply > totalSupply, 'sold out');

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
    }

    // Remove Vote from Previous NFT Holder when NFT is Transferred to a New Account
    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721){
        super._beforeTokenTransfer(from,to,tokenId);
        require(balanceOf(to) == 0,"Recipient already owns an NFT Talents Token");
        if (voterStatus[from] == true) {
           voterStatus[from] = false;
           votes--;
        }
    }

    function withdraw() public payable {
		uint balance = address(this).balance;
        require(msg.sender == winner);
		require(balance > 0, "No ether left to withdraw");
		(bool success, ) = (msg.sender).call{value: balance}("");
		require(success, "Transfer failed.");
	}
}
