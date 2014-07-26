#!/usr/bin/ruby

require "selenium-webdriver"

driver = Selenium::WebDriver.for :firefox
driver.navigate.to "http://www.japanesepod101.com/member/login_new.php" #"http://www.japanesepod101.com/index.php?cat=3"
driver.execute_script("show_login_form()")
driver.find_element(:name, 'amember_login').send_keys "user"
driver.find_element(:name, 'amember_pass').send_keys "password"
driver.execute_script("document.forms['signin'].submit();")
hash = [{:uri => 'Absolute+Beginner'}, {:uri => 'Beginner'}, {:uri => 'Intermediate'}, {:uri => 'Advanced'}, {:uri => 'Japanese%20Specific'}]
hash.each do |link|
  File.open('/home/warren/Desktop/japanese2.txt', 'a'){|f| f.puts "_#{link[:uri]}__"}
  driver.get( 'http://www.japanesepod101.com/index.php?cat=' + link[:uri])
  (link[:childern] = driver.execute_script('return document.getElementsByClassName("post-panel ill-categorylist-item")')).map{|e| {:uri => driver.execute_script("return arguments[0].children[0].href", e)}}.each do |c|
    File.open('/home/warren/Desktop/japanese2.txt', 'a'){|f| f.puts "__#{c[:uri]}__"}
    driver.get(c[:uri])
    (c[:children] = driver.execute_script('return document.getElementsByClassName("lesson-title ill-stockholm")')).map{|e| {:uri => driver.execute_script("return arguments[0].href", e)}}.each do |c1|
      File.open('/home/warren/Desktop/japanese2.txt', 'a'){|f| f.puts "___#{c1[:uri]}___"}
      driver.get(c1[:uri])
      c1[:children] = driver.execute_script('return document.getElementsByClassName("lesson-media")').map{|mp| {:uri => driver.execute_script('return arguments[0].children[1].href', mp)}}
      File.open('/home/warren/Desktop/japanese2.txt', 'a'){|f| c1[:children].each{|u| f.puts u[:uri]}}
	  driver.get(c[:uri])
	end
	driver.get(link[:uri])
  end
end

puts hash.to_s
driver.quit
