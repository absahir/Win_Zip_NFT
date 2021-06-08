# Creating a Landing Page Website with Github Pages

This landing page can be deployed through Github pages or local host. These instructions are for both. This is an application for the auction built on the Ethereum blockchain.

## Instructions to deploy it in local host

* Create a fresh directory in your workspace called `NFT`:

  ```bash
  mkdir NFT
  cd NFT
  ```

* Make sure your folder contains the `dapp.js`, `index.html`, `REAuction.json`and `REMarket.json` into a subfolder called `NFT`.

* Navigate into the folder using bash or linux. Once in the folder deploy the application using the following command ```python -m http.server 8000```. Congratulations! You successfully deployed the app in your computer!

* Now, open a new browser and navigate to server 8000 by inputting the following URL `localhost:8000`.

* In order to make the market place work with your environment, you are going to need metamask, pinata and ganache downloaded in your computer.

* The website is going to ask you for Pinata API Key and Pinata API secret key. Also the art work needed for the auction. Be ready to put an image.


## Demo App in Github Pages
  
* Make a repository with a `README.md file`.

* Add all the files are in the repository `dapp.js`, `index.html`, `REAuction.json`and `REMarket.json`.

* Now navigate to the settings. Once in settings click in Pages, it should be on the left hand side.

* Make sure the Branch is main and the folder is in root. Click save. 

* The link of the the Github hosted site would be on top. You can navigate to it. Congratulations for deploying it on Github! Once deployed the website will ask you for your pinata credentials. Have art work ready for the auction.

