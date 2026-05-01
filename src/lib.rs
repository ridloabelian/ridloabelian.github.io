use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn generate_activity() -> String {
    let activities = vec![
        "$ rustc --edition 2021 main.rs\nCompiling ridlo_wasm v0.1.0\nFinished release [optimized]",
        "$ cargo build --release\n   Compiling ridlo_wasm v0.1.0\n    Finished release [optimized]",
        "$ trunk serve\n📦 Starting dev server...\n✓ Serving on http://127.0.0.1:8080",
    ];
    
    let random_idx = (js_sys::Math::random() * activities.len() as f64) as usize;
    activities[random_idx].to_string()
}
