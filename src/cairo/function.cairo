use debug::PrintTrait;
fn main()
{
    //let mut x:u32 =3;
    let mut x=3;
    x.print();
    x=inc(x);
    x.print();
    let x:u8=9;
    let is_awsome=true;
    if x>0&&is_awsome
    {
        'lets_go'.print();
    }
    let x=3618502788666131213697322783095070105623107215331596699973092056135872020480;
    let y=1;
    let z=(x+y);
    z.print();
    let t:bool=true;
    let tt=5==5;
    assert(tt==t,"this is true");
    

}
    


fn inc(x:u32)->u32
{
  return  x+1;
}

#[test]
fn test()
{
    let mut x=3;
    x=inc(x);
    x.print();
}
