Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 30 Jun 2012 11:56:55 +0200
References: <1340785387-3821-1-git-send-email-ordex@autistici.org>
	<1340785387-3821-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1340785387-3821-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206301156.55486.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/4] batman-adv: implement
	batadv_tt_global_entry_get_orig()
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wednesday, June 27, 2012 10:23:05 Antonio Quartulli wrote:
> @@ -626,17 +626,17 @@ static void batadv_tt_changes_list_free(struct
> batadv_priv *bat_priv) spin_unlock_bh(&bat_priv->tt_changes_list_lock);
>  }
>  
> -/* find out if an orig_node is already in the list of a tt_global_entry.
> - * returns 1 if found, 0 otherwise
> +/* find out if an orig_node is already in the list of a tt_global_entry and 
> + * returns it with an increased refcounter if found, NULL otherwise.
> + *
>   */

This empty line does not look David-compliant.

Regards,
Marek
