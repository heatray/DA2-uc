class da_BrowserFilters extends BrowserFilters;


// Create all filter classes
function InitCustomFilters()
{
	local int i;
	local CustomFilter Temp;
	local array<string> CustomFilterNames;

	if ( AllFilters.Length > 0 )
		AllFilters.Remove(0, AllFilters.Length);

	if (FilterClass == None)
		FilterClass = class<CustomFilter>(DynamicLoadObject(CustomFilterClass, class'Class'));

	if (FilterClass == None)
	{
		Warn("Invalid custom filter class specified:"@CustomFilterClass);
		bInvalidFilterClass = True;
		return;
	}

	// Restore any filters that were deleted (would happen if filters were deleted, but changes weren't applied)
	for ( i = 0; i < Deleted.Length; i++ )
		Deleted[i].Save(True);

	if ( Deleted.Length > 0 )
		Deleted.Remove(0, Deleted.Length);


	CustomFilterNames = GetPerObjectNames( "DA2ServerFilters", GetItemName(CustomFilterClass) );
	for (i = 0; i < CustomFilterNames.Length && i < 1000; i++)
	{
		Temp = CreateFilter( CustomFilterNames[i] );
		AllFilters[AllFilters.Length] = Temp;
	}
}

defaultproperties
{
     CustomFilterClass="DA2.da_CustomFilter"
}
