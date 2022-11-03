const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });

async function main() {
  const metadataURL = "ipfs://Qmbygo38DWF1V8GttM1zy89KzyZTPU2FLUzQtiDvB7q6i5";
  const lw3PunksContract = await ethers.getContractFactory("LW3Punks");
  const Lw3PunksContract = await lw3PunksContract.deploy(metadataURL);
  await Lw3PunksContract.deployed();

  console.log(`Lw3PunksContract deployed at :${Lw3PunksContract.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
