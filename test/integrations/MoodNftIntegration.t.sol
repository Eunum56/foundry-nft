//SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract MoodNftIntegrationTest is Test {
    MoodNft public moodNft;
    string public constant HAPPY_SVG_IMAGE_URI =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCiAgPGNpcmNsZSBjeD0iMTAwIiBjeT0iMTAwIiByPSIxMDAiIGZpbGw9InllbGxvdyIgLz4NCiAgPGNpcmNsZSBjeD0iNzAiIGN5PSI3MCIgcj0iMTAiIGZpbGw9ImJsYWNrIiAvPg0KICA8Y2lyY2xlIGN4PSIxMzAiIGN5PSI3MCIgcj0iMTAiIGZpbGw9ImJsYWNrIiAvPg0KICA8cGF0aCBkPSJNNTAsMTMwIFExMDAsMTgwIDE1MCwxMzAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iNSIgZmlsbD0ibm9uZSIgLz4NCjwvc3ZnPg0K";
    string public constant SAD_SVG_IMAGE_URI =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCiAgPGNpcmNsZSBjeD0iMTAwIiBjeT0iMTAwIiByPSIxMDAiIGZpbGw9InllbGxvdyIgLz4NCiAgPGNpcmNsZSBjeD0iNzAiIGN5PSI3MCIgcj0iMTAiIGZpbGw9ImJsYWNrIiAvPg0KICA8Y2lyY2xlIGN4PSIxMzAiIGN5PSI3MCIgcj0iMTAiIGZpbGw9ImJsYWNrIiAvPg0KICA8cGF0aCBkPSJNNTAsMTUwIFExMDAsMTAwIDE1MCwxNTAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iNSIgZmlsbD0ibm9uZSIgLz4NCjwvc3ZnPg0K";
    string public constant HAPPY_SVG_URI =
        "data:applicaion/json;base64,eyJuYW1lIjoiTW9vZCBOZnQiLCAiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIzYVdSMGFEMGlNakF3SWlCb1pXbG5hSFE5SWpJd01DSWdlRzFzYm5NOUltaDBkSEE2THk5M2QzY3Vkek11YjNKbkx6SXdNREF2YzNabklqNDhZMmx5WTJ4bElHTjRQU0l4TURBaUlHTjVQU0l4TURBaUlISTlJakV3TUNJZ1ptbHNiRDBpZVdWc2JHOTNJaUF2UGp4amFYSmpiR1VnWTNnOUlqY3dJaUJqZVQwaU56QWlJSEk5SWpFd0lpQm1hV3hzUFNKaWJHRmpheUlnTHo0OFkybHlZMnhsSUdONFBTSXhNekFpSUdONVBTSTNNQ0lnY2owaU1UQWlJR1pwYkd3OUltSnNZV05ySWlBdlBqeHdZWFJvSUdROUlrMDFNQ3d4TXpBZ1VURXdNQ3d4T0RBZ01UVXdMREV6TUNJZ2MzUnliMnRsUFNKaWJHRmpheUlnYzNSeWIydGxMWGRwWkhSb1BTSTFJaUJtYVd4c1BTSnViMjVsSWlBdlBqd3ZjM1puUGc9PSJ9";
    string public constant SAD_SVG_URI =
        "data:applicaion/json;base64,eyJuYW1lIjoiTW9vZCBOZnQiLCAiZGVzY3JpcHRpb24iOiJBbiBORlQgdGhhdCByZWZsZWN0cyB0aGUgbW9vZCBvZiB0aGUgb3duZXIsIDEwMCUgb24gQ2hhaW4hIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogIm1vb2RpbmVzcyIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIzYVdSMGFEMGlNakF3SWlCb1pXbG5hSFE5SWpJd01DSWdlRzFzYm5NOUltaDBkSEE2THk5M2QzY3Vkek11YjNKbkx6SXdNREF2YzNabklqNDhZMmx5WTJ4bElHTjRQU0l4TURBaUlHTjVQU0l4TURBaUlISTlJakV3TUNJZ1ptbHNiRDBpZVdWc2JHOTNJaUF2UGp4amFYSmpiR1VnWTNnOUlqY3dJaUJqZVQwaU56QWlJSEk5SWpFd0lpQm1hV3hzUFNKaWJHRmpheUlnTHo0OFkybHlZMnhsSUdONFBTSXhNekFpSUdONVBTSTNNQ0lnY2owaU1UQWlJR1pwYkd3OUltSnNZV05ySWlBdlBqeHdZWFJvSUdROUlrMDFNQ3d4TlRBZ1VURXdNQ3d4TURBZ01UVXdMREUxTUNJZ2MzUnliMnRsUFNKaWJHRmpheUlnYzNSeWIydGxMWGRwWkhSb1BTSTFJaUJtYVd4c1BTSnViMjVsSWlBdlBqd3ZjM1puUGc9PSJ9";
    address USER = makeAddr("user");
    DeployMoodNft deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function testViewTokenIdURIIntgreation() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }

    function testFlipMoodTokenToSad() public {
        vm.startPrank(USER);
        moodNft.mintNft();

        moodNft.filpMood(0);

        vm.stopPrank();

        assertEq(keccak256(abi.encodePacked(moodNft.tokenURI(0))), keccak256(abi.encodePacked(SAD_SVG_URI)));
    }
}
