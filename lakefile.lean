import Lake
open Lake DSL

package «c» where
  -- add package configuration options here

target ffi.o pkg : FilePath := do
  let oFile := pkg.buildDir / "C" / "ffi.o"
  let srcJob ← inputFile <| pkg.dir / "C" / "ffi.c"
  let weakArgs := #["-I", (← getLeanIncludeDir).toString]
  buildO "ffi.c" oFile srcJob weakArgs #["-fPIC"] "cc" getLeanTrace

extern_lib libleanffi pkg := do
  let name := nameToStaticLib "ffi"
  let ffiO ← fetch <| pkg.target ``ffi.o
  buildStaticLib (pkg.nativeLibDir / name) #[ffiO]

@[default_target]
lean_lib «C» where
  -- add library configuration options here

-- @[default_target]
lean_exe «test» where
  root := `Test
  -- Enables the use of the Lean interpreter by the executable (e.g.,
  -- `runFrontend`) at the expense of increased binary size on Linux.
  -- Remove this line if you do not need such functionality.
  supportInterpreter := true
