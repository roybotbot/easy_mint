
<h1> Automating .offer files (NFT for CAT)</h1>



> <h3> 1. Prerequisites </h3>
 * Windows with WSL (Windows Subsystem for Linux) https://www.microsoft.com/store/productId/9MSVKQC78PK6; for bash scripting
 * Chia client >= 1.4.0 
 * NFT Collection in a separate wallet
 
<h1> </h1>


>  <h3> 2. Setting up your environment</h3>
 * find your path on your local machine: /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon
 * it’s a bit long winded when most of your frequently accessed files are located there. Thankfully, we can use symlinks
 * run `sudo ln -s /mnt/{STORAGE}/Users/{USER}/AppData/Local/chia-blockchain/app-1.4.0/resources/app.asar.unpacked/daemon ~/chia`
 * you can `cd ~/chia` to access your linked directory; run `./chia.exe -h` to test everything is working as it should 
 * run `git clone https://github.com/su77ungr/easy_mint.git` inside the ~/chia folder and  `cd easy_mint/`
 * run `sudo chmod +x create_bulk_offers.sh && mv create_bulk_offers.sh ~/chia`

 
<h1> </h1>

>  <h3> 3. Everything should be ready to go!</h3>

 note your 
 *  `fingerprint`, 
 *  `wallet ID (NFT)`, 
 *  `wallet ID (Token)`,
 *  `Royalty (NFT)` and enter it when requested by the script

 run `sudo ./make_bulk_offers.sh` inside ~/chia
 * your offers will be stored inside `cd offers/` - you can upload them on https://dexie.space/upload
 * END OF README
 
