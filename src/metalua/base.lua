----------------------------------------------------------------------
----------------------------------------------------------------------
--
-- Base library extension
--
----------------------------------------------------------------------
----------------------------------------------------------------------

require 'checks'

function o (...)
   local args = {...}
   local function g (...)
      local result = {...}
      for i=#args, 1, -1 do result = {args[i](unpack(result))} end
      return unpack (result)
   end
   return g
end

function id (...) return ... end
function const (k) return function () return k end end

function printf(...) return print(string.format(...)) end
function eprintf(...) 
   io.stderr:write(string.format(...).."\n") 
end

function ivalues (x)
   checks('table')
   local i = 1
   local function iterator ()
      local r = x[i]; i=i+1; return r
   end
   return iterator
end


function values (x)
   checks('table')
   local function iterator (state)
      local it
      state.content, it = next(state.list, state.content)
      return it
   end
   return iterator, { list = x }
end

function keys (x)
   checks('table')
   local function iterator (state)
      local it = next(state.list, state.content)
      state.content = it
      return it
   end
   return iterator, { list = x }
end

require 'metalua.table'
require 'metalua.string'
require 'metalua.package'