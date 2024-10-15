<img src="./images/logo.svg" align="right"
     alt="tf2-servers logo by bobair" width="170" height="170">

# tf2-servers

<p>
  <a href="https://github.com/melkortf/tf2-servers/releases">
    <img alt="Latest release" src="https://img.shields.io/github/v/release/melkortf/tf2-servers">
  </a>
  <a href="https://github.com/melkortf/tf2-servers/actions/workflows/build.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/melkortf/tf2-servers/build.yml" alt="Build status">
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/license-MIT-d4c0bf.svg" alt="MIT license">
  </a>
</p>

**[Team Fortress 2 Dedicated Server](https://wiki.teamfortress.com/wiki/Linux_dedicated_server) Docker images for multiple purposes**

```
$ docker run \
  -v "maps:/home/tf2/server/tf/maps" \
  -e "RCON_PASSWORD=foobar123" \
  -e "SERVER_HOSTNAME=melkor.tf" \
  -e "STV_NAME=melkor TV" \
  --network=host \
  ghcr.io/melkortf/tf2-base
```

### Concerning server.cfg

Each TF2 image has its own `server.cfg.template` file that is used to generate `server.cfg`. The docker container
uses `envsubst` to replace environment variables in the template file.
For example, this line in `server.cfg.template`:

```
rcon_password "${RCON_PASSWORD}"
```

when launched with these params:

```
$ docker run --network=host -e RCON_PASSWORD=123456 -itd ghcr.io/melkortf/tf2-base
```

will generate the following `server.cfg`:

```
rcon_password "123456"
```

There are many more configuration options, you will find them all below.

#### tf2-base

```
$ docker pull ghcr.io/melkortf/tf2-base
```

| 32-bit                                                        | 64-bit                            |
| ------------------------------------------------------------- | --------------------------------- |
| `ghcr.io/melkortf/tf2-base`, `ghcr.io/melkortf/tf2-base/i386` | `ghcr.io/melkortf/tf2-base/amd64` |

The base image for all other images; pure TF2 server, without any add-ons and plugins.

| Environment variable | Default value                      | Used in                               | Description                                                                             |
| -------------------- | ---------------------------------- | ------------------------------------- | --------------------------------------------------------------------------------------- |
| IP                   | 0.0.0.0                            | `-ip ${IP}`                           | Specifies the address to use for the bind(2) syscall.                                   |
| PORT                 | 27015                              | `-port ${PORT}`                       | The port which the server will run on.                                                  |
| CLIENT_PORT          | 27016                              | `+clientport ${CLIENT_PORT}`          | The client port.                                                                        |
| STEAM_PORT           | 27018                              | `-steamport ${STEAM_PORT}`            | Master server updater port.                                                             |
| STV_PORT             | 27020                              | `+tv_port ${STV_PORT}`                | SourceTV port.                                                                          |
| SERVER_TOKEN         |                                    | `+sv_setsteamaccount ${SERVER_TOKEN}` | Game server account token to use for logging in to a persistent game server account.    |
| RCON_PASSWORD        | 123456                             | `rcon_password "${RCON_PASSWORD}"`    | The RCON password (change this in your `docker run` invocation).                        |
| SERVER_HOSTNAME      | A Team Fortress 2 server           | `hostname "${SERVER_HOSTNAME}"`       | The game server hostname.                                                               |
| SERVER_PASSWORD      |                                    | `sv_password "${SERVER_PASSWORD}"`    | The server password.                                                                    |
| STV_NAME             | Source TV                          | `tv_name "${STV_NAME}"`               | SourceTV host name.                                                                     |
| STV_TITLE            | A Team Fortress 2 server Source TV | `tv_title "${STV_TITLE}"`             | Title for the SourceTV spectator UI.                                                    |
| STV_PASSWORD         |                                    | `tv_password "${STV_PASSWORD}"`       | SourceTV password.                                                                      |
| DOWNLOAD_URL         | https://fastdl.serveme.tf/         | `sv_downloadurl "${DOWNLOAD_URL}"`    | Download URL for the [FastDL](https://developer.valvesoftware.com/wiki/Sv_downloadurl). |

#### tf2-sourcemod

```
$ docker pull ghcr.io/melkortf/tf2-sourcemod
```

| 32-bit                                                                  | 64-bit                                 |
| ----------------------------------------------------------------------- | -------------------------------------- |
| `ghcr.io/melkortf/tf2-sourcemod`, `ghcr.io/melkortf/tf2-sourcemod/i386` | `ghcr.io/melkortf/tf2-sourcemod/amd64` |

TF2 server with [Metamod:Source](https://www.sourcemm.net/) and [SourceMod](https://www.sourcemod.net/) installed.

#### tf2-competitive

```
$ docker pull ghcr.io/melkortf/tf2-competitive
```

| 32-bit                                                                      | 64-bit |
| --------------------------------------------------------------------------- | ------ |
| `ghcr.io/melkortf/tf2-competitive`, `ghcr.io/melkortf/tf2-competitive/i386` | -      |

TF2 server configured to be used in competitive matches. The following plugins, add-ons and configs are installed:

- [TF2 competitive fixes](https://github.com/ldesgoui/tf2-comp-fixes)
- [Updated pause plugin](https://github.com/l-Aad-l/updated-pause-plugin)
- [SrcTV+](https://github.com/dalegaard/srctvplus)
- [Improved Match Timer plugin](https://github.com/dewbsku/Improved-Match-Timer)
- [Supplemental Stats 2](https://github.com/F2/F2s-sourcemod-plugins#supplemental-stats-2-)
- [Medic Stats](https://github.com/F2/F2s-sourcemod-plugins#medic-stats-)
- [RestoreScore](https://github.com/F2/F2s-sourcemod-plugins#restorescore-)
- [LogsTF](https://github.com/F2/F2s-sourcemod-plugins#logstf-)
- [RecordSTV](https://github.com/F2/F2s-sourcemod-plugins#recordstv-)
- [WaitForSTV](https://github.com/F2/F2s-sourcemod-plugins#waitforstv-)
- [FixStvSlot](https://github.com/F2/F2s-sourcemod-plugins#fixstvslot-)
- [AFK](https://github.com/F2/F2s-sourcemod-plugins#afk-)
- [tf2rue](https://github.com/sapphonie/tf2rue)
- [neocurl](https://github.com/sapphonie/SM-neocurl-ext)
- [demos.tf](https://github.com/demostf/plugin)
- [ETF2L.org configs](https://github.com/ETF2L/gameserver-configs)
- [RGL.gg configs](https://github.com/RGLgg/server-resources-updater/tree/master/cfg)

| Environment variable | Default value | Used in                                | Description                                                           |
| -------------------- | ------------- | -------------------------------------- | --------------------------------------------------------------------- |
| DEMOS_TF_APIKEY      |               | `sm_demostf_apikey ${DEMOS_TF_APIKEY}` | The API key used to upload the demo to [demos.tf](https://demos.tf/). |
| LOGS_TF_APIKEY       |               | `logstf_apikey ${LOGS_TF_APIKEY}`      | The API key used to upload logs to logs.tf.                           |

#### tf2-dm

```
$ docker pull ghcr.io/melkortf/tf2-dm
```

| 32-bit                                                    | 64-bit |
| --------------------------------------------------------- | ------ |
| `ghcr.io/melkortf/tf2-dm`, `ghcr.io/melkortf/tf2-dm/i386` | -      |

TF2 dedicated server for DeathMatch gameplay.

#### tf2-mge

```
$ docker pull ghcr.io/melkortf/tf2-mge
```

| 32-bit                                                      | 64-bit |
| ----------------------------------------------------------- | ------ |
| `ghcr.io/melkortf/tf2-mge`, `ghcr.io/melkortf/tf2-mge/i386` | -      |

TF2 dedicated server for MGE 1v1 training mod.

### Maps

In order to make the image as small as possible, the only map shipped with the image is _cp_badlands_. This has also the advantage of letting you maintain only one directory
with all the maps and share it between all the containers. Just mount `/home/tf2/server/tf/maps` to your local directory that contains all the maps you need:

```
$ docker run -v "/usr/local/data/tf2/maps:/home/tf2/server/tf/maps" --network=host -d ghcr.io/melkortf/tf2-base
```

If you want to have all the maps available on [serveme.tf's FastDL](https://dl.serveme.tf/maps/), just type the following command:

```
$ wget -r --no-parent --accept bsp -l1 --cut-dirs=2 --no-host-directories -nc https://dl.serveme.tf/maps/
```

It will download every single map to the current directory.
