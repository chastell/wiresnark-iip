generator do
  interface 'lo'
  cycles 2
  phase_usecs 100, 30, 20, 10
  phase_types 'QoS', 'CAN', 'DSS', 'MGT'
  verbose
end

monitor do
  interface 'lo'
  verbose
end
