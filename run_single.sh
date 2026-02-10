set -ex

FILE="$1"
FUNC="$2"

echo "wasmtime"
time wasmtime --invoke "$FUNC" "$FILE"
echo "wasmi"
time ./wasmi/target/release/wasmi_cli --invoke "$FUNC" "$FILE"

echo "Rocq"
cd WasmCert-Coq
dune build
time ./wasm_coq_interpreter.exe --text "../$FILE" -r "$FUNC"

cd ../spec/interpreter
git checkout 547d565
make
echo "reference interpreter"
time ./wasm "../../$FILE" -e "(invoke \"$FUNC\")"
echo "Isabelle (non-monadic)"
time ./wasm -isa "../../$FILE" -e "(invoke \"$FUNC\")"

echo "Isabelle (monadic)"
git checkout ddeaadc
make
time ./wasm -isa "../../$FILE" -e "(invoke \"$FUNC\")"

echo "cleaning up"
git checkout master

echo "Done"
