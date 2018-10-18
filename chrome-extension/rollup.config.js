import resolve from 'rollup-plugin-node-resolve'
import commonjs from 'rollup-plugin-commonjs'

export default {
  input: 'src/background.js',
  output: {
    format: 'es',
    file: 'dist/background.js'
  },
  plugins: [resolve(), commonjs()]
}
