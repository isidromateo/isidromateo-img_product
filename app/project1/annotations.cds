using CatalogService as service from '../../srv/catalog.service';

annotate service.Products with @(

                                 //  UI.SelectionFields : [
                                 //      To1Category_id,
                                 //      ToCurrency_id,
                                 //      StockAvailability_id
                                 //  ],

                               UI.LineItem : [
    {
        $Type : 'UI.DataField',
        Label : 'ProductName',
        Value : ProductName,
    },
    {
        $Type : 'UI.DataField',
        Label : 'Description',
        Value : Description,
    },
    {
        $Type : 'UI.DataField',
        Label : 'ImageUrl',
        Value : ImageUrl,
    },
    {
        $Type : 'UI.DataField',
        Label : 'ReleaseDate',
        Value : ReleaseDate,
    },
    {
        $Type : 'UI.DataField',
        Label : 'DiscontinuedDate',
        Value : DiscontinuedDate,
    },
]);

annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Label : 'ProductName',
                Value : ProductName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ImageUrl',
                Value : ImageUrl,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ReleaseDate',
                Value : ReleaseDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DiscontinuedDate',
                Value : DiscontinuedDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Price',
                Value : Price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Height',
                Value : Height,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Width',
                Value : Width,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Depth',
                Value : Depth,
            },
            {
                $Type : 'UI.DataField',
                Label : 'name',
                Value : ProductName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Quantity',
                Value : Quantity,
            },
            {
                $Type : 'UI.DataField',
                Label : 'UnitOfMeasures_id',
                Value : ToUnitOfMeasure_id,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Currency_id-Vamos nano',
                Value : moneda,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DimensionUnits_id',
                Value : ToDimensioUnit_id
            },
            {
                $Type : 'UI.DataField',
                Label : 'Category_id',
                Value : Category
            },
            {
                $Type : 'UI.DataField',
                Label : 'PriceCondition',
                Value : Price
            },
            {
                $Type : 'UI.DataField',
                Label : 'PriceDetermination',
                Value : Price
            },
        ],
    },
    UI.Facets                      : [{
        $Type  : 'UI.ReferenceFacet',
        ID     : 'GeneratedFacet1',
        Label  : 'General Information',
        Target : '@UI.FieldGroup#GeneratedGroup1',
    }, ]
);
