Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 13 Jul 2013 05:24:02 +0800
References: <1373564858-2248-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1373564858-2248-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201307130524.02992.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: send GW_DEL event when the
	gw client mode is deselected
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Friday, July 12, 2013 01:47:38 Antonio Quartulli wrote:
> + * batadv_gw_check_client_stop - check if clitn mode has been switched off

clitn => client


> + * @bat_priv: the bat priv with all the soft interface information
> + * @new_mode: the gw mode which the node is switching to

The param "new_mode" does not exist.


>  	batadv_gw_deselect(bat_priv);
> +	/* always call the client check before changing the state */
> +	batadv_gw_check_client_stop(bat_priv);

I don't get what the "client check" comment is trying to say. 

Cheers,
Marek
