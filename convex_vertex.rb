LINE = [*"a".."t"]

def normalize elems
  tmp = elems.map do |elem|
    next if elem == "00"
    x, y = elem.scan(/./)
    x = x.to_i
    y = LINE.find_index(y)
    [x, y]
  end
  if elems.include? "00"
    [*0..19].map{|i| [0, i]}.each{ |xy| tmp.push(xy) }
  end
  tmp.compact
end

def standarlize elem
  x, y = elem
  return [-1, -1] if x < 0
  return [] if x > 4
  return [x, y%20]
end

def neighbors elem
  x, y = elem
  [
    standarlize([x-1, y+1]),
    standarlize([x-1, y  ]),
    standarlize([x,   y-1]),
    standarlize([x+1, y-1]),
    standarlize([x+1, y  ]),
    standarlize([x,   y+1]),
  ]
end

def solve args
  elems = args.scan(/(\d\w|\d\d)/).flatten
  normalize_elems = normalize(elems)

  total_inc = 0
  normalize_elems.each do |elem|
    nl = neighbors elem

    sub_inc = 0
    neighbor_bools = nl.map{|n| normalize_elems.include?(n) || n == [-1, -1] }
    [neighbor_bools, neighbor_bools.rotate].transpose.each do |b1, b2|
      sub_inc += 1 if !b1 && !b2
    end

    total_inc += sub_inc
  end
  puts "total: #{total_inc}"
end

solve "1c004g1k4o3p3l3h1r4d2t2c2d1n4t2e1s1j2p1d4j1h1f"
