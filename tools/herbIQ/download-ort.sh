mkdir ort
cd ort
curl -O https://cdn.jsdelivr.net/npm/onnxruntime-web@1.20.1/dist/ort.min.js
curl -O https://cdn.jsdelivr.net/npm/onnxruntime-web@1.20.1/dist/ort-wasm-simd-threaded.wasm
curl -O https://cdn.jsdelivr.net/npm/onnxruntime-web@1.20.1/dist/ort-wasm-simd-threaded.mjs
# Bei Bedarf weitere — ein DevTools-Network-Tab-Check zeigt was wirklich geladen wird