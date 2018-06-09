import resolve from "rollup-plugin-node-resolve";

export default {
  input: "src/background.js",
  output: {
    format: "es",
    file: "dist/background.js"
  },
  plugins: [resolve()]
};
