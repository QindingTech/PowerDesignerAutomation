using QinDingTech.PowerDesignerHelper;
using System;

namespace PowerDesignerAutomation
{
	internal class Program
	{
		private static void Main(string[] args)
		{
			String pdmPath = @"D:\Projects\QinDingTech\wind-farm-one\0002-Design\DB\Privilege.pdm";
			//pdmPath.ToLower()
			PdmFileReader reader = new PdmFileReader();
			PdmModel model = reader.ReadFromFile(pdmPath);
			foreach (var tbl in model.Tables)
			{
				Console.WriteLine(tbl.Name);
				foreach (var col in tbl.Columns)
				{
					Console.WriteLine(col.ShowJpaColumnType());
				}
			    
			}
			Console.ReadKey();
            
		}
	}
}