using {tutorial.db as db} from '../db/schema';

service BookstorageService {
    entity Books      as projection on db.Books;
    entity Authors    as projection on db.Authors;
    entity Chapters   as projection on db.Chapters;
    entity BookStatus as projection on db.BookStatus;
    entity Genres as projection on db.Genres;
}

annotate BookstorageService.Books with @odata.draft.enabled;
