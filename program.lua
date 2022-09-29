function G_split_ip(inputstr, sep)
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    if sep ~= '.' then
      if (#str < 4) then str = string.rep('0', 4 - #str) .. str end
      str = str.lower(str)
    end
    table.insert(t, str)
  end
  return t
end


local function ipv4_to_pairs(ip_address)
  local splittedAddress = G_split_ip(ip_address, '.')
  local ipv4_to_hex = ''
  for octet = 1, #splittedAddress do
    local intToHex = string.format("%x", splittedAddress[octet])
    if (#intToHex ~= 2) then
      intToHex = '0' .. intToHex
    end
    ipv4_to_hex = ipv4_to_hex .. intToHex
    if octet == 2 then
      ipv4_to_hex = ipv4_to_hex .. ":"
    end
  end
  return ipv4_to_hex
end


function G_ip_to_table(ip_address)
  if (string.match(ip_address, ':')) then
    -- ipv6
    if (string.match(ip_address, '%.')) then -- dual ip
      local index = ip_address:match'^.*():'
      local ipv4_part = ip_address:sub(index+1)
      ipv4_part = ipv4_to_pairs(ipv4_part)
      ip_address = ip_address:sub(1, index) .. ipv4_part

    end
    if (string.match(ip_address, '::')) then -- shortened ip
      local positionOfDouble = string.find(ip_address, "::")

      if (positionOfDouble + 1 == #ip_address) then
        ip_address = ip_address .. '0'
      end
      local howManyColons = G_matches_count_str(ip_address, ':')
      local doubleColonReplace = string.rep("0:", 7 - howManyColons + 1)

      ip_address = ip_address:sub(1,positionOfDouble)..doubleColonReplace..ip_address:sub(positionOfDouble+2)
      if (positionOfDouble == 1) then
        ip_address = '0' .. ip_address
      end

    end
  else
    -- ipv4
    local ipv4_to_hex = ipv4_to_pairs(ip_address)
    ip_address = "0:0:0:0:0:ffff:" .. ipv4_to_hex
  end

  local splitAddress = G_split_ip(ip_address, ':')
  return splitAddress
end


function G_count_ips(ip1, ip2)
  local ip1_table = G_ip_to_table(ip1)
  local ip2_table = G_ip_to_table(ip2)

  local totalSum = 0
  for i=1,8 do
    local sum = 0
    if(ip1_table[i] ~= ip2_table[i]) then
      local a1, a2 = ip1_table[i], ip2_table[i]
      for j=1,4 do
        if (string.sub(a1, j, j) ~= string.sub(a2, j, j)) then
          local a1char, a2char = string.sub(a1, j, j), string.sub(a2, j, j)
          local a1num, a2num = tonumber(a1char, 16), tonumber(a2char, 16)
          sum = sum + (a2num - a1num) * 16^(4-j) * 256^(8-i)
        end
      end
    end
    totalSum = totalSum + (sum * 256^(8-i));
  end

  return math.floor(totalSum)
end