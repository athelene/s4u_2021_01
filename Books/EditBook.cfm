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

    <cfajaxproxy cfc="cfc.Notify" jsclassname="Notify" />
    <cfajaxproxy cfc="cfc.excBk" jsclassname="excBk" />
    <cfajaxproxy cfc="cfc.memBook" jsclassname="memBook" />
    <cfajaxproxy cfc="cfc.addBK" jsclassname="AddBK" />

    <cfset session.todayis=#DateTimeFormat(Now(),"YYYY-MM-DD HH:MM:ss")# />

    <!--- Start Nav --->
    <cfinclude template="/TopNavSmall.cfm">

        <cfquery name="qEditBook">
            Select * from BookTbl
            where BookID = #session.BookID# and BookOwner = #session.userid#
        </cfquery>

        <cfquery name="qGetCircles">
            Select * from CircleTbl
            where CircleOwner = #session.Userid#
            Order By CircleSort
        </cfquery>
        <!--- div1 --->
        <div>
            <H2>
                <cfif len(qEditbook.TimeCapsuleDate)>
                    Make Changes to Your Time Capsule
                    <cfelse>
                        Make Changes to Your Book
                </cfif>
            </h2>
        </Div>
        <!--- end of div1 --->

        <form action="/Books/EditBookAction.cfm" name="simpleAJAX" enctype="multipart/form-data" method="post"
            id="EditBookForm">

            <h4>Book Title:</h4>
            <input class="s4uTextArea form-control" type="text" name="BookTitle"
                value="<cfoutput>#trim(qEditBook.BookTitle)#</cfoutput>" /><br />

            <input type=hidden name="BookID" value="<cfoutput>#qEditBook.BookID#</cfoutput>" />
            <BR />

            <!--- Switch  --->
            <!---         TC Div --->
            <div class="switch">

                <cfif qEditBook.TimeCapsuleDate IS "">
                    <label>
                        Is this a time capsule?
                        <input type="checkbox" name="tcCheckbox" />
                        <span class="lever"></span>
                    </label>
                    <!--- TC Date  --->
                    <div class="md-form ml-0 mr-0">
                        <label id="tcLabel" class="ml-0 invisible">Enter The date you want to release this time capsule.
                            <input type="date" id="TimeCapsule" name="TimeCapsuleDate" value=""
                                class="form-control form-control-sm validate ml-0 invisible" />
                        </label>
                    </div>
                    <!---  end of TC Date --->
                    <cfelse>
                        <label>
                            Is this a time capsule?
                            <input type="checkBox" checked name="tcCheckbox" />
                            <span class="lever"></span>
                        </label>

                        <cfset tcdate='#qEditBook.TimeCapsuleDate#' />
                        <!---             TC Date alternative --->
                        <div class="md-form ml-0 mr-0">
                            <Label for="TimeCapsule" id="tcLabel">
                                Enter the date to release your time capsule:</label><BR>
                            <input type="date" id="TimeCapsule" name="TimeCapsuleDate"
                                value="<cfoutput>#tcdate#</cfoutput>"
                                class="form-control form-control-sm validate ml-0 visible" />

                        </div>
                        <!---             end of TC Date alternative --->
                </cfif>

            </div>
            <!---         end of TC Div --->
            <br />
            <br />
            <br />
            <br />
            <h4>Share with: </h4>
            <select class="mdb-select md-form dropdown-primary" name="CircleID" id="CircleID">
                <cfoutput>
                    <cfloop query="qGetCircles">
                        <option value="#qGetCircles.CircleID#" <cfif qGetCircles.CircleID EQ qEditBook.CircleID>Selected
                            </cfif>>
                            #qGetCircles.CircleName#
                        </option>
                    </cfloop>
                </cfoutput>
            </select>

            <cfinclude template="/circles/CircleExceptionsBk.cfm" />
            <!---     MemDiv for ajax --->
            <div id="MemDiv">

            </div>
            <!---     end of MemDiv --->


            <div class="text-center">

                <button class="btn btn-secondary btn-floating text-center" type="submit">
                    <i class="fas fa-check"></i>
                </button>

            </div>
        </form>
        <BR><BR><BR><BR><BR><BR><BR>
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
            <script type="text/javascript" src="/js/s4u.js"></script>
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

                            $('.switch input[type="checkbox"]').on('change', function () {
                                if (this.checked) {
                                    $("#TimeCapsule").removeClass("invisible");
                                    $("#tcLabel").removeClass("invisible");
                                } else {
                                    var str = $("#TimeCapsule").val();
                                    $("#TimeCapsule").addClass("invisible");
                                    $("#tcLabel").addClass("invisible");
                                };
                            });

                            // MDB Lightbox Init
                            $(function () {
                                $("#mdb-lightbox-ui").load("mdb-addons/mdb-lightbox-ui.html");
                            });

                            // Check Notifications
                            newPages( < cfoutput > #session.userid#, '#session.LastPageView#', '#session.LastBookView#',
                                '#session.LastTCView#' < /cfoutput>);

                                // End of document ready
                            });
            </script>


            </body>

</html>