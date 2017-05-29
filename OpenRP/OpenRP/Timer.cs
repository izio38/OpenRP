using System;
using System.Drawing;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;

namespace OpenRP
{
	public class Timer
	{
		public void Run()
		{
			Timer_1sec();
		}

		double timer_1sec;
		public void Timer_1sec()
		{
			if (Game.GameTime - timer_1sec >= 1000) //Exécuté chaque seconde, 1000ms = 1 sec | Si la différence entre GameTime et timer_1sec est plus grande, le code s'exécute.
			{
				timer_1sec = Game.GameTime; //GameTime est un timer incrémenté chaque ms | On stock la nouvelle valeur de GameTime
			}
		}
	}
}
