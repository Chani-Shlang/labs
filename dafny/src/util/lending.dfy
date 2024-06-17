
include "number.dfy"
include "maps.dfy"
include "tx.dfy"

import opened Number
import opened Maps
import opened Tx


class  math
{

 const  EXP_SCALE :nat := Pow(10,18)
 const  HALF_EXP_SCALE:nat:= EXP_SCALE /2
 const MAX_UINT256: nat := 115792089237316195423570985008687907853269984665640564039457584007913129639935

function getExp(num: nat, denom: nat) : (ret:nat)

requires denom > 0
ensures num*EXP_SCALE/denom == if num * EXP_SCALE % denom == 0 then num * EXP_SCALE / denom else 0
    {
    
  
     
    return ret;
    
    }
}



    
