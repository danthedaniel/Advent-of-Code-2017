#!/usr/bin/env ruby

def assert(thing)
  raise "Assertion failed!" unless thing
end

def test_captcha
  assert captcha('1122') == 3
  assert captcha('1111') == 4
  assert captcha('1234') == 0
  assert captcha('91212129') == 9
end

def test_captcha2
  assert captcha2('1212') == 6
  assert captcha2('1221') == 0
  assert captcha2('123425') == 4
  assert captcha2('123123') == 12
  assert captcha2('12131415') == 4
end

def captcha(input)
  (input + input[0])
    .scan(/(?=(\d)\1)/)
    .flatten
    .map(&:to_i)
    .sum
end

def captcha2(input)
  distance = (input.length / 2) - 1
  (input + input[0..distance]).scan(/(?=(\d)\d{#{distance}}\1)/).flatten.map(&:to_i)
    .sum
end

test_captcha
test_captcha2

input = File.read('input')[0..-2] # Strip off \n
puts captcha(input)
puts captcha2(input)
