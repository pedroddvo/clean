# Lean C FFI utilities
`clean` provides utilities to facilitate C ffi with lean4

## C Types
The namespace `C.Type` contains unboxed versions of equivalent C types, including unboxed integers `int8_t` to `int64_t`.
```lean
#eval (1 : C.Int8)                     -- unboxed integers
#eval (32 : C.Int32) + (-64 : C.Int32) -- arithmetic
#eval (64 : C.Int8).toInt32.toUInt8    -- c casting
#eval (Long.min : C.Long)              -- platform dependent types
```