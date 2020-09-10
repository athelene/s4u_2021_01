<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="IE=7">

  <link rel="icon" href="/favicon-16x16.png" type="image/png" size="16x16">
  <link rel="icon" href="/favicon-32x32.png" type="image/png" size="32x32">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link href="/css/mdb.min.css" rel="stylesheet">
    <link href="/s4u.css" rel="stylesheet">
    <link href="/main.css" rel="stylesheet">
</head>

<body>


    <cfquery name="qUnsetFeature">
        update MediaTbl
        set FeatureMedia = NULL
        where storyID = url.storyID
    </cfquery>

    <cfquery name="qSetFeature">
        update MediaTbl
        set FeatureMedia = 1
        where MediaID = url.mediaID
    </cfquery>
</body>

</html>