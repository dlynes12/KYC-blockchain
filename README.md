# Know Your Customer (KYC) on Blockchain

![KYC on Blockchain](Images/identity.jpg)

*Source: https://www.devteam.space/blog/why-is-blockchain-a-good-solution-for-kyc-verification/*

## Introduction

The objective of this project is to explore the possibilities of integrating blockchain into Anti-Money Laundering practices. We have used Solidity to create a smart contract to input and update information on the blockchain for the purpose of streamlining the Know Your Customer (KYC) process.

AML refers to the global laws, regulations, and procedures that are in place to prevent the act of producing income through illegal activities. The issue with the current AML procedures are that they are not able to keep pace with the evolving complexity and volume of financial transactions which becomes a problem for keeping a check on Laundering activities.

KYC is a component of AML; they are the certain details that the business keeps as an end criteria for the identification of customers who are interested in doing business with them. Some predominant issues that are being faced by the current KYC compliances include issues related to corruption, terrorist financing, identity thefts and illegal tax avoidance.

According to The LexisNexis® Risk Solutions 2019 True Cost of AML Compliance Study for the United States and Canada, the annual AML compliance costs for the United States and Canadian financial institutions totaled $31.5 billion USD

## How Can Blockchain Help? 

Blockchain technology allows for the creation of a distributed ledger that is then shared to all users on the network. Utilizing Blockchain as a distributed ledger system has the potential to unlock the advantages of automated processes such as reducing compliance errors. A blockchain-based registry would not only remove the repetitive efforts of implementing KYC checks, but the ledger would also enable encrypted updates to client accounts to be distributed in near real-time. 

A KYC utility system based on blockchain technology will enable the financial and banking sectors to emancipate the process of identification verification. Currently, our data is collected and stored in a centralized system, such as a repository. With the introduction of blockchain solutions to handle the KYC process, data will be available on a decentralized network and can, therefore, be accessed by third parties directly after permission has been given.

This blockchain-based KYC system will also offer better data security by ensuring that data access is only made after a confirmation or permission is received from the relevant authority. This will eliminate the chance of unauthorized access and subsequently give individuals greater control over their data.

This ledger will provide a historical record of all documents shared and compliance activities undertaken for each client. Blockchain technology is also helpful in identifying entities attempting to create fraudulent histories. Within the provisions of data protection regulation, the data in the blockchain is immutable and could be analysed to identify irregularities - this can directly target criminal activity.

![Blockchain method](Images/Blockchain_KYC.jpg)

*Source: https://www.devteam.space/blog/why-is-blockchain-a-good-solution-for-kyc-verification/*


## Building the KYC System

A KYC System is built using a command line interface that will upload and pin KYC reports to IPFS via Pinata, permanently storing them on-chain by using the register KYC function in the KYC smart contract.

1. A Smart contract  `kyccontract.sol` is created with the `msg.sender` as contract administrator and the following functions:

    * A `registerKYC` function is used to upload the KYC information into the `kyc` contract with the `userID` as the address of the customer and the `report_uri` that has all the details of the customer account. A check for duplicate records is also part of this function.

    * There is a provision to update the records through the `updateKYC` function where the existing address of the customer is linked to the new `report_uri` that has the updated information.

    * The KYC report for customers is valid upto `365 days`. A `checkvalidity` function tracks the validity of the customer report.

    * A `clientList` is created and appended every time a new KYC report is registered through the contract. This is done to keep a record of all the client addresses. A `for` loop is created within the `clientLoop` function to go over the list and pull out contracts that have expired and are about to expire in the next 30 days from the  client database. A log is generated for the administrator i.e. the `msg.sender` to follow-up with customers to update their KYC information.

2. This contract is deployed in Remix IDE. 

3. A new `KYC_frontend` directory is created where a `.env` file is stored with Pinata API Key and Secret API Key, address of the deployed smart contract and the WEB3 provider uri.

4. The deployed `kyccontract.sol` contract ABI is copied and stored in a `kyc.json` file.

5. A Python file `kyc.py` is created. In this file:

   * Import web3.auto, load the environment variables using dotenv, and import the Path library from pathlib to fetch our ABI.

   * A headers object to populate the variables defined in .env.

   * An initContract function, that will need to return the web3 contract object that will allow it to interact with the kyc contract on-chain.

   * A convertDataToJSON function, to convert customer data to json format.
   
   * A pinJSONtoIPFS function, with a POST request to the pinJSONtoIPFS endpoint on Pinata. 

6. Another file called `kycreport.py` is created. In this file:

    * Import the kyc.py functions into this file.

    * A `kyccontract` object is created using the initContract function from `kyc.py`.

    * In the `createkycReport` function, user data is fetched by using the input function in Python. 

    * Pass the user data variables to the convertDataToJSON function. Store the result in json_data, then pass json_data to the pinJSONtoIPFS function and save that as report_uri. Return the user_id, email and report_uri variables.

    * In the `kycreport` function, we will generate the transaction that talks to the kyc smart contract and returns the transaction receipt.

    * Another function called `kycupdate` will talk to the update function in the kyc smart contract to update records and return the transaction receipt.

    * A `main` function we will is put the pieces together. In the `report` flow will create the kyc report then, store the receipt, and pretty print the results after. A similar `update` flow will create a report with the updated information and print the receipt.
    
## Launching the KYC System

Test the kyc report system by navigating to the terminal, `cd`ing into the `KYC_frontend` folder workspace, and running the following commands:

`python kycreport.py report` 

`python kycreport.py update` 

These commands should ask a series of questions to create the customer report, then return an IPFS hash and a print a transaction receipt.

After you have verified that you can fetch this metadata from your CLI, check out your Pinata Pin Explorer to see what was uploaded to IPFS.

## Technologies used


- Solidity

- Remix IDE

- Python

- Ganache

- Metamask

## Limitations

1. The `for` loop created in the function for keeping track of the list of clients is stored on the chain therefore requiring gas everytime the administrator needs to pull up a list of expiring reports. This can pose a problem once the list has many records. 

2. The function for checking validity with timestamp "now" will work only when the  testrpc is updated each time a Solidity event is created on the chain. When there are no events, then the "now" timestamp will always be the same initial value when running on testrpc. The code in the contract should work on a live network.

3. The date format for the end date for each report is stored as a timestamp on the blockchain. If given more time, we could write a  function to convert this into human readable form.


## Conclusion

In the future, blockchain-based KYC utilities will help bring cost savings to any industry that relies on identity verification. This is because the technology will allow banks and other financial organizations to rely on a more secure organized unified model of data handling.

## Sources

1. https://risk.lexisnexis.com/insights-resources/research/2019-true-cost-of-aml-compliance-study-for-united-states-and-canada

2. https://www2.deloitte.com/content/dam/Deloitte/ch/Documents/innovation/ch-en-innovation-deloitte-blockchain-app-in-banking.pdf


 

