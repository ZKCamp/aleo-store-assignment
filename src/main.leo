program store.aleo {
    
	record Token {
		owner: address,
		amount: u64,
	}

	record Item {
		owner: address,
		item_id: u8,
		quantity: u64,
	}

	struct ItemMap {
		quantity: u64,
		price: u64,
	}

	mapping item_map: u8 => ItemMap;

	transition mint(receiver: address, amount: u64) -> Token {
		return Token {
			owner: self.caller,
			amount: amount,
		};
	}

	transition add_item(item_id: u8, quantity: u64, price: u64) {
		assert_eq(self.caller, aleo19q8lac65jcd3m7k4rzv9awrc0euwjhqj6yhcs5nzhrqsnce5zgfqupcr3w);
		return then finalize (item_id, quantity, price);
	}

	finalize add_item(item_id: u8, quantity: u64, price: u64) {
		Mapping::set(item_map, item_id, ItemMap {quantity: quantity, price: price});
	}

	transition buy(token: Token, item_id: u8, quantity: u64, bill_amount: u64) -> (Token, Item) {
		let balance: u64 = token.amount - bill_amount;

		let buyer: Token = Token {
			owner: self.caller,
			amount: balance,
		};

		let item: Item = Item {
			owner: self.caller,
			item_id: item_id,
			quantity: quantity,
		};

		return (buyer, item)
		then finalize (item_id, quantity, bill_amount); 
	}

	finalize buy(item_id: u8, quantity: u64, bill_amount: u64) {
		let item_detail: ItemMap = Mapping::get(item_map, item_id);
		assert_eq(bill_amount, item_detail.price);

		Mapping::set(item_map, item_id, ItemMap {
			quantity: item_detail.quantity - quantity,
			price: item_detail.price,
		});
	}
}
