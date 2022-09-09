# TimeTracker

<p>TimeTracker runs in a Docker container.</p>

1. Build the image (`./script/build`)
2. Start the container (`./script/start`)
3. Visit [`localhost:4000`](http://localhost:4000) from your browser

### Other helpful shortcuts

1. `./script/logs` &rarr; tail logs for the container
2. `./script/console` &rarr; run a Phoenix console
3. `./script/shell` &rarr; access an interactive shell in the container

### Known issues

1. The Elixir dependencies are stored in `/app`, but then overwritten by a local shared volume when the container is started.
