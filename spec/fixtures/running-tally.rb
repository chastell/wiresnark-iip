generator do
  count 1
  interface 'lo'
  type 'Eth'
end

generator do
  count 2
  interface 'lo'
  type 'QOS'
end

generator do
  count 3
  interface 'lo'
  type 'CAN'
end

generator do
  count 4
  interface 'lo'
  type 'DSS'
end

generator do
  count 5
  interface 'lo'
  type 'MGT'
end

generator do
  count 6
  interface 'lo'
  type 'Eth'
end

monitor do
  running_tally
  interface 'lo'
end
