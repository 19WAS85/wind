AT_START = []

def at_start(&block)
  AT_START << block
end

def at_start_execution
  AT_START.each { |proc| proc.call } 
end