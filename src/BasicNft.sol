// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 tokenId => string tokenURI) private s_tokenIdToTokenURI;

    constructor() ERC721("Dogie", "DG") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory _tokenURI) public {
        s_tokenIdToTokenURI[s_tokenCounter] = _tokenURI;
        s_tokenCounter++;
        _safeMint(msg.sender, s_tokenCounter);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenIdToTokenURI[tokenId];
    }
}
