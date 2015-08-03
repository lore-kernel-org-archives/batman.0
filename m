Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2015 00:17:51 +0200
Message-ID: <3069070.T7deWUdzBy@bentobox>
In-Reply-To: <1437899254-24073-1-git-send-email-mareklindner@neomailbox.ch>
References: <1437899254-24073-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23978944.gl1r6atsLR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: add list of unique
	single hop neighbors per hard-interface
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--nextPart23978944.gl1r6atsLR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On Sunday 26 July 2015 16:27:31 Marek Lindner wrote:
> +static struct batadv_hardif_neigh_node *
> +batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
> +				  const u8 *neigh_addr)
> +{
> +	struct batadv_hardif_neigh_node *hardif_neigh = NULL;
> +
> +	hardif_neigh = batadv_hardif_neigh_get(hard_iface, neigh_addr);
> +	if (hardif_neigh)
> +		return hardif_neigh;
> +
> +	if (!atomic_inc_not_zero(&hard_iface->refcount))
> +		return NULL;
> +
> +	hardif_neigh = kzalloc(sizeof(*hardif_neigh), GFP_ATOMIC);
> +	if (!hardif_neigh) {
> +		batadv_hardif_free_ref(hard_iface);
> +		return NULL;
> +	}
> +
> +	INIT_HLIST_NODE(&hardif_neigh->list);
> +	ether_addr_copy(hardif_neigh->addr, neigh_addr);
> +	hardif_neigh->if_incoming = hard_iface;
> +	hardif_neigh->last_seen = jiffies;
> +
> +	atomic_set(&hardif_neigh->refcount, 1);
> +
> +	spin_lock_bh(&hard_iface->neigh_list_lock);
> +	hlist_add_head(&hardif_neigh->list, &hard_iface->neigh_list);
> +	spin_unlock_bh(&hard_iface->neigh_list_lock);
> +
> +	return hardif_neigh;
> +}

This can be the cause of inconsistencies [1] when two different contexts call
this function at the same time when no member with this mac is stored in the
list. Two nodes may then be added to the list. This should not a deal breaker
because the second node will time out.

Still, we may use a better check:

create()
{
    hardif_neigh = kmalloc();
    if (!hardif_neigh)
        return NULL;

    spin_lock_bh(&hard_iface->neigh_list_lock);
    hardif_neigh = batadv_hardif_neigh_get(hard_iface, neigh_addr);
    if (hardif_neigh)
        goto out;

    hardif_neigh = kmalloc();
    if (!hardif_neigh)
       goto out;

    hardif_neigh->init = something;
    list_add_rcu(....);

out:
    spin_unlock_bh(&hard_iface->neigh_list_lock);
    return hardif_neigh;
}

get_or_create()
{
    hardif_neigh = batadv_hardif_neigh_get(hard_iface, neigh_addr);
    if (hardif_neigh)
       return hardif_neigh;

    hardif_neigh = create();
    return hardif_neigh;
}

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-June/013345.html

--nextPart23978944.gl1r6atsLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVv+iSAAoJEF2HCgfBJntGzy4P/0cfmicLfngZCuw2u9ZXyZJl
c4a+Utxiw8DeTVUJzPW1pC6gV2svc2JT1VS2Pv30vi6mf/eryUsNbRjH92FDNuNE
3Zd7CsywthwOBgUhS6NeeJ01VPo6kwUhM5O16+feMARZcxh639q8A70UlCHfQTC3
ZCWBdcRqv6Rjc1GwP2QwOm4QqQfuId+QQIAvDq9Lgj3Em0PZvp0pp/4EhWlBXHf1
7N59LbGXIKe/Alu80iPGdoeUACSZtJWxdgY8UCw4hKSgf3ud9pXXzXJlF6h9Edc9
FAFoLEzbdHNHfk4fbMFFplVGqmn2h40EOwsXYBofbclGvc28siWJHH0YXq1czKEv
iKRTr0wxWasaPHSSUkknYqFPN56KJE7zyUfaz+1XKSxTzeMvHRt2o/rhq9F5pv6K
p9vUWMyQA66QF1ISapaylnLm7zFZKI9x3BdrWedeqkMKNxD2t8Yt+3RMXzdIwL7c
NJuq3btyEApivCdlR4KwYwA2lNsIx/zVl3tPcCCrflxUMGN8mD5NIbiD0Z4Z7cFi
8Ae0v8MC3hBYiWdjYq7aUe1Ymd7XQC6V26/8Meli14jHpupbQB1/b/l53K093VgJ
y9UYDUMkPtZ7xwbbijGU5yZSu84bsS+dfxCdj656yHO9ONsyYCVdas4eVtqCyR8s
NGDsASBPJ3Sj1sDMIJRc
=baN7
-----END PGP SIGNATURE-----

--nextPart23978944.gl1r6atsLR--

