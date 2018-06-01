import * as Hapi from "hapi";
import * as Joi from "joi";
import { MongoClient } from "mongodb";

const Inert = require("inert");
const Vision = require("vision");
const HapiSwagger = require("hapi-swagger");
const server = new Hapi.Server();
const port = process.env.PORT || 3000;
server.connection({ port });

(async () => {
  const connectionString = `mongodb://${process.env.MONGO_URL ||
    "localhost"}/heroes`;
  const connection = await MongoClient.connect(connectionString);
  console.log("mongo db is running");
  const db = connection.db("heroes").collection("hero");
  await server.register([
    Inert,
    Vision,
    {
      register: HapiSwagger,
      options: {
        info: {
          title: "Node.js with MongoDB Example - Erick Wendel",
          version: "1.0"
        }
      }
    }
  ]);

  server.route([
    {
      method: "GET",
      path: "/heroes",
      config: {
        handler: (req: any, reply: any) => {
          return reply(db.find().toArray());
        },
        description: "List All heroes",
        notes: "heroes from database",
        tags: ["api"]
      }
    },
    {
      method: "POST",
      path: "/heroes",
      config: {
        handler: (req, reply) => {
          const { payload } = req;
          return reply(db.insert(payload));
        },
        description: "Create a hero",
        notes: "create a hero",
        tags: ["api"],
        validate: {
          payload: {
            name: Joi.string().required(),
            power: Joi.string().required()
          }
        }
      }
    },

    {
      method: "DELETE",
      path: "/heroes/{id}",
      config: {
        handler: (req, reply) => {
          return reply(db.remove({ _id: req.params.id }));
        },
        description: "Delete a hero",
        notes: "Delete a hero",
        tags: ["api"],
        validate: {
          params: {
            id: Joi.string().required()
          }
        }
      }
    }
  ]);

  await server.start();
  console.log("server running at", port);
})();
