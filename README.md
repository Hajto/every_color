# EveryColor

### Running

You have to have Node with `yarn` installed.

First clone front-end repo as well: 
```
git submodule update --init --recursive
```

or by Makefile:
```
make subrepo
```

Next you can install both Elixir and Node dependencies:

```
make install 
```

When all dependencies are installed, you can build front-end part and start server:

```
make build && mix phoenix.server
```

Now your server is available at: `localhost:4000`.

