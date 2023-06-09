use std::io;

fn sum(a: i32, b: i32) -> i32 {
    a + b
}
fn main() {
    println!("Hello world");
    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    let a = sum(2, 3);
    println!("{}", input);
}
