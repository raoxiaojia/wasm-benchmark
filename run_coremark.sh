set -ex
echo "Coremark - Rocq"
cd WasmCert-Coq
dune build
./wasm_coq_interpreter.exe ../wasm-coremark/coremark-minimal.wasm -r run

cd ../spec/interpreter
git checkout 547d565
make
echo "Coremark - reference interpreter"
./wasm ../../wasm-coremark/coremark-minimal.wasm -e '(invoke "run")'
echo "Coremark - Isabelle (non-monadic)"
./wasm -isa ../../wasm-coremark/coremark-minimal.wasm -e '(invoke "run")'

echo "Coremark - Isabelle (monadic)"
git checkout ddeaadc
make
./wasm -isa ../../wasm-coremark/coremark-minimal.wasm -e '(invoke "run")'

echo "wasmtime"
cd ../../wasm-coremark-rs
cargo build
./target/release/bm wasmtime
echo "wasmi"
./target/release/bm wasmi

echo "cleaning up"
cd ../spec/interpreter
git checkout master

echo "Done"
