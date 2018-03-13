# toybot

toybot is a chat bot built on the [Hubot][hubot] framework. It was
initially generated by [generator-hubot][generator-hubot].

There is a single file that was not created by the generator. That is [assets.coffee](scripts/assets.coffee).

This script simply listens for asset updates from slack and updates log and asset files in the `/var/www/acemonstertoys.org/assets/data` directory of the AMT server.


## Running toybot Locally

You will need the AMT slack token. You can get this on the AMT server in `/home/toybot/amt_toybot/.env`.

You will need to set your `DATA_DIR` environment variable to a directory. The files in there should mirror the structure of `/var/www/acemonstertoys.org/assets/data`.

    % touch .env

Add your data dir to it like :

```
DATA_DIR=/home/rob/workspace/data/
```
(notice ending backslash)

You can start toybot locally by running:

    % HUBOT_SLACK_TOKEN=xxxxxxxx ./bin/hubot --adapter slack


## Production

### Installation

Toybot runs on the AMT server under the toybot user. It requres nodejs to run.

Steps to install:
* Install node js
* `cd ~ && git clone https://github.com/rfroetscher/amt_toybot.git`
* `cd amt_toybot && npm install`
* `touch .env`
* Add "DATA_DIR=/var/www/acemonstertoys.org/assets/data/" to .env

### Starting
Ensure it is not already running:
`ps aux | grep hubot`

If not:
`bash /home/toybot/start_toybot.sh`
