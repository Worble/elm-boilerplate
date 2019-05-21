# Project Structure

  

All the source files can be found under `/src`

All tests can be found under `/tests`

All custom webpack loaders can be found under `/loaders`

All distribution files can be found under `/dist`

  

# Building from Source



* Run `npm i` or `yarn` in the root folder

* Run any of the following in the root folder (feel free to substitute `yarn` for `npm run`)

	* Running `yarn dev` will compile a new unoptimized app.js in dist with elm set to debug mode

	* Running `yarn serve` will start a devserver that watches for changes on localhost:8080 (if available) running an unoptimized debug build

	* Running `yarn prod` will create an optimized production build in dist

  

# Running Tests

  

* Run `npm i` or `yarn` in the root folder if you have not already done so

* Run `npx elm-test` or `yarn elm-test` in the root folder to run tests in the command line

* Run `npm run test` or `yarn test` to run tests, output a junit report to `/tests/report/` and serve the report in allure (allure must be installed on your computer for this command to work, for obvious reasons).



# Known Issues



* [`elm-typescript-interop` dependency is using `Elm AST`, which is not going to update to 0.19](https://github.com/dillonkearns/elm-typescript-interop/issues/15#issuecomment-438448890). [Work is potentially being done to change to `elm-syntax`](https://github.com/dillonkearns/elm-typescript-interop/issues/17). However until this is done `elm-typescript-interop` may potentially fail. In these cases you may be able to work around it by simply commenting the offending line, if it can be found, and running `elm-typescript-interop` just to generate the typescript, and then uncommenting. Otherwise, you can forgo using this library entirely and removing the calls to `elm-typescript-interop` in the package.json and updating `src/index.ts` to use `Main.elm` directly, and probably updating tsconfig.json to no longer be strict.
