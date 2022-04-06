﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using SLBFE_API.Models;

namespace SLBFE_API.Controllers
{
    [Route("complaints")]
    [ApiController]
    public class ComplainsController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public ComplainsController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet,Route("getnewcomplaintlist")]
        public JsonResult GetNewComplaintList()
        {
            string query = @"SELECT * FROM [dbo].[JS_COMPLAINS] WHERE Feedback = 'No Feedback'";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult(table);
        }

        [HttpGet, Route("getoldcomplaintlist")]
        public JsonResult GetOldComplaintList()
        {
            string query = @"SELECT * FROM [dbo].[JS_COMPLAINS] WHERE Feedback != 'No Feedback'";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult(table);
        }

        [HttpPut,Route("sendfeedback")]
        public JsonResult PutFeedback(int complaintId, String feedback)
        {
            string query = @"UPDATE [dbo].[JS_COMPLAINS] SET Feedback = '" + feedback + "' WHERE ComplaintID =" + complaintId;
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult("Updated Successfully");
        }


        [HttpPost,Route("addcomplaint")]
        public JsonResult PostComplaint(JsComplain comp)
        {
            string query = @"insert into [dbo].[JS_COMPLAINS] values(@JS_NIC,@Complain,@Feedback)";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    //myCommand.Parameters.AddWithValue("@NIC", comp.JsNicNavigation);
                
                    myCommand.Parameters.AddWithValue("@JS_NIC", comp.JsNic);
                    myCommand.Parameters.AddWithValue("@Complain", comp.Complain);
                    myCommand.Parameters.AddWithValue("@Feedback", comp.Feedback);
                    
                   
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult("Added Successfully");
        }

    }

    
}
