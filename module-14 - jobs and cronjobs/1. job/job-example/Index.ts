
import { MongoClient } from "mongodb";

import request from "request-promise"
const connectionString = `mongodb://${process.env.MONGO_URL || "localhost:27017"}`;

(async () => {
    console.log('connectionString', connectionString)
    const connection = await MongoClient.connect(connectionString);
    console.log("mongo db is running");
    const db = connection.db("heroes").collection("people");
    await db.remove({})

    const promises = []
    for (let i = 1; i <= 100; i++) {
        try {

            const url = `https://swapi.co/api/people/${i}`;
            console.log('trying', url)
            const results = await request(url)
            const data = JSON.parse(results)
            console.log(`name ${data.name}`)
            const item = Object.assign({}, data, { index: i, insertedAt: new Date() })
            promises.push(db.insert(item))
        }
        catch (e) {
            if (e.statusCode === 404) break;

            throw e
        }
    }
    await Promise.all(promises)
    console.log('job finished');
    process.exit(0);
})();
