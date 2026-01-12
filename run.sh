set -ex
./WasmCert-Coq/wasm_coq_interpreter.exe wasm-coremark/coremark-minimal.wasm -r run
./spec/interpreter/wasm wasm-coremark/coremark-minimal.wasm -e '(invoke "run")'
./spec/interpreter/wasm -isa wasm-coremark/coremark-minimal.wasm -e '(invoke "run")'
