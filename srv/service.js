const { Genre } = require('#cds-models/tutorial/db')
const cds = require('@sap/cds')
const req = require('express/lib/request')

module.exports = class BookstorageService extends cds.ApplicationService {
  init() {

    const { Books } = cds.entities('BookstorageService')

    this.on("addDiscount", async () => {
      await UPDATE(Books).set({ price: { func: 'ROUND', args: [{ xpr: [{ ref: ['price'] }, '*', { val: 0.9 }] }, { val: 2 }] } })
    })

    this.on("AddStock", Books, async (req) => {
      const bookID = req.params[0].ID
      await UPDATE(Books).set({ stock: { '+=': 1 } }).where({ ID: bookID })
    })

    this.on("ChangePublishDate", Books, async (req) => {
      const bookID = req.params[0].ID
      const newDate = req.data.newDate
      await UPDATE(Books).set({ publishedAt: newDate }).where({ ID: bookID })
    })

    this.on("ChangeStatus", Books, async (req) => {
      const bookID = req.params[0].ID
      const newStatus = req.data.newStatus
      await UPDATE(Books).set({ status_code: newStatus }).where({ ID: bookID })
    })

    this.before('READ', Books, async (req) => {
      console.log('Before READ Books', req.data)
    })

    this.on('READ', Books, async (req, next) => {
      console.log('ON EVENT')
      return next()
    })

    this.after('READ', Books, async (books, req) => {
      for (const book of books) {
        if (book.genre_code == Genre.Art)
          book.price = book.price * 0.8
      }
      console.log('AFTER READ')
    })

    const { Authors } = cds.entities('BookstorageService')

    this.after('READ', Authors, async (authors) => {
      const ids = authors.map(author => author.ID)
      const bookCounts = await SELECT.from(Books)
        .columns('author_ID', { func: 'count' })
        .where({ author_ID: { in: ids } })
        .groupBy('author_ID');
      for (const author of authors) {
        const bookCount = bookCounts.find(bookCount => bookCount.author_ID = author.ID)
        author.bookCounts = bookCount.count
      }
      console.log(bookCounts) 
    })

    return super.init()
  }
}
