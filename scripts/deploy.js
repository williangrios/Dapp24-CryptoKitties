
const hre = require("hardhat");

async function main() {


  const CK = await hre.ethers.getContractFactory("Cryptokitties");
  const ck = await CK.deploy("CryptoKitties", "CKT", "https://gateway.pinata.cloud/ipfs/QmXgSUSGufqzN1DDHFXHF7FPAZx7yfstt7rgQw9gSnF6Hb/");

  await ck.deployed();

  console.log(
    `Deployed to ${ck.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
