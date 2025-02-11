//SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";

contract MoodNftTest is Test {
    MoodNft public moodNft;
    string public constant HAPPY_SVG_IMAGE_URI =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCiAgPGNpcmNsZSBjeD0iMTAwIiBjeT0iMTAwIiByPSIxMDAiIGZpbGw9InllbGxvdyIgLz4NCiAgPGNpcmNsZSBjeD0iNzAiIGN5PSI3MCIgcj0iMTAiIGZpbGw9ImJsYWNrIiAvPg0KICA8Y2lyY2xlIGN4PSIxMzAiIGN5PSI3MCIgcj0iMTAiIGZpbGw9ImJsYWNrIiAvPg0KICA8cGF0aCBkPSJNNTAsMTMwIFExMDAsMTgwIDE1MCwxMzAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iNSIgZmlsbD0ibm9uZSIgLz4NCjwvc3ZnPg0K";
    string public constant SAD_SVG_IMAGE_URI =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCiAgPGNpcmNsZSBjeD0iMTAwIiBjeT0iMTAwIiByPSIxMDAiIGZpbGw9InllbGxvdyIgLz4NCiAgPGNpcmNsZSBjeD0iNzAiIGN5PSI3MCIgcj0iMTAiIGZpbGw9ImJsYWNrIiAvPg0KICA8Y2lyY2xlIGN4PSIxMzAiIGN5PSI3MCIgcj0iMTAiIGZpbGw9ImJsYWNrIiAvPg0KICA8cGF0aCBkPSJNNTAsMTUwIFExMDAsMTAwIDE1MCwxNTAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iNSIgZmlsbD0ibm9uZSIgLz4NCjwvc3ZnPg0K";
    address USER = makeAddr("user");

    function setUp() public {
        moodNft = new MoodNft(HAPPY_SVG_IMAGE_URI, SAD_SVG_IMAGE_URI);
    }

    function testViewTokenIdURI() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }
}
