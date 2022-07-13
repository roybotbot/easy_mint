#!/bin/bash
#example; should be inside chia_automate_minting/
#images have to be named 1.PNG, 2.PNG ... 1377.PNG
FOLDER_NAME_URI="images"    
#metadata files have to be named 1.JSON, 2.JSON ... 1377.JSON
FILE_TYPE_OF_IMAGES="png" #could be jpg, jpeg too
#example
FOLDER_NAME_MURI="metadata"
#example
NUM=9     
#example
ROYALTY=420  
#example
FINGERPRINT="<FINGERPRINT>"
#example
WALLET_ID=12
#example
ROYALTY_ADDRESS="<ADDRESS>"   
#example
RECEIVE_ADDRESS="<ADDRESS>"
#example
API_KEY="<YOUR_API_KEY>"
#example
FEE=0.000615

###  DO NOT TOUCH SCRIPT AFTER THIS LINE ### 
############################################

for i in $(seq 1 $NUM); do
fname="./$FOLDER_NAME_URI/$i.$FILE_TYPE_OF_IMAGES"
response=`curl -s -X 'POST' "https://api.nft.storage/upload" \
  -H "accept: application/json" \
  -H "Content-Type: image/*" \
  -H "Authorization: Bearer $API_KEY" \
  --data-binary "@$fname"`

cid=`echo $response | jq -r '.value.cid'`
URI="https://${cid}.ipfs.nftstorage.link"
BUG="null"

if [ $cid == $BUG ]
then
echo $(tput setaf 1)"INVALID API_KEY - now exiting"
exit
else
echo "API_KEY fine"
fi

sample1=$(sha256sum -b $FOLDER_NAME_URI/$i.$FILE_TYPE_OF_IMAGES | cut -c -64) &&
sample2=$(curl -s https://${cid}.ipfs.nftstorage.link | sha256sum | cut -c -64) &&
if [ $sample1 == $sample2 ]
then
echo $(tput setaf 2) hashes match $(tput setaf 7) NFT Nr. $i ${sample1:0:5}...  ${sample2:0:5}...
echo $sample1 >> hashtable_URI.txt; echo $URI >> table_URI.txt
echo $URI
else
echo $(tput setaf 1)HASHES DISMATCH at $i! Probably missing files && echo $test2 --- $test3 >> hashtable_URI.log; echo "Are your credentials right? read https://github.com/su77ungr/easy_mint" ; exit 
fi
done

echo $(tput setaf 7) "hashtable_URI.txt created successfully"
echo $(tput setaf 7) "table_URI.txt created successfully"

for i in $(seq 1 $NUM); do
fname="./$FOLDER_NAME_MURI/$i.json"
response=`curl -s -X 'POST' "https://api.nft.storage/upload" \
  -H "accept: application/json" \
  -H "Content-Type: image/*" \
  -H "Authorization: Bearer $API_KEY" \
  --data-binary "@$fname"`

cid=`echo $response | jq -r '.value.cid'`
URI="https://${cid}.ipfs.nftstorage.link" &&
echo $URI

sample1=$(sha256sum -b $FOLDER_NAME_MURI/$i.json | cut -c -64) &&
sample2=$(curl -s https://${cid}.ipfs.nftstorage.link | sha256sum | cut -c -64) &&
if [ $sample1 == $sample2 ]
then
echo $(tput setaf 2) hashes match $(tput setaf 7) NFT Nr. $i ${sample1:0:5}...  ${sample2:0:5}...
echo $sample1 >> hashtable_MURI.txt; echo $URI >> table_MURI.txt
else
echo $(tput setaf 1) DISMATCH at $i! && echo $test2 --- $test3 >> hashtable_MURI.log; exit 
fi
done
echo $(tput setaf 7) "hashtable_MURI.txt created successfully"
echo $(tput setaf 7) "table_MURI.txt created successfully"

URI=$(sed -n ${i}p table_URI.txt)
URI_HASH=$(sed -n ${i}p hashtable_URI.txt)
MURI=$(sed -n ${i}p table_MURI.txt)
MURI_HASH=$(sed -n ${i}p hashtable_MURI.txt)


# starting final mint script 
echo "chia wallet nft mint -f $FINGERPRINT -i $WALLET_ID -ra $ROYALTY_ADDRESS -ta $RECEIVE_ADDRESS -u $URI -nh $URI_HASH -mu  $MURI -mh $MURI_HASH -rp $ROYALTY -m $FEE"
echo "This will be your final mint command" 
read -p "$(tput setaf 2)Do you want to start MINTING? (yes/no) " yn
case $yn in
        yes ) echo proceed...;;
        no ) echo exiting...;
                exit;;
        * ) echo invalid response;
                exit 1;;
esac 

for i in $(seq 1 $NUM); do

echo $(tput setaf 7) "MINTING $i ..."
chia wallet nft mint -f $FINGERPRINT -i $WALLET_ID -ra $ROYALTY_ADDRESS -ta $RECEIVE_ADDRESS -u $URI -nh $URI_HASH -mu  $MURI -mh $MURI_HASH -rp $ROYALTY -m $FEE &&
sleep 66
done
