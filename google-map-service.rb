require "socket"
 
server=TCPServer.new('192.168.0.6',3131)
 
begin
 
while(session=server.accept)
    request=session.gets
    STDERR.puts request
     
    response=""" 
<!DOCTYPE html>
<html>
<head>
<title> Google Map Service v7.3 </title>
<script src=http://maps.googleapis.com/maps/api/js></script><script>
function initialize() {
  var mapProp = {
    center:new google.maps.LatLng(45,0),
    zoom:4,
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  var map=new google.maps.Map(document.getElementById('googleharita'),mapProp);
}
google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>
<body bgcolor='black'>
<body>
<div id='googleharita' style='width:1350px;height:550px;'></div>
</body>
</html> """
    session.print "HTTP/1.1 200 OK\r\n" +
                "Content-Type: text/html\r\n" +
                "Content-Length: #{response.bytesize}\r\n" +
                "Connection: close\r\n"
    session.print "\r\n"
    session.print response
    session.close
end
 
rescue Errno::EPIPE
  STDERR.puts "!!! Connection Broke !!!"
  end
