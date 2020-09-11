const faker = require('faker')

// console.log(faker)

const to_str = value => `'${value}'`

Array(20).fill(0).forEach((_, idx) => {
  let dataArr = [idx, to_str(faker.name.findName()), to_str(faker.internet.password()), to_str(faker.name.findName()), to_str(faker.date.future().toISOString().split('.')[0])]
  console.log(`(${dataArr.join()}),`)
})
