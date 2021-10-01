// SPDX-License-Identifier: MIT

/**
<<<<<<< HEAD:GetNFTURI.sol
 * @title NFTIndexAndUri
 * @author ProDesert22 and Ita
=======
 * @title NFTIndexAndUrl
 * @author ProDesert22 and itamarcps
>>>>>>> 8ab4de796abb668518ecee8602433bc873426f68:GetNFTURL.sol
 */

// https://github.com/prodesert22/NFTIndexAndUri

pragma solidity ^0.8.0;

import "./OpenZeppelin/token/ERC721/IERC721Enumerable.sol";
import "./OpenZeppelin/token/ERC721/IERC721Metadata.sol";

contract NFTIndexAndUri {
    
    struct Nft {
        address contract_address;
        uint256 tokenId;
        string uri;
    }

    function getNFTIndex(address contractAddress, address userAddress) public view returns (uint256[] memory _tokensId) {
        //Returns the token's indexes owned by the address
        IERC721Enumerable NFTContract = IERC721Enumerable(contractAddress);
        
        uint256 userBalance = NFTContract.balanceOf(userAddress);

        if (userBalance == 0) {
            // Return an empty array
            return new uint256[](0);
        }
        uint256[] memory result = new uint256[](userBalance);
        uint256 index;
        for (index = 0; index < userBalance; index++) {
            try NFTContract.tokenOfOwnerByIndex(userAddress, index) returns (uint256 tokenId){
                result[index] = tokenId;
            } catch {
                return new uint256[](0);
            }
        }
        return result;
    }

    function getNFTIndexAndURI(address contractAddress, address userAddress) public view returns (uint256[] memory _tokensId, string[] memory _uris) {
        //Returns the token's indexes owned by the address and uri of nft
        IERC721Enumerable NFTContract = IERC721Enumerable(contractAddress);
        IERC721Metadata NFTConctractUri = IERC721Metadata(contractAddress);
        
        uint256 userBalance = NFTContract.balanceOf(userAddress);
        
        if (userBalance == 0) {
            // Return an empty array
            return (new uint256[](0), new string[](0));
        }
        uint256[] memory result = new uint256[](userBalance);
        string[] memory resulturi = new string[](userBalance);
        uint256 index;
        for (index = 0; index < userBalance; index++) {
            try NFTContract.tokenOfOwnerByIndex(userAddress, index) returns (uint256 tokenId){
                result[index] = tokenId;
                try NFTConctractUri.tokenURI(tokenId) returns (string memory uri){
                    resulturi[index] = uri;
                } catch {
                    return (new uint256[](0), new string[](0));
                }
            } catch {
                return (new uint256[](0), new string[](0));
            }
        }
        return (result, resulturi);
        
    }

    function getNFTsIndexAndUri(address[] calldata contractsAddresses, address userAddress) public view returns (Nft[] memory _nft){
        uint256 index;
        uint256 sum = 0;
        uint256 n_contracts = contractsAddresses.length;

        for (index = 0; index < n_contracts; index++) {
            IERC721Enumerable NFTContract = IERC721Enumerable(contractsAddresses[index]);
            IERC721Metadata NFTConctractUri = IERC721Metadata(contractsAddresses[index]);
            uint256 userBalance = NFTContract.balanceOf(userAddress);
            try NFTContract.tokenOfOwnerByIndex(userAddress, 0) returns (uint256 tokenId){
                try NFTConctractUri.tokenURI(tokenId){
                    sum = sum + userBalance;
                }catch{
                    continue;
                }
            }catch{
                continue;
            }
        }

        if (sum == 0){
            return new Nft[](0);
        }

        Nft[] memory nfts = new Nft[](sum);
        uint256 j = 0;
        for (index = 0; index < n_contracts; index++) {
            address contractAddress = contractsAddresses[index];
            IERC721Enumerable NFTContract = IERC721Enumerable(contractAddress);
            IERC721Metadata NFTConctractUri = IERC721Metadata(contractAddress);
            uint256 userBalance = NFTContract.balanceOf(userAddress);
            if (userBalance > 0){
                for (uint256 i = 0; i < userBalance; i++) {
                    try NFTContract.tokenOfOwnerByIndex(userAddress, i) returns (uint256 tokenId){
                        try NFTConctractUri.tokenURI(tokenId) returns (string memory uri){
                            nfts[j] = Nft(contractAddress, tokenId, uri);
                            j++;
                        } catch {
                            break;
                        }
                    } catch {
                        break;
                    }
                }
            }
        }
        return nfts;
    }
}
