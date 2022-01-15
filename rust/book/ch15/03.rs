struct CustomSmartPointer {
    data: String,
}

impl Drop for CustomSmartPointer {
    fn drop(&mut self) {
        println!("Drop CustomSmartPointer with data `{}`", self.data);
    }
}

fn main() {
    let c = CustomSmartPointer {
        data: String::from("a cat"),
    };
    let _d = CustomSmartPointer {
        data: String::from("a dog"),
    };
    // not allowed
    // c.drop();
    // use std::mem:drop;
    drop(c);
    println!("CustomPointers drop...");
}
