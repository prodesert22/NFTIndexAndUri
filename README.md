# NFTIndexAndUrl
Get the NFTs indexes and url, owned by the address

## Functions 

### getNFTIndex
Returns the token's indexes owned by the address in the given contract

### getNFTIndexAndUrl
Returns the token's indexes owned by the address and NFT's url, in the given contract

### getNFTsIndexAndUrl
Returns array of NFT's struct in the given contracts
```
struct Nft {
    contract_address - address of contract
    tokenId - index of nft in contract
    url - url of image
}
```