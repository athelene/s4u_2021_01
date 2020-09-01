<cfcomponent>

    <cffunction name="getTradition" access="remote" returnFormat="json" output="false">
        <cfquery name="qTradition">
            Select TraditionTypeID, trim(TraditionName)
            from TraditionTypeTbl
            order by
            TraditionName
        </cfquery>
        <cfreturn qTradition>
    </cffunction>

</cfcomponent>