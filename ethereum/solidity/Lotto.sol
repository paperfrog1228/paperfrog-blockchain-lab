pragma solidity ^0.8.7;

contract Lotto {
    struct Lotto{
        uint8 number;
    }

    event WinningNumber(Lotto[] indexed lottoList);
   
    function getNumbers(uint8 count) external {
        
        uint[8] memory checked=new uint8[](46);
        
        Lotto[] memory lottoList=new Lotto[](5);

        for(uint8 i=0;i<count;i++){
            uint8[] memory lottoOneLine=new uint8[](6);
            for(uint j=0;j<6;j++){
                bool end=false;
                while(!end){
                    uint8 num=getRandomNumber();
                    if(checked[num]==0){
                        lottoOneLine[j]=num;
                        checked[num]++;
                        end=true;
                    }
                }
            }
            Lotto memory temp;
            temp=Lotto(sortArray(lottoOneLine));
            lottoList[i]=temp;
        }
        emit WinningNumber(lottoList);
    }
    function getRandomNumber() internal returns(uint){
        uint8 nonce=0;
        uint randomNumber=uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce))) % 45;
        randomNumber = randomNumber + 1;
        nonce++;
        return randomNumber;
    }
    function sortArray(uint8[] memory arr_) internal returns (uint[] memory){
        uint l = arr_.length;
        uint[] memory arr = new uint[](l);

        for(uint8 i=0;i<l;i++){
            arr[i] = arr_[i];
        }

        for(uint8 i =0;i<l;i++){
            for(uint8 j =i+1;j<l;j++)
            {
                if(arr[i]<arr[j])
                {
                    uint temp= arr[j];
                    arr[j]=arr[i];
                    arr[i] = temp;
                }
            }
        }
        return arr;
    }
}

