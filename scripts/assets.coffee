fs = require('fs');
path = require('path');
env = require('node-env-file');
env(__dirname + '/../.env');

assetWhitelist = fs.readdirSync(process.env.DATA_DIR).filter (assetFile) ->
  assetFile.includes('AMT') && !assetFile.includes('.log')

logDateTime = ->
  dateObj = new Date();
  month = dateObj.getUTCMonth() + 1;
  day = dateObj.getUTCDate();
  year = dateObj.getUTCFullYear();
  hour = dateObj.getHours();
  minute = dateObj.getMinutes();

  "#{month}/#{day}/#{year} #{hour}:#{minute}"


module.exports = (robot) ->

  # Asset status
  robot.hear /!asset \s*(\S+)$/i, (res) ->
    assetTag = res.match[1];

    if assetWhitelist.includes(assetTag)
      contents = fs.readFileSync(path.join(process.env.DATA_DIR, assetTag))
      res.send "#{assetTag}: #{contents}"
    else
      res.send "Asset not found"


  # Asset update
  robot.hear /!asset \s*(\S+) (.*)/i, (res) ->
    assetTag = res.match[1]
    status = res.match[2]

    if assetWhitelist.includes(assetTag)
      res.send "#{res.message.user.name}: Updating asset '#{assetTag}' to '#{status}'"


      logMessage = "#{status} [#{res.message.user.name} @ #{logDateTime()}]\n"

      # update the log
      fs.appendFileSync(path.join(process.env.DATA_DIR, "#{assetTag}.log"), logMessage);

      # update the status
      fs.writeFileSync(path.join(process.env.DATA_DIR, assetTag), logMessage);

    else
      res.send "Asset not found"
