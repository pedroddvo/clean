import C

def main : IO Unit := do
  let x : C.Int8 := (C.Int16.ofNat 255).toInt8
  let y : UInt8 := (-13 : C.Int16) |>.toUInt16.toUInt8
  def z := ((32 - 64) : C.Int32)
   IO.println s!"{y}"
