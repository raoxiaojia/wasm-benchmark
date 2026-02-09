set -ex
echo "Memory - Rocq"
cd WasmCert-Coq
dune build
time ./wasm_coq_interpreter.exe --text ../memory_allocate.wat -r "memory_allocate"
time ./wasm_coq_interpreter.exe --text ../memory_fill.wat -r "memory_fill"
time ./wasm_coq_interpreter.exe --text ../memory_store_iterate.wat -r "memory_store_iterate"

cd ../spec/interpreter
git checkout 547d565
make
echo "Coremark - reference interpreter"
time ./wasm ../../memory_allocate.wat -e '(invoke "memory_allocate")'
time ./wasm ../../memory_fill.wat -e '(invoke "memory_fill")'
time ./wasm ../../memory_store_iterate.wat -e '(invoke "memory_store_iterate")'
echo "Coremark - Isabelle (non-monadic)"
time ./wasm -isa ../../memory_allocate.wat -e '(invoke "memory_allocate")'
time ./wasm -isa ../../memory_fill.wat -e '(invoke "memory_fill")'
time ./wasm -isa ../../memory_store_iterate.wat -e '(invoke "memory_store_iterate")'

echo "Coremark - Isabelle (monadic)"
git checkout ddeaadc
make
time ./wasm -isa ../../memory_allocate.wat -e '(invoke "memory_allocate")'
# Monadic isabelle only supports 1.0 features
#time ./wasm -isa ../../memory_fill.wat -e '(invoke "memory_fill")'
time ./wasm -isa ../../memory_store_iterate.wat -e '(invoke "memory_store_iterate")'

echo "wasmtime"
cd ../..
time wasmtime --invoke "memory_allocate" memory_allocate.wat
time wasmtime --invoke "memory_fill" memory_fill.wat
time wasmtime --invoke "memory_store_iterate" memory_store_iterate.wat
echo "wasmi"
time ./wasmi/target/release/wasmi_cli --invoke "memory_allocate" memory_allocate.wat
time ./wasmi/target/release/wasmi_cli --invoke "memory_fill" memory_fill.wat
time ./wasmi/target/release/wasmi_cli --invoke "memory_store_iterate" memory_store_iterate.wat

echo "cleaning up"
cd ../spec/interpreter
git checkout master

echo "Done"
