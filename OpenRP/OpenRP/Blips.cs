using System;
using System.Drawing;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;

namespace OpenRP
{
	public class Blips
	{
		public void Spawn()
		{
			for (int i = 0; i < pos.Length; i++)
			{
				var blip = World.CreateBlip(pos[i]);
				blip.Sprite = BlipSprite.AmmuNation; //Le sprite de l'icône
				blip.Color = BlipColor.White; //La Couleur
				blip.Scale = 1f; //La Taille
				blip.IsShortRange = true; // On affiche l'icône, uniquement quand elle rentre dans la minimap
				blip.Name = "Nom du Blip";
			}
		}
		public static Vector3[] pos = // on indique les coords pour les blips XYZ
		{
			new Vector3(10f, 10f, 10f),
			new Vector3(10f, 10f, 10f)
		};
	}
}
