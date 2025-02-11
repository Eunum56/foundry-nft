// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployMoodNft;

    function setUp() public {
        deployMoodNft = new DeployMoodNft();
    }

    function testConvertSvgToURI() public view {
        string memory expectedHappyFaceImageURI =
            "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIHI9IjEwMCIgZmlsbD0ieWVsbG93IiAvPjxjaXJjbGUgY3g9IjcwIiBjeT0iNzAiIHI9IjEwIiBmaWxsPSJibGFjayIgLz48Y2lyY2xlIGN4PSIxMzAiIGN5PSI3MCIgcj0iMTAiIGZpbGw9ImJsYWNrIiAvPjxwYXRoIGQ9Ik01MCwxMzAgUTEwMCwxODAgMTUwLDEzMCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSI1IiBmaWxsPSJub25lIiAvPjwvc3ZnPg==";
        string memory expectedSadFaceImageURI =
            "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIHI9IjEwMCIgZmlsbD0ieWVsbG93IiAvPjxjaXJjbGUgY3g9IjcwIiBjeT0iNzAiIHI9IjEwIiBmaWxsPSJibGFjayIgLz48Y2lyY2xlIGN4PSIxMzAiIGN5PSI3MCIgcj0iMTAiIGZpbGw9ImJsYWNrIiAvPjxwYXRoIGQ9Ik01MCwxNTAgUTEwMCwxMDAgMTUwLDE1MCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSI1IiBmaWxsPSJub25lIiAvPjwvc3ZnPg==";
        string memory happySVG =
            '<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg"><circle cx="100" cy="100" r="100" fill="yellow" /><circle cx="70" cy="70" r="10" fill="black" /><circle cx="130" cy="70" r="10" fill="black" /><path d="M50,130 Q100,180 150,130" stroke="black" stroke-width="5" fill="none" /></svg>';
        string memory sadSVG =
            '<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg"><circle cx="100" cy="100" r="100" fill="yellow" /><circle cx="70" cy="70" r="10" fill="black" /><circle cx="130" cy="70" r="10" fill="black" /><path d="M50,150 Q100,100 150,150" stroke="black" stroke-width="5" fill="none" /></svg>';
        string memory happyFaceImageURI = deployMoodNft.svgToImageURI(happySVG);
        string memory sadFaceImageURI = deployMoodNft.svgToImageURI(sadSVG);
        // console.log(expectedSadFaceImageURI);
        // console.log(sadFaceImageURI);
        assert(keccak256(abi.encodePacked(expectedHappyFaceImageURI)) == keccak256(abi.encodePacked(happyFaceImageURI)));
        assert(keccak256(abi.encodePacked(expectedSadFaceImageURI)) == keccak256(abi.encodePacked(sadFaceImageURI)));
    }
}
