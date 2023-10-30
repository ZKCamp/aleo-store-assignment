program store.aleo {
    mapping items: u8 => u64;
    mapping prices: u8 => u64;

    record Token {
        owner: address,
        amount: u64
    }

    record Item {
        owner: address,
        item: u8,
        quantity: u64
    }

    // Address of store owner: aleo10ppqgwqzdr2h49z3w4faze74genk6zs0ye4tzemk3d8uxerfkqzspkzp7w
    // Step 1: Mint tokens to certain address
    transition mint(receiver: address, amount: u64) -> Token {
        assert_eq(self.caller, aleo1fu0k2qfytzs5fhesgfgjuax6wsh9xx4ftpdapnhzrtruy0tx3urqx3p0ut);

        return Token {
            owner: receiver,
            amount: amount
        };
    }

    // Step 2: Add item
    transition add_item(item: u8, quantity: u64, price: u64) {
        assert_eq(self.caller, aleo1fu0k2qfytzs5fhesgfgjuax6wsh9xx4ftpdapnhzrtruy0tx3urqx3p0ut);

        return then finalize(item, quantity, price);
    }

    // Increment items quantity, set item price
    finalize add_item (item: u8, quantity: u64, price: u64) {
        let item_count: u64 = Mapping::get_or_use(items, item, 0u64);
        Mapping::set(items, item, item_count + quantity);

        Mapping::set(prices, item, price);
    }
    
    transition buy(token: Token, item: u8, quantity: u64, bill_amount: u64) -> (Token, Item) {
        let difference: u64 = token.amount - bill_amount;
        
        let remaining: Token = Token {
            owner: token.owner,
            amount: difference
        };

        let item_record: Item = Item {
            owner: self.caller,
            item: item,
            quantity: quantity
        };

        return (remaining, item_record) then finalize(item, quantity, bill_amount);
    }

    finalize buy (item: u8, quantity: u64, bill_amount: u64) {
        let available_quantity: u64 = Mapping::get_or_use(items, item, 0u64);
        assert(available_quantity >= quantity);

        let item_price: u64 = Mapping::get_or_use(prices, item, 0u64);
        assert_neq(item_price, 0u64);

        let total_price: u64 = item_price * quantity;
        assert_eq(total_price, bill_amount);
    }
}
