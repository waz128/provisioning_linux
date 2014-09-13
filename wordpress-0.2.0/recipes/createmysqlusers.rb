api_string = (0...32).map{65.+(rand(25)).chr}.join
$mypass = "#{api_string}"

print  $mypass
print  $mypass