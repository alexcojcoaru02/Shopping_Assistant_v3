﻿using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson;

namespace ShoppingAssistant.Api.Models
{
    public class User
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string Email { get; set; }

        public string Password { get; set; }

        public string PhoneNumber { get; set; }

        public List<UserRole> Roles { get; set; }
    }

    public enum UserRole
    {
        Admin,
        Customer,
        Employee
    }
}


