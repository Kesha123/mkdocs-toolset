# mkdocs-toolset

MkDocs with the Material theme and authoring plugins, packaged in a minimal Alpine container.

## Image

`ghcr.io/kesha123/mkdocs-toolset` — date-based release tags (e.g. `2026.10.01`) plus a moving `latest`.

## Usage

```sh
# serve docs from the current directory
docker run --rm -p 8000:8000 -v "$PWD:/work" -w /work \
  ghcr.io/kesha123/mkdocs-toolset mkdocs serve --dev-addr 0.0.0.0:8000

# build static site into ./site
docker run --rm -v "$PWD:/work" -w /work \
  ghcr.io/kesha123/mkdocs-toolset mkdocs build

# no arguments → interactive shell
docker run --rm -it -v "$PWD:/work" -w /work ghcr.io/kesha123/mkdocs-toolset
```

## Local build

```sh
make -C mkdocs build     # build image (tagged <short-sha> + latest)
make -C mkdocs publish   # build and push to ghcr.io
```

`BUILD_TAG`, `PLATFORM`, and `CACHE` can be overridden on the command line.

## CI

| Workflow | Purpose |
| --- | --- |
| `build.yaml` | Reusable build (manual or called); builds image on linux/amd64 |
| `publish.yaml` | Reusable publish (manual or called); pushes tag + `latest` to ghcr.io |
| `main.yaml` | Push to `main` → build + publish (`main-<short-sha>`) |
| `pull-request.yaml` | Pull requests → build (`pr-<number>`) |
| `release.yaml` | Manual → next tag, GitHub release, build + publish |

Dependabot keeps Python dependencies (`mkdocs/requirements.in`) and GitHub Actions up to date.

## Releases

The first release is `0.0.0`; subsequent tags are the release date (`yyyy.mm.dd`), suffixed `.2`, `.3`, … when releasing multiple times per day. `scripts/next-release-tag.sh` computes the next tag from existing git tags.
