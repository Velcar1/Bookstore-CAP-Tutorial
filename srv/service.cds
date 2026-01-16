using {tutorial.db as db} from '../db/schema';

service BookstorageService {
    entity Books      as projection on db.Books
        actions {
            action AddStock();
            action ChangePublishDate(newDate: Date);
            action ChangeStatus( @(Common: {
                                     ValueListWithFixedValues: true,
                                     Label : 'New status',
                                     ValueList               : {
                                         $Type         : 'Common.ValueListType',
                                         CollectionPath: 'BookStatus',
                                         Parameters    : [{
                                             $Type            : 'Common.ValueListParameterInOut',
                                             LocalDataProperty: newStatus,
                                             ValueListProperty: 'code',
                                         }, ],
                                     },
                                 }) newStatus: String);
        };

    entity Authors    as projection on db.Authors;
    entity Chapters   as projection on db.Chapters;
    entity BookStatus as projection on db.BookStatus;
    entity Genres     as projection on db.Genres;
}

annotate BookstorageService.Books with @odata.draft.enabled;
