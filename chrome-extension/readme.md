## Install

1.  `yarn build`
2.  Load unpacked extension from `./dist`


## Notes on Tooling

`yarn test --watch` watches too much. E.g. it runs when `dist/background.js` changes. However, it is much faster than more precise watching with something external.

Linter auto-fix and Prettier run on whole files, not on hunks. However, I don't consider this relevant. Files should always be formatted properly. If they are not, let's run into conflicts earlier.

The need to run `xo --fix` manually on staged files, i.e. its incompatibility with _lint-staged_, makes me wonder whether it would be clearer to run Prettier in same fashion.
