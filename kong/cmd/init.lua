require("kong.globalpatches")({cli = true})

math.randomseed() -- Generate PRNG seed

local pl_app = require "pl.lapp"
local log = require "kong.cmd.utils.log"
local inject_directives = require "kong.cmd.utils.inject_directives"

local function stop_timers()
  -- shutdown lua-resty-timer-ng to allow the nginx worker to stop quickly
  if _G.timerng then
    _G.timerng:destroy()
  end
end

return function(cmd_name, args)
  local cmd = require("kong.cmd." .. cmd_name)
  local cmd_exec = cmd.execute

  -- verbose mode
  if args.v then
    log.set_lvl(log.levels.verbose)
  elseif args.vv then
    log.set_lvl(log.levels.debug)
  end

  -- inject necessary nginx directives (e.g. lmdb_*, lua_ssl_*)
  -- into the temporary nginx.conf that `resty` will create
  if inject_cmds[cmd_name] and not args.no_inject then
    log.verbose("start to inject nginx directives and respawn")
    inject_directives.respawn(cmd_name, args)
    return
  end

  log.verbose("Kong: %s", _KONG._VERSION)
  log.debug("ngx_lua: %s", ngx.config.ngx_lua_version)
  log.debug("nginx: %s", ngx.config.nginx_version)
  log.debug("Lua: %s", jit and jit.version or _VERSION)

  xpcall(function() cmd_exec(args) end, function(err)
    if not (args.v or args.vv) then
      err = err:match "^.-:.-:.(.*)$"
      io.stderr:write("Error: " .. err .. "\n")
      io.stderr:write("\n  Run with --v (verbose) or --vv (debug) for more details\n")
    else
      local trace = debug.traceback(err, 2)
      io.stderr:write("Error: \n")
      io.stderr:write(trace .. "\n")
    end

    pl_app.quit(nil, true)
  end)

  stop_timers()
end
