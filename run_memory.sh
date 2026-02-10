set -ex

echo "wasmtime"
time wasmtime --invoke "memory_allocate" memory_allocate.wat
time wasmtime --invoke "memory_fill" memory_fill.wat
time wasmtime --invoke "memory_store_iterate" memory_store_iterate.wat
time wasmtime --invoke "memory_grow" memory_grow.wat
echo "wasmi"
time ./wasmi/target/release/wasmi_cli --invoke "memory_allocate" memory_allocate.wat
time ./wasmi/target/release/wasmi_cli --invoke "memory_fill" memory_fill.wat
time ./wasmi/target/release/wasmi_cli --invoke "memory_store_iterate" memory_store_iterate.wat
time ./wasmi/target/release/wasmi_cli --invoke "memory_grow" memory_grow.wat

echo "Rocq"
cd WasmCert-Coq
dune build
time ./wasm_coq_interpreter.exe --text ../memory_allocate.wat -r "memory_allocate"
time ./wasm_coq_interpreter.exe --text ../memory_fill.wat -r "memory_fill"
time ./wasm_coq_interpreter.exe --text ../memory_store_iterate.wat -r "memory_store_iterate"
time ./wasm_coq_interpreter.exe --text ../memory_grow.wat -r "memory_grow"

cd ../spec/interpreter
git checkout 547d565
make
echo "reference interpreter"
time ./wasm ../../memory_allocate.wat -e '(invoke "memory_allocate")'
time ./wasm ../../memory_fill.wat -e '(invoke "memory_fill")'
time ./wasm ../../memory_store_iterate.wat -e '(invoke "memory_store_iterate")'
time ./wasm ../../memory_grow.wat -e '(invoke "memory_grow")'
echo "Isabelle (non-monadic)"
time ./wasm -isa ../../memory_allocate.wat -e '(invoke "memory_allocate")'
time ./wasm -isa ../../memory_fill.wat -e '(invoke "memory_fill")'
time ./wasm -isa ../../memory_store_iterate.wat -e '(invoke "memory_store_iterate")'
time ./wasm -isa ../../memory_grow.wat -e '(invoke "memory_grow")'

echo "Isabelle (monadic)"
git checkout ddeaadc
make
time ./wasm -isa ../../memory_allocate.wat -e '(invoke "memory_allocate")'
# Monadic isabelle only supports 1.0 features
#time ./wasm -isa ../../memory_fill.wat -e '(invoke "memory_fill")'
time ./wasm -isa ../../memory_store_iterate.wat -e '(invoke "memory_store_iterate")'
time ./wasm -isa ../../memory_grow.wat -e '(invoke "memory_grow")'

echo "cleaning up"
git checkout master

echo "Done"
