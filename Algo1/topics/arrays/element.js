function elementVan(x, verzameling)
{
    for ( var i = 0; i !== verzameling.length; ++i )
    {
        if ( verzameling[i] === x )
        {
            return true;
        }
    }

    return false;
}
