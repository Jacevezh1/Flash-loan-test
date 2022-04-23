// Mainnet DAI address
const DAI = "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063";

// Random user address that happens to have a lot of DAI on polygon mainnet
const DAI_WHALE = "0xD92B63D0E9F2CE9F77c32BfeB2C6fACd20989eB3";

// Mainnet Pool contract address
const POOL_ADDRESS_PROVIDER = "0xa97684ead0e402dc232d5a977953df7ecbab3cdb"


module.exports = {
    DAI,
    DAI_WHALE,
    POOL_ADDRESS_PROVIDER
}




/* 
 
@dev Why DAI_WHLE?

Since we are not actually executing any arbitrage, and therefore will not be able to pay the premium if we run the contract as-is, 
we use another Hardhat feature called impersonation that lets us send transactions on behalf of any address, even without their private key. 
However, of course, this only works on the local development network and not on real networks. Using impersonation, 
we will steal some DAI from the DAI_WHALE so we have enough DAI to pay back the loan with premium. 


*/