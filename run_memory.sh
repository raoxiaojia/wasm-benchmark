#!/usr/bin/env bash
set -ex

run_wasmtime() {
  echo "wasmtime"
  time wasmtime --invoke "memory_allocate" memory_allocate.wat
  time wasmtime --invoke "memory_fill" memory_fill.wat
  time wasmtime --invoke "memory_store_iterate" memory_store_iterate.wat
  time wasmtime --invoke "memory_grow" memory_grow.wat
}

run_wasmi_release() {
  echo "wasmi-release"
  time ./wasmi/target/release/wasmi_cli --invoke "memory_allocate" memory_allocate.wat
  time ./wasmi/target/release/wasmi_cli --invoke "memory_fill" memory_fill.wat
  time ./wasmi/target/release/wasmi_cli --invoke "memory_store_iterate" memory_store_iterate.wat
  time ./wasmi/target/release/wasmi_cli --invoke "memory_grow" memory_grow.wat
}

run_wasmi_dev() {
  echo "wasmi-dev"
  cd wasmi
  cargo build
  time cargo run --bin wasmi_cli ../memory_allocate.wat --invoke "memory_allocate"
  time cargo run --bin wasmi_cli ../memory_fill.wat --invoke "memory_fill"
  time cargo run --bin wasmi_cli ../memory_store_iterate.wat --invoke "memory_store_iterate"
  time cargo run --bin wasmi_cli ../memory_grow.wat --invoke "memory_grow"
  cd ..
}

run_rocq() {
  echo "Rocq"
  cd WasmCert-Coq
  dune build
  time ./wasm_coq_interpreter.exe --text ../memory_allocate.wat -r "memory_allocate"
  time ./wasm_coq_interpreter.exe --text ../memory_fill.wat -r "memory_fill"
  time ./wasm_coq_interpreter.exe --text ../memory_store_iterate.wat -r "memory_store_iterate"
  time ./wasm_coq_interpreter.exe --text ../memory_grow.wat -r "memory_grow"
  cd ..
}

run_reference() {
  echo "reference interpreter"
  cd spec/interpreter
  git checkout a160f21
  make
  time ./wasm ../../memory_allocate.wat -e '(invoke "memory_allocate")'
  time ./wasm ../../memory_fill.wat -e '(invoke "memory_fill")'
  time ./wasm ../../memory_store_iterate.wat -e '(invoke "memory_store_iterate")'
  time ./wasm ../../memory_grow.wat -e '(invoke "memory_grow")'
  cd ../..
}

run_isabelle_non_monadic() {
  echo "Isabelle (non-monadic)"
  cd spec/interpreter
  git checkout a160f21
  make
  time ./wasm -isa ../../memory_allocate.wat -e '(invoke "memory_allocate")'
  time ./wasm -isa ../../memory_fill.wat -e '(invoke "memory_fill")'
  time ./wasm -isa ../../memory_store_iterate.wat -e '(invoke "memory_store_iterate")'
  time ./wasm -isa ../../memory_grow.wat -e '(invoke "memory_grow")'
  cd ../..
}

run_isabelle_monadic() {
  echo "Isabelle (monadic)"
  cd spec/interpreter
  git checkout ddeaadc
  make
  time ./wasm -isa ../../memory_allocate.wat -e '(invoke "memory_allocate")'
  time ./wasm -isa ../../memory_store_iterate.wat -e '(invoke "memory_store_iterate")'
  time ./wasm -isa ../../memory_grow.wat -e '(invoke "memory_grow")'
  git checkout master
  cd ../..
}

TARGET="${1:-all}"

case "$TARGET" in
  all)
    run_wasmtime
    run_wasmi_release
    run_wasmi_dev
    run_rocq
    run_reference
    run_isabelle_non_monadic
    run_isabelle_monadic
    ;;
  wasmtime) run_wasmtime ;;
  wasmi-release) run_wasmi_release ;;
  wasmi-dev) run_wasmi_dev ;;
  rocq) run_rocq ;;
  reference) run_reference ;;
  isabelle-non-monadic) run_isabelle_non_monadic ;;
  isabelle-monadic) run_isabelle_monadic ;;
  *)
    echo "Unknown target: $TARGET"
    echo "Valid targets:"
    echo "  all, wasmtime, wasmi-release, wasmi-dev, rocq,"
    echo "  reference, isabelle-non-monadic, isabelle-monadic"
    exit 1
    ;;
esac

echo "Done"


