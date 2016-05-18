module Enumerable
  def wchoice
    self.max_by {|_, weight| rand ** (1.0/weight)}.first
  end
end

class String
  def path
    root = ::File.dirname(__FILE__)
    ::File.join(root, 'data', self)
  end
end

class MadWordsGenerator
  def initialize
    @first_letter = {}
    File.open('first_letter.csv'.path, "r") do |f|
      f.each_line do |line|
        arr = line.split(';')
        @first_letter[arr[0]] = arr[2].to_f
      end
    end

    @second_letter = {}
    File.open("two_letters.csv".path, "r") do |f|
      f.each_line do |line|
        arr = line.split(';')
        @second_letter[arr[0]] ||= {}
        @second_letter[arr[0]][arr[1]] = arr[2].to_f
      end
    end

    @second_letter.each do |k, v1|
      s = 0
      v1.each do |k2, v2|
        s += v2
      end
      v1.each do |k2, v2|
        v1[k2] = v2/s
      end
    end

    @ngram = {}
    File.open("ngram.csv".path, "r") do |f|
      f.each_line do |line|
        arr = line.split(';')
        @ngram[arr[0]] ||= {}
        @ngram[arr[0]][arr[1]] = arr[2].to_f
      end
    end

    @ngram.each do |k, v1|
      s = 0
      v1.each do |k2, v2|
        s += v2
      end
      v1.each do |k2, v2|
        v1[k2] = v2/s
      end
    end
  end

  def generate
    start = @first_letter.wchoice
    second = @second_letter[start].wchoice
    res_arr = [start, second]

    loop do
      ngr = res_arr[res_arr.length - 2] + res_arr[res_arr.length - 1]
      next_letter = @ngram[ngr].wchoice
      if next_letter == '$' then break end
      res_arr << next_letter
    end

    res_arr.join
  end
end
