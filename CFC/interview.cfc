<cfcomponent>

    <cffunction name="getInterview" access="remote" returnFormat="json" output="false">
        <cfquery name="qInterview">
            Select InterviewTbl.InterviewID, trim(InterviewTbl.IntQuestion), InterviewCatTbl.IntCategory
            from InterviewTbl
            left join InterviewCatTbl
            on InterviewTbl.IntCategory = InterviewCatTbl.InterviewCatID
            order by
            InterviewTbl.IntCategory, InterviewTbl.IntQuestion
        </cfquery>
        <cfreturn qInterview>

    </cffunction>

</cfcomponent>