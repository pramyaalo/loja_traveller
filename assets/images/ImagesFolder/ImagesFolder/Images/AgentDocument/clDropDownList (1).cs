using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for clDropDownList
/// </summary>
public class clDropDownList
{
    private int FinanceYearId;
    private int MemberId;
    private int UserTypeId;



    public clDropDownList(int FinanceYearId, int MemberId, int UserTypeId)
    {
        this.FinanceYearId = FinanceYearId;
        this.MemberId = MemberId;
        this.UserTypeId = UserTypeId;
    }

    public List2ddl[] GetAdminUsers()
    {
        List<List2ddl> MyData = new List<List2ddl>();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("AdminUserddl", con);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        con.Open();
        SqlDataAdapter adpt = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@MemberId", MemberId);
        DataSet ds = new DataSet();
        adpt.Fill(ds);
        DataTable dt = ds.Tables[0];
        //List2ddl objj = new List2ddl();
        //objj.Id = 0;
        //objj.Name = "-- Select User --";
        //MyData.Add(objj);

        for (var i = 0; i < dt.Rows.Count; i++)
        {
            List2ddl obj = new List2ddl();
            obj.Id = Convert.ToInt32(dt.Rows[i]["Id"]);
            obj.Name = Convert.ToString(dt.Rows[i]["Name"]);
            MyData.Add(obj);
        }
        return (MyData.ToArray());
    }

    public List2ddl[] GetDesignations(int DesignationId)
    {
        List<List2ddl> MyData = new List<List2ddl>();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Designationddl", con);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        con.Open();
        SqlDataAdapter adpt = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@DesignationId", DesignationId);
        DataSet ds = new DataSet();
        adpt.Fill(ds);
        DataTable dt = ds.Tables[0];
        List2ddl objj = new List2ddl();
        objj.Id = 0;
        objj.Name = "-- Select tDesignations --";
        MyData.Add(objj);

        for (var i = 0; i < dt.Rows.Count; i++)
        {
            List2ddl obj = new List2ddl();
            obj.Id = Convert.ToInt32(dt.Rows[i]["Id"]);
            obj.Name = Convert.ToString(dt.Rows[i]["Name"]);
            MyData.Add(obj);
        }
        return (MyData.ToArray());
    }

    public List2ddl[] GetStaff(int StaffId)
    {
        List<List2ddl> MyData = new List<List2ddl>();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("StaffDetailsddl", con);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        con.Open();
        SqlDataAdapter adpt = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@StaffId", StaffId);
        DataSet ds = new DataSet();
        adpt.Fill(ds);
        DataTable dt = ds.Tables[0];
        List2ddl objj = new List2ddl();
        objj.Id = 0;
        objj.Name = "-- Select Staff --";
        MyData.Add(objj);

        for (var i = 0; i < dt.Rows.Count; i++)
        {
            List2ddl obj = new List2ddl();
            obj.Id = Convert.ToInt32(dt.Rows[i]["Id"]);
            obj.Name = Convert.ToString(dt.Rows[i]["Name"]);
            MyData.Add(obj);
        }
        return (MyData.ToArray());
    }
    public List2ddl[] GetPackage(string PackageType)
    {
        List<List2ddl> MyData = new List<List2ddl>();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Packagesddl", con);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        con.Open();
        SqlDataAdapter adpt = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@PackageType", PackageType);
        cmd.Parameters.AddWithValue("@UserTypeId", UserTypeId);
        DataSet ds = new DataSet();
        adpt.Fill(ds);
        DataTable dt = ds.Tables[0];
        List2ddl objj = new List2ddl();
        objj.Id = 0;
        objj.Name = "-- Select Package --";
        MyData.Add(objj);

        for (var i = 0; i < dt.Rows.Count; i++)
        {
            List2ddl obj = new List2ddl();
            obj.Id = Convert.ToInt32(dt.Rows[i]["Id"]);
            obj.Name = Convert.ToString(dt.Rows[i]["Name"]);
            MyData.Add(obj);
        }
        return (MyData.ToArray());
    }

    public List2ddl[] GetLeavType()
    {
        List<List2ddl> MyData = new List<List2ddl>();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Leavetypesddl", con);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        con.Open();
        SqlDataAdapter adpt = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@LeavetypesId", 0);
        DataSet ds = new DataSet();
        adpt.Fill(ds);
        DataTable dt = ds.Tables[0];
        List2ddl objj = new List2ddl();
        objj.Id = 0;
        objj.Name = "-- Select Leavetype --";
        MyData.Add(objj);

        for (var i = 0; i < dt.Rows.Count; i++)
        {
            List2ddl obj = new List2ddl();
            obj.Id = Convert.ToInt32(dt.Rows[i]["Id"]);
            obj.Name = Convert.ToString(dt.Rows[i]["Name"]);
            MyData.Add(obj);
        }
        return (MyData.ToArray());
    }


    public string[] CustomerAutoComplete() 
    {
        List<string> objList = new List<string>();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Customersddl", con);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserTypeId", UserTypeId);
        con.Open();
        SqlDataAdapter adpt = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adpt.Fill(ds);
        DataTable dt = ds.Tables[0];

        for (var i = 0; i < dt.Rows.Count; i++)
        {
            objList.Add(string.Format("{0}-{1}-{2}", dt.Rows[i]["Name"], dt.Rows[i]["Id"], dt.Rows[i]["Customername"]));
        }

        return (objList.ToArray());

    }

    public string[] EPinAutoComplete()
    {
        List<string> objList = new List<string>();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Pinsddl", con);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserTypeId", UserTypeId);
        con.Open();
        SqlDataAdapter adpt = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        adpt.Fill(ds);
        DataTable dt = ds.Tables[0];

        for (var i = 0; i < dt.Rows.Count; i++)
        {
            objList.Add(string.Format("{0}-{1}", dt.Rows[i]["Name"], dt.Rows[i]["Id"]));
        }

        return (objList.ToArray());

    }
    public List2ddl[] GetAllTypeUsers(int UserTypeId)
    {
        List<List2ddl> MyData = new List<List2ddl>();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("AllUserddl", con);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        con.Open();
        SqlDataAdapter adpt = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@UserTypeId", UserTypeId);
        DataSet ds = new DataSet();
        adpt.Fill(ds);
        DataTable dt = ds.Tables[0];
        //List2ddl objj = new List2ddl();
        //objj.Id = 0;
        //objj.Name = "-- Select User --";
        //MyData.Add(objj);

        for (var i = 0; i < dt.Rows.Count; i++)
        {
            List2ddl obj = new List2ddl();
            obj.Id = Convert.ToInt32(dt.Rows[i]["Id"]);
            obj.Name = Convert.ToString(dt.Rows[i]["Name"]);
            MyData.Add(obj);
        }
        return (MyData.ToArray());
    }




}