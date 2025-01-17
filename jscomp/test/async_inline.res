let willBeInlined = async () => 3

let inlined = willBeInlined ()

let wrapSomethingAsync: unit => unit = () => {
  let _ = (
    async (_) => {
      let test = await Js.Promise.resolve("Test")
      Js.log(test)
    }
  )(777)
}

external ignorePromise: promise<'a> => unit = "%identity"

let wrapSomethingAsync2 = () =>
  (
    async () => {
      let test = await Js.Promise.resolve("Test")
      Js.log(test)
    }
  )()->ignorePromise

module M: {
  let broken: (unit => promise<'a>) => promise<'a>
} = {
  let doSomethingAsync = async (someAsyncFunction) => {
    await someAsyncFunction()
  }

  let broken = someAsyncFunction => doSomethingAsync(someAsyncFunction)
}

let broken = async (someAsyncFunction) => {
  await someAsyncFunction()
}

let broken = someAsyncFunction => broken(someAsyncFunction)

let curriedId = x => x
let curriedIdAsync = async x => x
let uncurriedId = (.x ) => x
let uncurriedIdAsync = async (.x ) => x

let tci = curriedId(3)
let tcia = curriedIdAsync(3)
let tui = uncurriedId(. 3)
let tuia = uncurriedIdAsync(. 3)