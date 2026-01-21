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
);

