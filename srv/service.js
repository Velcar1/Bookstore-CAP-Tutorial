const { Genre } = require('#cds-models/tutorial/db')
const cds = require('@sap/cds')
const req = require('express/lib/request')

module.exports = class BookstorageService extends cds.ApplicationService { init() {

  const { Books } = cds.entities('BookstorageService')

  this.before ('READ', Books, async (req) => {
    console.log('Before READ Books', req.data)
  })

  this.on ('READ',Books, async (req, next) => {
    console.log('ON EVENT')
    return next()
  })

  this.after ('READ', Books, async (books, req) => {
    for (const book of books) {
      if (book.genre_code == Genre.Art)
        book.price = book.price * 0.8
    }
    console.log('AFTER READ')
  })
  

  return super.init()
}}
