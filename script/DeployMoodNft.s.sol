//SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() public returns (MoodNft) {
        string memory happySVG = vm.readFile("./NfTs/DynamicNFT/HappyFace.svg");
        string memory sadSVG = vm.readFile("./NFTs/DynamicNFT/SadFace.svg");
        // console.log(happySVG);
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(svgToImageURI(happySVG), svgToImageURI(sadSVG));
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory prefix = "data:image/svg+xml;base64,";
        string memory svgImageURIEncoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        // return string.concat(prefix, svgImageURIEncoded);
        return string(abi.encodePacked(prefix, svgImageURIEncoded));
    }
}
