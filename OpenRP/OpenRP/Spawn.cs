using System;
using System.Drawing;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;
using CitizenFX.Core.UI;

namespace OpenRP
{
	public class Spawn
	{
		public async Task Run(Model skin)
		{
			Player player = Game.Player; //On récupère le Joueur
			Ped playerPed = Game.PlayerPed; //On récupère le PNJ que le joueur contrôle
			if (await skin.Request(3000)) //On demande au jeu, de mettre le skin en mémoire
			{
				Function.Call(Hash.SET_PLAYER_MODEL, player.Handle, skin.Hash); //On applique le skin au joueur, Game.Player.ChangeModel est buggé pour le moment
				skin.MarkAsNoLongerNeeded(); //On libère la mémoire

				playerPed = Game.PlayerPed; //On doit récupérer le nouveau PNJ que le joueur contrôle
				Entity entityPed = Game.PlayerPed; //On récupère l'entité correspondante

				playerPed.IsVisible = true; //On rend le joueur visible
				Function.Call(Hash.REQUEST_COLLISION_AT_COORD, -1888.141f, 2045f, 140.9837f); //On charge les collisions aux coords fournie
				entityPed.PositionNoOffset = new Vector3(-1888.141f, 2045f, 140.9837f);
				Function.Call(Hash.NETWORK_RESURRECT_LOCAL_PLAYER, -1888.141f, 2045f, 140.9837f, 0.0f, true, true, false); //Résurrection du joueur + transmission a tous les autres joueurs
				Function.Call(Hash.SHUTDOWN_LOADING_SCREEN); //On ferme la page de chargement, si le joueur vient de se connecter
				Screen.Fading.FadeIn(0); //Empêche les écrans noirs
				playerPed.Task.ClearAllImmediately(); //On réinitialiser le PNJ contrôler PNJ
				Game.MaxWantedLevel = 0; //Désactive les étoiles de recherches
				Game.EnableAllControlsThisFrame(2); //On donne les contrôles au joueur
			}
		}
	}
}
