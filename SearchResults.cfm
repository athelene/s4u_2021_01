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
</head>

<cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
<cfajaxproxy cfc="cfc.Search" jsclassname="Search" />

<!--HTML-->

<cfinclude template="/TopNavSmall.cfm">
<div class="col-md-10 offset-md-1">
    <h2 class="h2-responsive">Search results for:
        <strong>
            <cfoutput>#form.searchTerm#</cfoutput><BR>
            <cfset trimTerm = rereplace(trim(form.searchTerm),"[^0-9A-Za-z ]","","all") />
            <cfoutput>#trimTerm#</cfoutput><BR>    
        </strong>
    </h2><BR>
    <div ID="PageDiv">

    </div>
    <BR>
    <div ID="BookDiv">

    </div>


    <BR><BR><BR><BR><BR>

</div>
    <cfinclude template="/FooterMobile.cfm">
        <!-- JQuery -->
        <script type="text/javascript" src="/js/jquery.min.js"></script>
        <!-- Bootstrap tooltips -->
        <script type="text/javascript" src="/js/popper.min.js"></script>
        <!-- Bootstrap core JavaScript -->
        <script type="text/javascript" src="/js/bootstrap.min.js"></script>
        <!-- MDB core JavaScript -->
        <script type="text/javascript" src="/js/mdb.min.js"></script>

        <!-- Optional JavaScript -->
        <script type="text/javascript" src="/js/search.js"></script>
        <script type="text/javascript" src="/js/badgeUpdates.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {

                        $(function () {
                            $(".sticky").sticky({
                                topSpacing: 90,
                                zIndex: 2,
                                stopper: "#YourStopperId"
                            });
                        });

                        $('.mdb-select').materialSelect();

                        // MDB Lightbox Init
                        $(function () {
                            $("#mdb-lightbox-ui").load("mdb-addons/mdb-lightbox-ui.html");
                        });

                        getSearchPages(<cfoutput>#session.UserID#,'#trimTerm#'</cfoutput>);
                        getSearchBooks(<cfoutput>#session.UserID#,'#trimTerm#'</cfoutput>);
                        newPages(<cfoutput>#session.userid#,'#session.LastPageView#',
                                        '#session.LastBookView#',
                                        '#session.LastTCView#'</cfoutput>);
                                        // End of document ready
                                    });
        </script>


        </body>

</html>