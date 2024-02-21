import Lake
open Lake DSL System

package «clean» where
  -- add package configuration options here

lean_lib «C» where
  precompileModules := true

@[default_target]
lean_exe «test» where
  root := `Test
  supportInterpreter := true

target ffi.o pkg : FilePath := do
  let oFile := pkg.buildDir / "C" / "ffi.o"
  let srcJob ← inputFile <| pkg.dir / "C" / "ffi.c"
  let weakArgs := #["-I", (← getLeanIncludeDir).toString]
  buildO "ffi.c" oFile srcJob weakArgs #["-fPIC"] "cc" getLeanTrace

extern_lib libleanffi pkg := do
  let name := nameToStaticLib "ffi"
  let ffiO ← fetch <| pkg.target ``ffi.o
  buildStaticLib (pkg.nativeLibDir / name) #[ffiO]
