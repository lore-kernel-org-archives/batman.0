Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 Jun 2012 23:50:22 +0200
Message-ID: <1564568.1LY5lsXFIC@sven-laptop.home.narfation.org>
In-Reply-To: <1340740822-4516-5-git-send-email-ordex@autistici.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
	<1340740822-4516-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5013767.lSlmLHAXmh";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: detect not yet announced
	clients
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart5013767.lSlmLHAXmh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 26 June 2012 22:00:21 Antonio Quartulli wrote:
> With the current TT mechanism a new client joining the network is not
> immediately able to communicate with other hosts because its MAC address has
> not been announced yet. This situation holds until the first OGM containing
> its joining event will be spread over the mesh network.
> 
> This behaviour can be acceptable in networks where the originator interval
> is a small value (e.g. 1sec) but if that value is set to an higher time
> (e.g. 5secs) the client could suffer from several malfunctions like DHCP
> client timeouts, etc.
> 
> This patch adds an early detection mechanism that makes nodes in the network
> able to recognise "not yet announced clients" by means of the broadcast
> packets they emitted on connection (e.g. ARP or DHCP request). The added
> client will then be confirmed upon receiving the OGM claiming it or purged
> if such OGM is not received within a fixed amount of time.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  main.h              |    2 +
>  packet.h            |    1 +
>  translation-table.c |  152
> ++++++++++++++++++++++++++++++++++++++------------- translation-table.h |  
>  4 +-
>  types.h             |    1 +
>  5 files changed, 121 insertions(+), 39 deletions(-)
> 
> diff --git a/main.h b/main.h
> index 6dca9c4..00c9c34 100644
> --- a/main.h
> +++ b/main.h
> @@ -43,6 +43,8 @@
>  #define BATADV_PURGE_TIMEOUT 200000 /* 200 seconds */
>  #define BATADV_TT_LOCAL_TIMEOUT 3600000 /* in miliseconds */
>  #define BATADV_TT_CLIENT_ROAM_TIMEOUT 600000 /* in miliseconds */
> +#define BATADV_TT_CLIENT_TEMP_TIMEOUT_FACT 10

At least make a comment what this value says (fact * orig_interval) or 
something like that. And you may have to make it UL to really return unsigned 
long in batadv_tt_client_temp_timeout.

> -static void batadv_tt_global_roam_purge(struct batadv_priv *bat_priv)
> +static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
>  {
>  	struct batadv_hashtable *hash = bat_priv->tt_global_hash;
>  	struct hlist_head *head;
> +	struct hlist_node *node, *node_tmp;
>  	spinlock_t *list_lock; /* protects write access to the hash lists */
>  	uint32_t i;
> +	bool purge;
> +	char *msg = NULL;
> +	struct batadv_tt_common_entry *tt_common_entry;
> +	struct batadv_tt_global_entry *tt_global;
> +	unsigned long temp_timeout = batadv_tt_client_temp_timeout(bat_priv);
> +	unsigned long roam_timeout = BATADV_TT_CLIENT_ROAM_TIMEOUT;
> 
>  	for (i = 0; i < hash->size; i++) {
>  		head = &hash->table[i];
>  		list_lock = &hash->list_locks[i];
> 
>  		spin_lock_bh(list_lock);
> -		batadv_tt_global_roam_purge_list(bat_priv, head);
> +		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
> +					  head, hash_entry) {
> +			purge = false;
> +			tt_global = container_of(tt_common_entry,
> +						 struct batadv_tt_global_entry,
> +						 common);
> +			if ((tt_global->common.flags & BATADV_TT_CLIENT_ROAM) &&
> +			    batadv_has_timed_out(tt_global->roam_at,
> +						 roam_timeout)) {
> +				purge = true;
> +				msg = "Roaming timeout\n";
> +			}
> +
> +			if ((tt_global->common.flags & BATADV_TT_CLIENT_TEMP) &&
> +			    batadv_has_timed_out(tt_global->common.added_at,
> +						 temp_timeout)) {
> +				purge = true;
> +				msg = "Temporary client timeout\n";
> +			}
> +
> +			if (!purge)
> +				continue;
> +
> +			batadv_dbg(BATADV_DBG_TT, bat_priv,
> +				   "Deleting global tt entry (%pM): %s\n",
> +				   tt_global->common.addr, msg);
> +
> +			hlist_del_rcu(node);
> +			batadv_tt_global_entry_free_ref(tt_global);
> +		}
>  		spin_unlock_bh(list_lock);
>  	}

Why writing this whole thing in one function? You don't get a price for the 
highest indentation level that banged the hardest against the 80 character 
limit.


> -	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM)
> +	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM ||
> +	    tt_common_entry->flags & BATADV_TT_CLIENT_TEMP)
>  		return 0;
> 
> +
>  	tt_global_entry = container_of(tt_common_entry,
>  				       struct batadv_tt_global_entry,
>  				       common);

And this new line doesn't make sense

Kind regards,
	Sven
--nextPart5013767.lSlmLHAXmh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJP6i6eAAoJEF2HCgfBJntG6acQAKwTMoqiXjguc7DCUjVK4EMj
QlBcwyxzY43Zgg+DpJ3+HMT5f+BRX+F5S66ZfGq9nRXnjLRKi8NWubxGETGGYbj9
q64WOVdtbILK9Q3XdG3Dfk7HkfSrQU4P+FQ1QNJx12g2h38M2gh3VppoBB/pMbGo
mZ2RYa20/Q49sKydttZkOUk7Ky8A9hiWf6ino2nm+cCfEI1t9q2GBWdX3JimUrvm
GmtCzNo0aQVU7RRrB/ZMgksMf9OYeMx3gHG94bJrR1PYghIysbleFou5S7kGTnsA
sBJl6ztLMCmNTfUVP0NNbK3n9u73VP5/wFVMIQwCpJJPx8xq62edk5oeO4h+frRZ
RaEDcF/Nj/po/qWB8F1BD3JJgSJgcmpijwrcs/WO2e2J7D59thkRVyislFTR+DB9
GryVH7sNWlZVtqJNuj7TPeBerYmJ6ki/gMaxKKpxfaZSVzqjD7LC8rfIdOgEx/IQ
GUsgwOS9WbohU0xdSqjEdxPuz6J82YRy9GJg3/jI7GWY5+aY8N3WDhm9ccHqjv4C
iRZNNrL/m6IkSqrjtx12ay9OEr9fzBbbOBZuLDeK/yBNsXkmsaxjgjdUC64QCgKM
Ufi+VOsmiVZj0atoldSiQPj7Ly0T/TX5LndXuN6Lx1ymBSLtn2uS1cc/vzS/Gv8Q
cBKZyTt4QeABzP8JR2Fy
=Phdn
-----END PGP SIGNATURE-----

--nextPart5013767.lSlmLHAXmh--

