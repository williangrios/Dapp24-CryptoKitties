// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;
import "./ERC721Token.sol";

contract Cryptokitties is ERC721Token {

    struct Kitti {
        uint id;
        uint generation;
        uint geneA;
        uint geneB;
    }

    mapping(uint => Kitti) private kitties;
    uint public nextId;
    address public admin;

    constructor(string memory _name, string memory _symbol, string memory _tokenURIBase) ERC721Token(_name, _symbol, _tokenURIBase) {
        admin = msg.sender;
    }

    function returnKitti(uint256 _tokenId) external view returns (Kitti memory, address, string memory) {
        return (kitties[_tokenId], ownerOf(_tokenId), tokenURIBase);
    }

    function breed(uint kittyId1, uint kittyId2) external {
        require(kittyId1 < nextId && kittyId2 < nextId, "The two kittyes must be exist");
        Kitti storage kitti1 = kitties[kittyId1];
        Kitti storage kitti2 = kitties[kittyId2];
        require(ownerOf(kittyId1) == msg.sender && ownerOf(kittyId2) == msg.sender, "You are not owner of two kittyes");
        
        uint maxGen = 0;
        if (kitti1.generation == kitti2.generation){
            maxGen = kitti1.generation +1;
        } else if (kitti1.generation > kitti2.generation){
            maxGen = kitti1.generation;
        }  else {
            maxGen = kitti2.generation;
        } 

        uint geneA = 0;
        if (_random(4) > 1){
            geneA = kitti1.geneA;
        }  else {
            geneA  = kitti2.geneA; 
        } 
        
        uint geneB = 0;
        if (_random(4) > 1){
            geneB = kitti1.geneB;
        }  else {
            geneB  = kitti2.geneB; 
        } 

        kitties[nextId] = Kitti(nextId, maxGen, geneA, geneB);
        _mint(nextId, msg.sender);
        nextId ++;
    }

    function mint() external {
        kitties[nextId] = Kitti(nextId, 1, _random(10), _random(8));
        _mint(nextId, msg.sender);
        nextId ++;
    }

    function _random(uint max) internal view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % max;
    }

}