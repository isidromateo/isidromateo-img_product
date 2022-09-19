using com.logali as logali from '../db/schema';
using com.training as training from '../db/training';

// service CatalogService {
//     entity Products       as projection on logali.materials.Products;
//     entity Suppliers      as projection on logali.sales.Suppliers;
//     entity UnitOfMeasures as projection on logali.materials.UnitOfMeasures;
//     entity Currency       as projection on logali.materials.Currencies;
//     entity DimensionUnits as projection on logali.materials.DimensionUnits;
//     entity Category       as projection on logali.materials.Categories;
//     entity Salesdata      as projection on logali.sales.SalesData;
//     entity Reviews        as projection on logali.materials.ProductReview;
//     entity Student        as projection on training.school.Student;
//     entity Course         as projection on training.school.Course;
//     entity StudentCourse  as projection on training.school.StudentCourse;
//     entity Orders         as projection on logali.sales.Orders
//    entity OrderItems     as projection on logali.sales.OrderItems
//}
define service CatalogService {

    entity Products          as
        select from logali.materials.Products {
            ID,
            name as ProductName @mandatory,
            Description         @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price               @mandatory,
            Height,
            Width,
            Depth,
            *,
        //     Quantity                          @(mandatory @assert.range,
        //     UnitOfMeasures as ToUnitOfMeasure @mandatory,
        //     Currency       as ToCurrency      @mandatory,
        //     Category       as ToCategory      @mandatory,
        //     Category.name  as Category        @mandatory,
        //     DimensionUnits as ToDimensioUnit,
        //     SalesData,
        //     Supplier,
        //     Reviews
        //   Rating,
        //   StockAvailability,
        //   ToStockAvailibilty
        };

    entity Supplier          as
        select from logali.sales.Suppliers {
            ID,
            name,
            Email,
            Phone,
            Fax,
            Products as ToProduct
        };

    @readonly
    entity Reviews           as
        select from logali.materials.ProductReview {
            ID,
            name,
            Rating,
            Comment,
            createdAt,
            Products as ToProduct
        };

    @readonly
    entity SalesData         as
        select from logali.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Product_id,
            Currency1,
            DeliveryMonth1,
            //          Currency.id               as CurrencyKey,
            //          DeliveryMonth.id          as DeliveryMonthId,
            //          DeliveryMonth.Description as DeliveryMonth,
            Products as ToProduct


        };

    @readonly
    entity StockAvailability as
        select from logali.materials.StockAvailability {
            id,
            Description,
            Products as ToProduct
        };

    @readonly
    entity VH_Categories     as
        select from logali.materials.Categories {
            id   as Code,
            name as Text

        };

    @readonly
    entity VH_Currencies     as
        select from logali.materials.Currencies {
            id          as Code,
            Description as Text

        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from logali.materials.UnitOfMeasures {
            id          as Code,
            Description as Text

        };

    @readonly
    entity VH_DimensionUnits as
        select
            id          as Code,
            Description as Text
        from logali.materials.DimensionUnits;
}

define service MyService {
    entity SuppliersProduct as
        select from logali.materials.Products[name = 'Vint soda']{
            *,
            name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = 98052;

    entity SuppliersToSales as
        select
            Supplier.Email,
            Supplier.createdAt,
            Supplier.Phone,
            Supplier.name
        from logali.materials.Products[name = 'Vint soda'];

    entity EntityInfix      as
        select Supplier[name = 'Tokyo Traders2'].Phone from logali.materials.Products
        where
            Products.name = 'Vint soda';

    entity Entityjoin       as
        select Phone from logali.materials.Products
        left join logali.sales.Suppliers as supp
            on(
                supp.ID = Products.Supplier.ID
            )
            and supp.name = 'Tokyo Traders2'
        where
            Products.name = 'Vint soda';

}

define service reports {
    entity AverageRating as projection on logali.reports.AverageRating;

    entity EntityCasting as
        select
            cast(Price as Integer) as Price,
            Price                  as Price2 : Integer
        from logali.materials.Products;

    entity EntityExists as
    select from logali.materials.Products {
        name
    } where exists Supplier[name = 'Tokyo Traders2'];

}
