namespace com.logali;

using {
    cuid,
    managed
} from '@sap/cds/common';

define type name : String(50);

type Address {
    street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
}

type Dec : Decimal(16, 2);


//--------------------   CONTEXT MATERIALS  --------------------- //
context materials {

    entity Products : cuid, managed {
        name              : localized String not null;
        Description       : localized String;
        ImageUrl          : String;
        ReleaseDate       : Date default CURRENT_DATE;
        DiscontinuedDate  : DateTime;
        Price             : Dec; //Decimal(16, 2);
        Height            : type of Price; //Decimal(16, 2);
        Width             : Decimal(16, 2);
        Depth             : Decimal(16, 2);
        Quantity          : Decimal(16, 2);
        UnitOfMeasure   : Association to UnitOfMeasures;
        Currency        : Association to Currencies;
        Category        : Association to Categories;
        Supplier        : Association to sales.Suppliers;
        DimensionUnit   : Association to DimensionUnits;
        StockAvailability : Association to StockAvailability;
        SalesData         : Association to many sales.SalesData
                                on SalesData.Products = $self;
        Reviews           : Association to many ProductReview
                                on Reviews.Products = $self;
    //        Supplier_ID       : UUID;
    //        ToSupplier        : Association to one Suppliers
    //                                on ToSupplier.id = Supplier_ID;
    //        UnitOfMeasures_id : String(2);
    //        ToUnitOfMeasure   : Association to UnitOfMeasures
    //                                on ToUnitOfMeasure.id = UnitOfMeasures_id;
    };

    entity Categories {
        key id   : String(1);
            name : localized String;
    };


    entity StockAvailability {
        key id          : Integer;
            Description : localized String;
            Products    : Association to Products;
    };


    entity Currencies {
        key id          : String(3);
            Description : localized String;
    };


    entity UnitOfMeasures {
        key id          : String(2);
            Description : localized String;
    };


    entity DimensionUnits {
        key id          : String(2);
            Description : localized String;
    };


    entity ProductReview : cuid, managed {
        name     : name;
        Rating   : Integer;
        Comment  : String;
        Products : Association to Products;
    };

    //  SelProducts1
    //   ProjProducts,
    //    ProjProducts2,
    //    ProjProducts3,
    //    Products(extensión),

    entity SelProducts  as
        select from Products {
            *
        };

    entity SelProducts2 as
        select from Products {
            name,
            Price,
            Quantity,

        };

    entity SelProducts3 as
        select from Products
        left join ProductReview
            on Products.name = ProductReview.name
        {
            Rating,
            Products.name,
            sum(Price) as TotalPrice
        }
        group by
            Rating,
            Products.name
        order by
            Rating;
}

entity SelProducts   as select from materials.Products;
entity ProjProducts  as projection on materials.Products;

entity Projproducts2 as projection on materials.Products {
    *
}

entity ProjProducts3 as projection on ProjProducts {
    ReleaseDate,
    name
}

extend materials.Products with {
    PriceCondition     : String(2);
    PriceDetermination : String(3);

};


//--------------------   CONTEXT SALES  --------------------- //

context sales {

    entity Orders : cuid {
        Date     : Date;
        Customer : String;
        Item     : Composition of many OrderItems
                       on Item.Order = $self;

    };


    entity OrderItems : cuid {
        Order    : Association to Orders;
        Product  : Association to materials.Products;
        Quantity : Integer;
    };


    entity Suppliers : cuid, managed {
        name     : type of materials.Products : name; //String;
        Address  : Address;
        Email    : String;
        Phone    : String;
        Fax      : String;
        Products : Association to many materials.Products
                       on Products.Supplier_Id = $self;

    };


    entity Months {
        key id               : String(2);
            Description      : localized String;
            ShortDescription : localized String(3);
    };

    //SelProducts1
    //SelProducts2
    //SelProducts3
    entity SelProducts1 as
        select from materials.Products {
            *
        };

    entity SelProducts2 as
        select from materials.Products {
            name,
            Price,
            Quantity
        };

    entity SelProducts3 as
        select from materials.Products
        left join materials.ProductReview
            on Products.name = ProductReview.name
        {
            Rating,
            Products.name,
            sum(Price) as TotalPrice
        }
        group by
            Rating,
            Products.name
        order by
            Rating;


    entity SalesData : cuid, managed {
        DeliveryDate     : DateTime;
        Revenue          : Decimal(16, 2);
        Product_id       : UUID;
        Currency_id      : String(3);
        DeliveryMonth_id : Date;
        //    Currency_id      : Association to materials.Currencies;
        //    DeliveryMonth_id : Association to sales.Months;
        Products         : Association to materials.Products;

    };

}

//--------------------   REPORTS  --------------------- //
context reports {
    entity AverageRating as
        select from logali.materials.ProductReview {
            Products.ID as Product_id,
            avg(Rating) as AverageRating : Decimal(16, 2),
        }
        group by
            Products.ID;

    entity Products      as
        select from logali.materials.Products
        mixin {
            ToStockAvailibilty : Association to logali.materials.StockAvailability
                                     on ToStockAvailibilty.id = $projection.StockAvailability;
            ToAverageRating    : Association to AverageRating
                                     on ToAverageRating.Product_id = ID;
        }

        into {
            ToAverageRating.AverageRating as Rating,
            case
                when
                    Quantity >= 8
                then
                    3
                when
                    Quantity > 0
                then
                    2
                else
                    1
            end                           as StockAvailability : Integer,
            ToStockAvailibilty
        }

}


//Ajustar los nombres de los ficheros csv con los datos demo conforme al namespace y contexto de cada entidad.
