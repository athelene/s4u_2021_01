<cfif len(Form["selectedFile"])>


  <!--- Create Unique File Name --->
  <cfset setFileName=#CreateUUID()# />

  <cfoutput>session.mediatypeid: #session.MediaTypeID#


    <cfif directoryExists(setVideoDirectory)>
      directory exists
    </cfif>

    <cfswitch expression="#session.MediaTypeID#">
      <cfcase value="1">
        <cfif directoryExists(setVideoDirectory)>
          <cfset Session.MediaLoc=setVideoDirectory />
          <cfset session.shortLoc="/M_Video/" & tostring(session.UserID) />
          The video directory #setVideoDirectory# exists
          <cfelse>
            <cfset DirectoryCreate(setVideoDirectory) />
            I created the #setVideoDirectory#
            <cfset session.MediaLoc=setVideoDirectory />
            <cfset session.shortLoc="/M_Video/" & tostring(session.UserID) />
        </cfif>
      </cfcase>
      <cfcase value="2">
        <cfif directoryExists(setPhotoDirectory)>
          <cfset session.MediaLoc=setPhotoDirectory />
          <cfset session.shortLoc="/M_Photo/" & tostring(session.UserID) />
          The video directory #setVideoDirectory# exists
          <cfelse>
            <cfset DirectoryCreate(setPhotoDirectory)>
              <cfset session.MediaLoc=setPhotoDirectory />
              <cfset session.shortLoc="/M_Photo/" & tostring(session.UserID) />
              I created the #setVideoDirectory#
        </cfif>
      </cfcase>

      <cfcase value="3">
        <cfif directoryExists(setAudioDirectory)>
          <cfset session.MediaLoc=setAudioDirectory>
            <cfset session.shortLoc="/M_Audio/" & tostring(session.UserID) />
            The video directory #setVideoDirectory# exists
            <cfelse>
              <cfset DirectoryCreate(setAudioDirectory)>
                <cfset session.MediaLoc=setAudioDirectory>
                  <cfset session.shortLoc="/M_Audio/" & tostring(session.UserID) />
                  I created the #setVideoDirectory#
        </cfif>
      </cfcase>
      <CFDEFAULTCASE>
        <cfset session.MediaLoc="x" />
        we reached the default case
      </CFDEFAULTCASE>
    </cfswitch>

  </cfoutput>

  <cfelse>
</cfif>