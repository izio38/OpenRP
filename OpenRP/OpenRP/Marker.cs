using System;
using System.Drawing;
using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;

namespace OpenRP
{
	public class Marker
	{
		public void OnTick()
		{
			Ped playerPed = Game.PlayerPed;
			Spawn(playerPed);
		}

		public void Spawn(Ped playerPed)
		{
			for (int i = 0; i < pos.Length; i++)
			{
				if (Vector3.Distance(pos[i], playerPed.Position) < 50) //On n'affiche pas de marker si un joueur n'est pas à proximité 
				{
					/*
					MarkerType = L'icône
					Vector3 n°1 = La Position
					Vector3 n°2 = La Direction
					Vector3 n°3 = L'Orientation
					Vector3 n°4 = La Taille
					Le Color = La couleur Alpha, Rouge, Vert, Bleu
					True n°1 = Bobup, l'icône est animée de haut en bas
					True n°2 = L'icône est toujours dirigée vers la camera du joueur
					false n°1 = Rotation sur l'axe Y
					false n°2 = l'icône est t'elle sur une entité
					*/
					World.DrawMarker(MarkerType.PlaneModel, new Vector3(pos[i].X, pos[i].Y, pos[i].Z), new Vector3(0f, 0f, 0f), new Vector3(0f, 0f, 0f), new Vector3(0.75f, 0.75f, 0.75f), Color.FromArgb(255, 255, 255, 255), true, true, false, "", "", false);
				}
			}
		}

		public static Vector3[] pos = //On indique les coords pour les markers XYZ
		{
		new Vector3(10f, 10f, 10f),
		new Vector3(10f, 10f, 10f)
	};
}
