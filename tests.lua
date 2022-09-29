require('helpers')
require('program')

local testAdresses = {
  '1.55.103.104',
  '127.0.0.1',
  '255.255.255.255',
  '01.055.103.104',
  '2001:db8:3333:0:5555:6666:7777:8888',
  '2001:db8:3333:4444:CCCC:DDDD:EEEE:FFFF',
  '::',
  '2001:db8::',
  '::1234:5678',
  '2001:db8::1234:5678',
  '2001:db5::1234:5678',
  '2001:0db8:1:00:0:0ab9:C0A8:0102',
  '2001:db8:3333:4444:5555:6666:1.2.3.4',
  '::11.22.33.44',
  '2001:db8::1234:5678:5.6.7.8'
}

for _, value in ipairs(testAdresses) do
  print(value)
  G_print_table(G_ip_to_table(value))
end

print(G_count_ips('10.0.0.0', '10.0.0.50') == 50)
print(G_count_ips('10.0.0.0', '10.0.1.0') == 256)
print(G_count_ips('20.0.0.10', '20.0.1.0') == 246)
print(G_count_ips('::ffff:ffff:ffff:ffff:ffff', '0:0:1::') == 1)
print(G_count_ips('2001:0db8:0000:0000:0000:8a2e:0370:7334', '2001:0db8:0000:0000:0000:8a2e:0370:7555') == 545)
print(G_count_ips('0.0.0.0', '255.255.255.255'))
print(G_count_ips('::', '::fff:ffff:ffff:ffff'))