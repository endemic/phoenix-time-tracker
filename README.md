# TimeTracker

<p>TimeTracker runs in a Docker container.</p>

<ol>
  <li>Build the image (`./script/build`)</li>
  <li>Start the container (`./script/start`)</li>
  <li>Visit [`localhost:4000`](http://localhost:4000) from your browser</li>
</ol>

### Other helpful shortcuts

1. `./script/logs` &rarr; tail logs for the container
1. `./script/console` &rarr; run a Phoenix console
1. `./script/shell` &rarr; access an interactive shell in the container

### Known issues

1. The Elixir dependencies are stored in `/app`, but then overwritten by a local shared volume when the container is started.
