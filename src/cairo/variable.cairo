
use debug::PrintTrait;
fn main()
{
let x:felt252=17; 
let mut x_mut:felt252=x;
x.print();
x_mut.print();
x_mut=x;

assert(x != x_mut,'x_chang notEqual x_mut');


}
#[tets]
fn test_main()
{
  main();
 }
