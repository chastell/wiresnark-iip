generator do
  count 3
  interface 'lo'
  sequence
  verbose
end

monitor do
  interface 'lo'
  verbose
end
