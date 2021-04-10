#!/usr/bin/env lua

require("table");

lines = {};
for line in function() return io.read() end do
  table.insert(lines, line);
end

for i = #lines, 1, -1 do
  print(lines[i])
end
