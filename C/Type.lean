import Lean.Elab
import Lean.Meta

set_option hygiene false in
macro "defInt" idn:ident : command => do
  let cName := idn.getId.toString.toLower
  let unsized := Lean.mkIdent <| idn.getId.appendBefore "U"
  let c := Lean.Syntax.mkStrLit
  `(structure $idn := val : $unsized
    deriving Inhabited

    namespace $idn
    @[extern 1 c $(c s!"{cName}_to_int")] opaque toInt : $idn -> Int
    @[extern 1 c $(c s!"{cName}_of_nat")] opaque ofNat (n : @& Nat) : $idn

    @[extern 1 c $(c s!"{cName}_neg")] opaque neg : $idn -> $idn
    @[extern 2 c $(c s!"{cName}_add")] opaque add (a b : $idn) : $idn
    @[extern 2 c $(c s!"{cName}_sub")] opaque sub (a b : $idn) : $idn
    @[extern 2 c $(c s!"{cName}_mul")] opaque mul (a b : $idn) : $idn
    @[extern 2 c $(c s!"{cName}_div")] opaque div (a b : $idn) : $idn
    @[extern 2 c $(c s!"{cName}_mod")] opaque mod (a b : $idn) : $idn
    @[extern 2 c $(c s!"{cName}_land")] opaque land (a b : $idn) : $idn
    @[extern 2 c $(c s!"{cName}_lor")] opaque lor (a b : $idn) : $idn
    @[extern 2 c $(c s!"{cName}_xor")] opaque xor (a b : $idn) : $idn
    @[extern 2 c $(c s!"{cName}_shift_left")] opaque shiftLeft (a b : $idn) : $idn
    @[extern 2 c $(c s!"{cName}_shift_right")] opaque shiftRight (a b : $idn) : $idn

    instance : Neg $idn := ⟨neg⟩
    instance : Repr $idn where reprPrec n _ := toInt n |> repr
    instance : ToString $idn where toString n := toInt n |> toString

    instance : OfNat $idn n   := ⟨ofNat n⟩
    instance : Add $idn       := ⟨add⟩
    instance : Sub $idn       := ⟨sub⟩
    instance : Mul $idn       := ⟨mul⟩
    instance : Mod $idn       := ⟨mod⟩
    instance : Div $idn       := ⟨div⟩
    end $idn)

namespace C
defInt Int8
defInt Int16
defInt Int32
defInt Int64

inductive PlatformSize | bit32 | bit64

def Long.size := match System.Platform.isWindows, System.Platform.numBits with
  | true, _ => PlatformSize.bit32
  | _, 32   => PlatformSize.bit32
  | _, _    => PlatformSize.bit64

-- Not sure if there's a nicer way of doing this
macro "Long" : term => match Long.size with
  | .bit32 => `(Int32)
  | .bit64  => `(Int64)

macro "ULong" : term => match Long.size with
  | .bit32 => `(UInt32)
  | .bit64  => `(UInt64)

macro "SChar" : term => `(Int8)
macro "Short" : term => `(Int16)
macro "LongLong" : term => `(Int64)

macro "UChar" : term => `(UInt8)
macro "UShort" : term => `(UInt16)
macro "ULongLong" : term => `(UInt64)

macro "Char" : term => `(SChar)
