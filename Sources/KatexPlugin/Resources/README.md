#  KaTeX Resources

Unfortunately KaTeX cannot be used as is in a `JSContext`. It needs to be bundled first. I use `browserify` for this purpose , however this might not be the optimal way. I am not that knowledgeable in JavaScript so if you know a better way, please send a PR or just email me.

To create (or update) the desired javascript file, you can use browserify from the shell. You need `katex` and `browserify` installed using node for the following to work.

```bash
browserify katex-export.js --standalone Katex -o katex.js
```

`katex-export.js` is used to have a prettier namespace. 
