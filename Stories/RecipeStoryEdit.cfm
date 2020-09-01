<cfoutput>#session.goToPage#</cfoutput>
<cfquery name=qGetRecipe>
  Select * from StoryTbl
  where storyID = #session.EditStoryRec# and UserID = #session.userid#
</cfquery>
<div>
  <div>
    <H2>
      Save a Recipe
    </h2>

  </Div>
  <cfform action="stories/SaveStory.cfm" enctype="multipart/form-data">

    <div>
      <input type="text" name="StoryTitle" placeholder="Page Title"><br>
      <H3>Ingredients:</h3>
      <textarea name="StoryIngredients" cols="100" rows="5"></textarea>
    </div>

    <div>
      <H3>Directions:</h3>
      <textarea name="StoryText" cols="100" rows="5"></textarea>
      <BR>
      <input type="checkbox" name="restricted" id="restricted"> <strong> Restrict Viewers</strong>
      <BR>
    </div>
    <div>
      <input type=hidden name="StoryTypeID" value="3">
      <input type="Submit" Name="SaveText" value="Save Recipe">
    </div>

  </cfform>
</div>