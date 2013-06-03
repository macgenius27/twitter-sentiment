require 'csv'

# too many arrays
tweets = []
positive_words = []
negative_words = []
words = []
positive_counts = []
negative_counts = []
pos_percent = []
neg_percent = []
total = []

# read each file remove punctuation from the tweets
# each tweet or individual word becomes a new entity in an array
File.open("obama.txt", 'r').each_line do |line|
  tweets << line.downcase.to_s.gsub(/[[:punct:]]/, '')
end
File.open("positive_words.txt", 'r').each_line do |line|
  positive_words << line.delete("\n")
end
File.open("negative_words.txt", 'r').each_line do |line|
  negative_words << line.delete("\n")
end

# break apart each tweet so that each word becomes an entity in a new array
# this ulitmately creates a two-dimensional array
tweets.each { |tweet| words << tweet.split(' ') }

# find the index value of each tweet
words.length.times do |index|

  positive_count = 0
  negative_count = 0
  
  # using the index value, loop through each word of the tweet
  # if the word matches a word from either the positive or negative word bank
  # then the respective counter will increment
  words[index].each do |word|
    if positive_words.include? word
      positive_count += 1
    elsif negative_words.include? word
      negative_count += 1
    end
  end
  
  # calculates the percent that a tweet potential could be positive or negative
  pos_percent << positive_count / words[index].size.to_f
  neg_percent << (negative_count*-1)/ words[index].size.to_f

end

sentiment = tweets.zip(pos_percent, neg_percent)

# write to csv
CSV.open('sentiment.csv', "wb") do |csv|
  csv << ['Tweet', 'Pos', 'Neg']
  sentiment.each do |x|
    csv << x
  end
end