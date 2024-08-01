## Reader Swagger Docs

You'll notice one of the clone repos is `swagger-api/swagger-ui.git`.
I downloaded this to easily read the Swagger docs (JSON)
of an integration partner we were working with, Origami Risk.
At the time they weren't able to share their actual docs site.

To use the repo:

- Create a subdirectory under `dist` for the project (e.g. `dist/origami`)
- Add the Swagger JSON to it (e.g. `dist/origami/swagger.json`)
- Within `dist/swagger-initializer.json`, set the URL to `origami/swagger.json`
- From the repo root, run `cd dist && python3 -m http.server 8000`
- Open http://localhost:8000/ in a browser
