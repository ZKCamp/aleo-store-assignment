# Aleo Secret Store Assignment

This assignment aims to build a toy store to help you understand building private applications on Aleo. The aim of this secret store is to hide the transactions and identity of buyers.

## Components of Store Program

### Public Data

- Quantity of items
- Price of each item

### Data Structures

- Token (Type: Record)
    - This token is the currency being used for purchase in this store
    - It should have the `owner` and `amount` data in it
- Item (Type: Record)
    - This represents the item being bought
    - It should have `owner`, `item_id`, and `quantity` data in it

### Functions

- **mint(receiver: address, amount: u64) -> Token**: This function allows the store owner to mint tokens and assign them to a specified receiver. It checks that only the store owner can call this function. The function returns a token record to the receiver with a given amount.
    
    Use this account for the store owner: 
    
    Address: `aleo19q8lac65jcd3m7k4rzv9awrc0euwjhqj6yhcs5nzhrqsnce5zgfqupcr3w`

    Private Key: `APrivateKey1zkp3H5E5u4X3ueP1kVyGcyzbVYQe5Ne5b2YBn2Ei1w27Npq`

    View Key: `AViewKey1dmAxxLeEUW4SbGVvPmsREBr9MZjoqk3DU8L6RDPwmBxf`
    
    <br />
    To verify that you have implemented this correctly, you can run the following command
    
    `leo run mint`
    
    The output should be a record similar to:
    
    ```
    {
      owner: aleo1wcehnzzkm4q6j66szyj0trsmq8crgcsm6829ftvr3v4cht4decgsus3h97.private,
      amount: 10000u64.private,
      _nonce: ...
    }
    ```

<br />

- **add_item(item_id: u8, quantity: u64, price: u64)**: This function enables the store owner to add a new item to their store's inventory. It only allows the store owner's address to add items. The item’s quantity and price should be stored in mappings.
    
    
    To verify that you have implemented this correctly, you can run the following command
    
    `leo run add_item`
    
    No record is emitted. The output should look similar to this: 
    
    ```
    {
      program_id: store.aleo,
      function_name: add_item,
      arguments: [
        1u8,
        10u64,
        100u64
      ]
    }
    ```

<br />

- **buy(token: Token, item_id: u8, quantity: u64, bill_amount: u64) -> (Token, Item)**: This function allows a user to purchase items from the store by providing a token record, specifying the item to purchase, the quantity desired, and the total bill amount. It calculates the difference between the token amount and the bill amount, creates a new token record with the remaining balance to give back to the user, and returns the purchased item in an item record. It then proceeds to finalize the purchase by adjusting the mappings accordingly.
    
    
    To verify that you have implemented this correctly, you can run the following command
    
    `leo run buy`
    
    The output should contain two records similar to:
    
    ```
    {
      owner: aleo19q8lac65jcd3m7k4rzv9awrc0euwjhqj6yhcs5nzhrqsnce5zgfqupcr3w.private,
      amount: 9950u64.private,
      _nonce: 4608133379597742036325281519932581869398291389556895330513371567915655434433group.public
    }
    
    {
      owner: aleo19q8lac65jcd3m7k4rzv9awrc0euwjhqj6yhcs5nzhrqsnce5zgfqupcr3w.private,
      item: 1u8.private,
      quantity: 5u64.private,
      _nonce: 3360311975568638510126804219705842170653856723280593169275644540961478991515group.public
    }
    ```

## Evaluation

-   Clone this template repo, by clicking on `Use this template` and then selecting `Create a new repository`

-   Give a name to this repo and set visibility to `Private`

-   Add us as collaborators

    * Go to the Settings tab
    * Select Collaborators from the left pane
    * Click Add People
    * Add username `shubham-kanodia` as a collaborator

-   Clone the repo you just created

    ```
    git clone CLONE_URL
    ```
    
-   Create a new branch with your name. You can use the following command

    ```
    git checkout -b my-name
    ```

-   Make changes [main.leo](src/main.leo) file

-   Submit the link to your GitHub repo in this [form](https://airtable.com/app9MohOmduC1gpqw/shr5Y1JtbI1tdU9Md)