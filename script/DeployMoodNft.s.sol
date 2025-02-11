//SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() public returns (MoodNft) {
        // string memory happySVG = vm.readFile("./NfTs/DynamicNFT/HappyFace.svg");
        // string memory sadSVG = vm.readFile("./NFTs/DynamicNFT/SadFace.svg");
        string
            memory happySVG = '<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg"><circle cx="100" cy="100" r="100" fill="yellow" /><circle cx="70" cy="70" r="10" fill="black" /><circle cx="130" cy="70" r="10" fill="black" /><path d="M50,130 Q100,180 150,130" stroke="black" stroke-width="5" fill="none" /></svg>';
        string
            memory sadSVG = '<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg"><circle cx="100" cy="100" r="100" fill="yellow" /><circle cx="70" cy="70" r="10" fill="black" /><circle cx="130" cy="70" r="10" fill="black" /><path d="M50,150 Q100,100 150,150" stroke="black" stroke-width="5" fill="none" /></svg>';
        // console.log(happySVG);
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageURI(happySVG),
            svgToImageURI(sadSVG)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory prefix = "data:image/svg+xml;base64,";
        string memory svgImageURIEncoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        // return string.concat(prefix, svgImageURIEncoded);
        return string(abi.encodePacked(prefix, svgImageURIEncoded));
    }
}
