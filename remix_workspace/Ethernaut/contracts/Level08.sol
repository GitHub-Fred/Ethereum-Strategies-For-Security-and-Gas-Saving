//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract readPrivateData {
    function getPassword() public pure returns (string) {
        return
            web3.util.toAscii(
                web3.eth.getStorageAt(
                    "0xa16DFcB528726a6Eae95DE42Ef7090047Fb4079a",
                    1
                )
            );

        //        web3.eth.getStorageAt(instance.address, 1, (err,res)=>{console.log(res)});
        //web3.eth.getStorageAt(0xa16DFcB528726a6Eae95DE42Ef7090047Fb4079a, 1).then(console.log);
    }
}
