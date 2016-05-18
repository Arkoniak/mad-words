class String
  def initial
    self[0, 1]
  end

  def second
    self[1, 2]
  end

  def twoletters
    self[0, 2].chars
  end
end

def build_frequencies(weights = false)
  first_letter_freq = {}
  second_letter_freq = {}
  ngram_freq = {}
  output_files = ['first_letter', 'two_letters', 'ngram']
  output_files = output_files.map {|fname| fname + (weights ? '_w' : '') + '.csv' }
  output_hashes = {output_files[0] => first_letter_freq, output_files[1] => second_letter_freq, output_files[2] => ngram_freq}

  sub_freq = {}
  
  res_sum = 0

  File.open("litw_utf8.txt", "r") do |f|
    f.each_line do |line|
      line_arr = line.split(' ')
      word = line_arr[1] + "$"
      delta = weights ? line_arr[0].to_i : 1
      res_sum += delta
      initial = [word.initial]
      twoletters = word.twoletters
      first_letter_freq[initial] ||= 0
      first_letter_freq[initial] += delta
      second_letter_freq[twoletters] ||= 0
      second_letter_freq[twoletters] += delta

      word.chars.each_cons(3) do |ngramm|
        rh = ngramm.pop
        lh = ngramm.join("")
        key = [lh, rh]
        ngram_freq[key] ||= 0
        ngram_freq[key] += delta 
      end
    end

    output_files.each do |fname|
      File.open(fname, "w") do |f|
        output_hashes[fname].each do |k, v|
          f.puts(k.join(";") + ";" + v.to_s + ";" + "%.15f" % (v.to_f/res_sum.to_f))
        end
      end
    end
  end

  # puts first_letter_freq
  # puts second_letter_freq
  # puts ngram_freq
end

build_frequencies
build_frequencies true
