// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.4;

/***
 * IMG 
QmQBHarz2WFczTjz5GnhjHrbUPDnB48W5BM2v2h6HbE1rZ

data
 
 */

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract LW3Punks is ERC721Enumerable, Ownable {
    using Strings for uint256;
    string _baseTokenURI;
    uint256 public _price = 0.001 ether;
    bool public _paused;
    uint256 public maxTokenIds = 10;
    uint public tokenIds;

    modifier onlyWhenPaused() {
        require(!_paused, "contract is paused");
        _;
    }

    constructor(string memory baseURI) ERC721("LW3Punks", "LW3P") {
        _baseTokenURI = baseURI;
    }

    function mint() public payable onlyWhenPaused {
        require(tokenIds < maxTokenIds, "All minted");
        require(msg.value >= _price, "Ether price not correct");
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(_exists(tokenId), "Does not exist");

        string memory baseURI = _baseURI();

        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
                : "";
    }

    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to sent eth");
    }

    receive() external payable {}

    fallback() external payable {}
}
