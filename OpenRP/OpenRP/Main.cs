/*
OpenRP is licensed under the
GNU General Public License v3.0

Permissions of this strong copyleft license are conditioned on making available complete source code of licensed works and modifications, 
which include larger works using a licensed work, under the same license. Copyright and license notices must be preserved. 
Contributors provide an express grant of patent rights.
*/

using System;
using System.Drawing;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;

namespace OpenRP
{
	public class Main : BaseScript
	{
		public Blips blips
		public Spawn spawn;
		public Timer timer;

		public Main()
		{
			blips = new Blips();
			spawn = new Spawn();
			timer = new Timer();
			Tick += OnTick; //Exécuter à chaque Tick du jeu

			EventHandlers["onClientMapStart"] += new Action<dynamic>(async (dynamic res) => //Quand l'évènement "onClientMapStart" est lancée, on récupere une variable dynamique res
			{
				await spawn.Run(PedHash.MPros01); //Le script devra attendre d'avoir fini d'exécuter la fonction de spawn
				blips.Spawn(); //On spawn les icônes sur la maps
				Function.Call(Hash.NETWORK_SET_TALKER_PROXIMITY, 15.001); //On limite la parole des joueurs localement
			});
		}

		public async Task OnTick()
		{
			timer.Run(); //On lance les différents Timers
		}
	}
}
