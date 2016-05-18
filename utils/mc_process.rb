module Enumerable
  def wchoice
    self.max_by {|_, weight| rand ** (1.0/weight)}.first
  end
end

first_letter = {}
File.open("first_letter.csv", "r") do |f|
  f.each_line do |line|
    arr = line.split(';')
    first_letter[arr[0]] = arr[2].to_f
  end
end

second_letter = {}
File.open("two_letters.csv", "r") do |f|
  f.each_line do |line|
    arr = line.split(';')
    second_letter[arr[0]] ||= {}
    second_letter[arr[0]][arr[1]] = arr[2].to_f
  end
end

second_letter.each do |k, v1|
  s = 0
  v1.each do |k2, v2|
    s += v2
  end
  v1.each do |k2, v2|
    v1[k2] = v2/s
  end
end

ngram = {}
File.open("ngram.csv", "r") do |f|
  f.each_line do |line|
    arr = line.split(';')
    ngram[arr[0]] ||= {}
    ngram[arr[0]][arr[1]] = arr[2].to_f
  end
end

ngram.each do |k, v1|
  s = 0
  v1.each do |k2, v2|
    s += v2
  end
  v1.each do |k2, v2|
    v1[k2] = v2/s
  end
end

1.upto(1000) do 
  start = first_letter.wchoice
  second = second_letter[start].wchoice
  res_arr = [start, second]

  loop do
    ngr = res_arr[res_arr.length - 2] + res_arr[res_arr.length - 1]
    next_letter = ngram[ngr].wchoice
    if next_letter == '$' then break end
    res_arr << next_letter
  end

  puts res_arr.join
end
