#!/bin/sh

git cat-file blob master:document.pdf > document.pdf
nice convert -verbose -density 150 document.pdf -resize 1000 -quality 60 images/image-%03d.jpg

cat > index.html <<"HTML"
<html>
<head>
<title>Studienarbeit 2011 KSM Eclipse-RCP</title>
<meta charset='utf-8'>
<style>
body {
text-align: center;
background-color: dfdfdf;
}
#bar {
border: 1px solid gray;
background-color: lightGray;
width: 40%;
position: fixed;
top: 4px;
left: 35%;
}
a {
    text-decoration: none;
}
</style>
<script src="js/jquery-1.6.min.js" type="text/javascript"></script>
<script src="js/jquery.lazyload.js" type="text/javascript"></script>
<script>
  $(function() {
            $("img").lazyload({placeholder:"js/empty.jpg"});
  });
</script>
</head>
<body>
<div id="bar">
    <a href="https://github.com/dhbw-horb/studienarbeit-2011-fischer-eclipse-ksm/blob/master/document.pdf?raw=true">Download PDF</a>
     • 
    <a href="http://github.com/dhbw-horb/ksm-rcp">KSM Projektrepository</a>
     • 
    <a href="http://www.ba-horb.de/~ksm">KSM Website</a>
</div>
<br />
<br />
HTML

for image in images/image-*.jpg; do
    cat >> index.html <<HTML
<img original="$image" border="0" />
<br />
<br />
HTML
done


cat >> index.html <<HTML
</body>
</html>
HTML


rm document.pdf
