function G_print_table(table)
  for index, value in pairs(table) do
    print('    ' .. tostring(index) .. ' : ' .. tostring(value))
  end
end

function G_matches_count_str(haystack, needle)
  local count = 0
  local i = 0
  while true do
    i = string.find(haystack, needle, i+1)
    if i == nil then break end
    count = count + 1
  end
  return count
end