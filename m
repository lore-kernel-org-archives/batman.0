Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 Sep 2012 16:29:57 +0800
References: <1346339064-4348-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1346339064-4348-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209091629.58178.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: roaming re-routing mechanism
	redesign
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

On Thursday, August 30, 2012 23:04:24 Antonio Quartulli wrote:
> The roaming re-routing procedure has been slightly revised in order to get
> rid of the tt_poss_change variable that was not clearly representing the
> node/client states. Now the code directly relies on the TT_CLIENT_ROAM
> flag that can be set on the involved local/global clients.

This seems to explain what another patch is doing ?


> - This patch is based on top of:
>   "batman-adv: substitute tt_poss_change with a per-tt_entry flag"

Where is that patch ? I am unable to find it.


> +static void
> +batadv_tt_global_del_struct(struct batadv_priv *bat_priv,
> +			    struct batadv_tt_global_entry *tt_global_entry,
> +			    const char *message)

Can we come up with a better name than batadv_tt_global_del_struct ? "struct" 
is a rather generic term.


>  void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t
> *addr, int ifindex)
>  {
>  	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
> -	struct batadv_tt_local_entry *tt_local_entry = NULL;
> -	struct batadv_tt_global_entry *tt_global_entry = NULL;
> +	struct batadv_tt_local_entry *tt_local = NULL;
> +	struct batadv_tt_global_entry *tt_global = NULL;

Please don't mix code changes with renames. That makes it hard to spot changes 
in the behavior. Split these changes.


> +		if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
> +			/* if this client is marked as pending it means that it
> +			 * was purged out before.
> +			 */

Scratch "out".


> +			batadv_dbg(BATADV_DBG_TT, bat_priv,
> +				   "Readding pending client %pM\n", addr);

Can you change it to "Re-adding" ?


> +		/* if the entry is marked as NEW, it means that the node is not
> +		 * the original owner of this client (in this orig-interval),
> +		 * therefore it does need to  eventually send a roaming
> +		 * advertisement
> +		 */
> +		/*if (tt_local->common.flags & BATADV_TT_CLIENT_NEW)
> +			goto out;*/

Dead code ?

Cheers,
Marek
