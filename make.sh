#!/bin/sh

git cat-file blob master:document.pdf > document.pdf
nice convert -verbose -density 150 document.pdf -resize 1000 -quality 60 images/image-%03d.jpg

cat > index.html <<"HTML"
<html>
<head>
<title>Studienarbeit 2011 KSM Eclipse-RCP</title>
<style>
body {
text-align: center;
background-color: efefef;
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
<a href="document.pdf">Download als PDF</a>
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
