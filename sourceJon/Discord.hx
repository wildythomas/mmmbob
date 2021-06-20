package;
//bitcoiner
#if windows
import Sys.sleep;
import discord_rpc.DiscordRpc;

using StringTools;

class DiscordClient
{
	public function new()
	{
		trace("bitcoiner");
		DiscordRpc.start({
			clientID: "852943859922370570", // change this to what ever the fuck you want lol852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758852931205794889758
			onError: onError,
			onDisconnected: onDisconnected
		});
		trace("bitcoiner");
		while (true)
		{
			DiscordRpc.process();
			sleep(2);
			//trace("Discord Client Update");
		}
		DiscordRpc.shutdown();
	}

	public static function shutdown()
	{
		DiscordRpc.shutdown();
	}
	static function onReady()
	{
		DiscordRpc.presence({
			details: "In the Menus",
			state: null,
			largeImageKey: 'largeimagekey',
			largeImageText: "mmmmbob"
		});
	}

	static function onError(_code:Int, _message:String)
	{
		trace('Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		trace('Disconnected! $_code : $_message');
	}

	public static function initialize()
	{
		var DiscordDaemon = sys.thread.Thread.create(() ->
		{
			new DiscordClient();
		});
		trace("Discord Client initialized");
	}

	public static function changePresence(details:String, state:Null<String>, ?smallImageKey : String, ?hasStartTimestamp : Bool, ?endTimestamp: Float)
	{
		var startTimestamp:Float = if(hasStartTimestamp) Date.now().getTime() else 0;

		if (endTimestamp > 0)
		{
			endTimestamp = startTimestamp + endTimestamp;
		}

		DiscordRpc.presence({
			details: details,
			state: state,
			largeImageKey: 'largeimagekey',
			largeImageText: "mmmmbob",
			smallImageKey : smallImageKey,
			// Obtained times are in milliseconds so they are divided so Discord can use it
			startTimestamp : Std.int(startTimestamp / 1000),
            endTimestamp : Std.int(endTimestamp / 1000)
		});

		//trace('Discord RPC Updated. Arguments: $details, $state, $smallImageKey, $hasStartTimestamp, $endTimestamp');
	}
}
#end