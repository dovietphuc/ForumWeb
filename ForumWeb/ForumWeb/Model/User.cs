using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ForumWeb.Model
{
    public class User
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Fullname { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public DateTime CreateTime { get; set; }
        public string Avatar { get; set; } = "Image/emptyAvatar.jpg";
    }
}