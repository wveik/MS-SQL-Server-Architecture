CREATE TYPE cfg.[intTable] AS TABLE(
    [id] [int],
	name_tbl [varchar](64) NULL,
	desc_rbl [varchar](1024) NULL
)

CREATE PROCEDURE cfg.spProc
    @ids cfg.intTable READONLY
AS
BEGIN
SELECT * FROM @ids t
where t.name_tbl is not null
  --  SELECT [treenodedetailid]
  --    ,[treecnodeid_r]
  --    ,[treenodedetailfield]
  --    ,[treenodedetailcaption]
  --    ,[treenodedetailsize]
  --    ,[treenodedetailorder]
  --    ,[treenodedetailvisible]
  --    ,[treenodedetaildeteted]
  --FROM [UNIVERS].[cfg].[treenodedetail]
  --  WHERE [treenodedetailid] IN(SELECT id FROM @ids)
END

private void button1_Click(object sender, EventArgs e)
        {
            List<int> ids = new List<int>() { 1, 2, 3, 4, 5 };
            DataTable data = new DataTable();
            data.Columns.Add("id", typeof(int));
            data.Columns.Add("name_tbl", typeof(string));
            data.Columns.Add("desc_rbl", typeof(string));
            int count = 0;
            foreach (var r in ids)
            {
                DataRow row = data.NewRow();
                row["id"] = r;
                if (++count != 2)
                {
                    row["name_tbl"] = "name_tbl: " + r;
                    row["desc_rbl"] = "desc_rbl: " + r;
                }
                data.Rows.Add(row);
            }
            using (var conn = new SqlConnection("Data Source=server-052;Initial Catalog=UNIVERS;User ID=Fast_r;Password=fast2018"))
            {
                conn.Open();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "cfg.spProc";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ids", SqlDbType.Structured);
                    cmd.Parameters["@ids"].TypeName = "cfg.intTable";
                    cmd.Parameters["@ids"].Value = data;
                    using (var da = new SqlDataAdapter(cmd))
                    {
                        var dt = new DataTable();

                        da.Fill(dt);
                        gridControl1.DataSource = dt;
                    }
                }
            }
        }