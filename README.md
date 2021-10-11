# NFTIndexAndUri
Get the NFTs indexes and uri, owned by the address

## Functions 

### getNFTIndex
Returns the token's indexes owned by the address in the given contract

### getNFTIndexAndUrl
Returns the token's indexes owned by the address and NFT's uri, in the given contract

### getNFTsIndexAndUrl
Returns array of NFT's struct in the given contracts
```
struct Nft {
    contract_address - address of contract
    tokenId - index of nft in contract
    uri - uri of nft (can be a link to image or json)
}
```

## Deploys

[Main net](https://cchain.explorer.avax.network/address/0xDd273B84032a4e3C4C88bEcA701C7D0118DE37e5)

[Fuji](https://cchain.explorer.avax-test.network/address/0x9C302ecc5d029bD67115473aa02961b6338093Af)
