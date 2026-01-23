using BookstorageService as service from '../../srv/service';
annotate service.Authors with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'name',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Detalles',
            ID : 'aaa',
            Target : '@UI.FieldGroup#aaa',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Books Information',
            ID : 'BooksInformation',
            Target : '@UI.FieldGroup#BooksInformation',
        },
    ],
    UI.FieldGroup #aaa : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
                Label : 'name',
            },
        ],
    },
    UI.FieldGroup #BooksInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : bookCounts,
                Label : 'bookCounts',
            },
        ],
    },
);

