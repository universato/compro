fn main() {
  let vector = vec![20, 80, 60, 40];
  let s = sum(&vector);
  println!("{:?} の総和は {}", vector, s); // vector が使える
}

fn sum(v: &Vec<i64>) -> i64 {
  let mut ret = 0i64;
  for &i in v {
      ret += i;
  }
  ret
}

// fn reverse_string(input &String) -> String {
//   let mut reversed = String::new();
//   let mut chars: Vec<char> = Vec::new();

//   for c in input.chars().into_iter() {
//       chars.push(c);
//   }

//   for i in (0..chars.len()).rev() {
//       reversed += &chars[i].to_string();
//   }

//   return reversed;
// }
