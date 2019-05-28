# Project Structure  

All source files can be found under `/src`

All static files can be found under `/static`

All tests can be found under `/tests`

All webpack loaders can be found under `/loaders`

All distribution files can be found under `/dist`  

# Building from Source

* When running `git clone`, pass `--recurse-submodules` to ensure the loader is also pulled. If the project is already cloned, alternatively run `git submodule init` and `git submodule update` to pull the loader
  * The loader being pulled is the same as the loader at https://github.com/elm-community/elm-webpack-loader, with the small exception that it uses uglifyjs with the settings described [here](https://guide.elm-lang.org/optimization/asset_size.html) when run for production. This can give some performance benefits, especially for larger code bases. If for whatever reason you don't want this, or it doesn't work, you can simply add the original elm webpack loader with `yarn add elm-webpack-loader --dev` and update the webpack files to use it: `loader: 'elm-webpack-loader'`
* Run `npm i` or `yarn` in the `loaders/elm-webpack-loader` folder
* Run `npm i` or `yarn` in the root folder
* Run any of the following in the root folder (feel free to substitute `yarn` for `npm run`)
	* Running `yarn dev` will compile a new unoptimized app.js in dist with elm set to debug mode
	* Running `yarn serve` will start a devserver that watches for changes on localhost:8080 (if available) running an unoptimized debug build
	* Running `yarn prod` will create an optimized production build in dist

  

# Running Tests  

* Run `npm i` or `yarn` in the root folder if you have not already done so
* Run `npm run test` or `yarn test` in the root folder to run tests in the command line
* Ensure that `/tests/report` directory exists, and run `npm run test-allure` or `yarn test-allure` to run tests, output a junit report to `/tests/report/` and serve the report in [allure](http://allure.qatools.ru/) (allure must be installed on your computer for this command to work).

# Known Issues

* [`elm-typescript-interop` dependency is using `Elm AST`, which is not going to update to 0.19](https://github.com/dillonkearns/elm-typescript-interop/issues/15#issuecomment-438448890). [Work is potentially being done to change to `elm-syntax`](https://github.com/dillonkearns/elm-typescript-interop/issues/17). However until this is done `elm-typescript-interop` may potentially fail. In these cases you may be able to work around it by simply commenting the offending line, if it can be found, and running `elm-typescript-interop` just to generate the typescript, and then uncommenting. Otherwise, you can forgo using this library entirely by removing the calls to `elm-typescript-interop` in the package.json and updating `src/index.ts` to use `Main.elm` directly, and probably updating tsconfig.json to no longer be strict.
