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
  <link rel="stylesheet" href="/assets/css/bootstrap.css">
  <link rel="stylesheet" href="/assets/css/index.css">  

<body>
  <cfif isDefined("url.InvNo")>
    <cfset referrer=url.InvNo>
      <cfelse>

        New sign up without referrral.
        <cflocation url="s4usignup.cfm">
  </cfif>
  <cfset session.errordup="">
    <form class="text-center p-5" enctype="multipart/form-data" method="post" action="/Users/NewSaltUser.cfm">
      <div class="note bg-primary">
        <P>
          Welcome to Stories For Us. We provide a place for the people closest to you to
          share your stories across generations. We'll help you capture the stories of the past,
          save the stories as they happen now and give you a way to reach out to people in the future.
          <BR><BR>
          We all have a story to share. Stories For Us will help you to share yours in a way that is fun and
          interesting - even if you've never been able to tell a story before. <BR><BR>

          Most importantly, we'll keep you connected with the people that matter most, without all the
          noise and stress of social media. <BR><BR>

          Watch this video for a quick look at how Stories For Us can keep you connected.
          <BR><BR>
        </P>
      </div>
      <!-- Email -->
      <h3> Enter the email your invitation was sent to:</h3><BR><BR>
      <input type="email" name="email" class="form-control mb-4" placeholder="Enter your email">
      <input type="hidden" name="sender" value="<cfoutput>#referrer#</cfoutput>">
      <button type="submit" class="btn btn-secondary">Get Started</button>
  </form>
</body>
<!-- JQuery -->
<script type="text/javascript" src="/js/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="/js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="/js/mdb.min.js"></script>

</html>