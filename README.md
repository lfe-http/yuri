# yuri

[![Build Status][gh-actions-badge]][gh-actions]
[![LFE Versions][lfe badge]][lfe]
[![Erlang Versions][erlang badge]][version]
[![Tags][github tags badge]][github tags]

[![Project Logo][logo]][logo-large]

*An LFE library for working with URIs*

## About [&#x219F;](#table-of-contents)

This library is serves a handful of purposes:

* provides additional parsing of URI data on top of what the Erlang `uri_string` library already does;
* does conversions for bytestring URIs
* provides a URI encode function
* wraps some basic `uri_string` functions (like `parse`) for convenience

## Build [&#x219F;](#table-of-contents)

```shell
rebar3 lfe compile
```

# Tests [&#x219F;](#table-of-contents)

```shell
rebar3 as test ltest
```

## Usage [&#x219F;](#table-of-contents)

TBD

## License [&#x219F;](#table-of-contents)

Apache License, Version 2.0

Copyright © 2023, Duncan McGreggor <oubiwann@gmail.com>.

[//]: ---Named-Links---

[logo]: priv/images/yuri-small.jpg
[logo-large]: priv/images/yuri.jpg
[gh-actions-badge]: https://github.com/lfex/yuri/actions/workflows/cicd.yml/badge.svg
[gh-actions]: https://github.com/lfex/yuri/actions
[lfe]: https://github.com/lfe/lfe
[lfe badge]: https://img.shields.io/badge/lfe-2.1-blue.svg
[erlang badge]: https://img.shields.io/badge/erlang-21%20to%2026-blue.svg
[version]: https://github.com/lfex/yuri/blob/master/.github/workflows/cicd.yml
[github tags]: https://github.com/lfex/yuri/tags
[github tags badge]: https://img.shields.io/github/tag/ORG/yuri.svg
