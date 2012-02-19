using System.Diagnostics;
using System.ServiceProcess;

namespace ServiceRunner
{
	public partial class ServiceAgent : ServiceBase
	{
		readonly string _command;

		public ServiceAgent()
		{
			InitializeComponent();
		}

		public ServiceAgent(string command)
		{
			_command = command;
		}

		protected override void OnStart(string[] args)
		{
			Process.Start(_command);
		}

		protected override void OnStop()
		{
		}
	}
}