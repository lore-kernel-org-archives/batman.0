Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 27 Jan 2014 16:10:29 +0800
Message-ID: <5373996.23YD93TvXH@diderot>
In-Reply-To: <1390553883-1940-1-git-send-email-antonio@meshcoding.com>
References: <1390553883-1940-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14799926.THillFCMck";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: avoid potential race
	condition when adding a new neighbour
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


--nextPart14799926.THillFCMck
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 24 January 2014 09:58:03 Antonio Quartulli wrote:
> @@ -281,14 +281,23 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface
> *hard_iface, neigh_node->orig_node = orig_neigh;
>  	neigh_node->if_incoming = hard_iface;
> 
> -	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> -		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
> -		   neigh_addr, orig_node->orig, hard_iface->net_dev->name);
> -
>  	spin_lock_bh(&orig_node->neigh_list_lock);
> -	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
> +	tmp_neigh_node = batadv_neigh_node_get(orig_node, hard_iface,
> +					       neigh_addr);
> +	if (!tmp_neigh_node) {
> +		hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
> +	} else {
> +		kfree(neigh_node);
> +		neigh_node = tmp_neigh_node;
> +	}

What about hard_iface->refcount ?


>  /**
> + * batadv_neigh_node_get - retrieve a neighbour from the list
> + * @orig_node: originator which the neighbour belongs to
> + * @hard_iface: the interface where this neighbour is connected to
> + * @addr: the address of the neighbour
> + *
> + * Looks for and possibly return a neighbour belonging to this originator
> list + * which is connected through the provided hard interface.

'Looks and return' does not work. Either 'look and return' or 'looks and 
returns'.

Cheers,
Marek

--nextPart14799926.THillFCMck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS5hR5AAoJEFNVTo/uthzAwvUH/0PaCfQebmLc3q2Jmvm0FctP
PJSGOpiBQUAQ5uZ6jKNERWF0+HwU34GAqjllcPm4KYheaRT51/AjcbzOHcVEmJPx
IfPUb4i6diychlnQSHmkFEN8Ge8mGZE2MyTcT6KO/FVw65AyiogR6VaE3Q8NExkz
lOBb3uJfcenaJUeRmyAFchMEqJDxYdCaI7zY+/R2IR4gzPsMKi5JS1Uyk16XAaQ1
yizRG1pVKNRKyxTdyhHuNFmeP26QeOZpwqxt9ebdA9Ns5Ejw30lUAqUnkf/AK6rZ
egj9Z6ojOAJ50Hewxy60mdD4MyJGNX+SfHaCa3NUhB2qr6ykJfYpt2DPUYbpaUQ=
=Z/kb
-----END PGP SIGNATURE-----

--nextPart14799926.THillFCMck--

