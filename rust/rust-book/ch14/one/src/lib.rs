//! # One Crate
//! `one` is a simple crate for fun.

pub use self::kinds::PrimaryColor;
pub use self::kinds::SecondaryColor;
pub use self::utils::mix;

pub mod kinds {
    pub enum PrimaryColor {
        Red,
        Yellow,
        Blue,
    }
    pub enum SecondaryColor {
        Orange,
        Green,
        Purple,
    }
}

pub mod utils {
    use crate::kinds::*;

    pub fn mix(c1: PrimaryColor, c2: PrimaryColor) -> SecondaryColor {
        // println!("{:?} {:?}", c1, c2);
        SecondaryColor::Orange
    }
}

/// Adds one to the number given.
///
/// # Examples
///
/// ```
/// let number = 5;
/// let result = one::add_one(number);
/// assert_eq!(6, result);
/// ```

pub fn add_one(x: i32) -> i32 {
    x + 1
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
