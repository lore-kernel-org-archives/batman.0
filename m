Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 10 Feb 2016 18:43:41 +0800
Message-ID: <5358388.271e7JeB5Y@voltaire>
In-Reply-To: <1454243280-15126-1-git-send-email-sven@narfation.org>
References: <1454243280-15126-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart45480659.u1WpUfToFk";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 1/2] batman-adv: Only put gw_node
	list reference when removed
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

--nextPart45480659.u1WpUfToFk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, January 31, 2016 13:27:59 Sven Eckelmann wrote:
> The batadv_gw_node reference counter in batadv_gw_node_update can only be
> reduced when the list entry was actually removed. Otherwise the reference
> counter may reach zero when batadv_gw_node_update is called from two
> different contexts for the same gw_node but only one context is actually
> removing the entry from the list.
> 
> The release function for this gw_node is not called inside the list_lock
> spinlock protected region because the function batadv_gw_node_update still
> holds a gw_node reference for the object pointer on the stack. Thus the
> actual release function (when required) will be called only at the end of
> the function.
> 
> Fixes: 0511575c4d03 ("batman-adv: remove obsolete deleted attribute for
> gateway node") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/gateway_client.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied in revision c215e4e.

Thanks,
Marek

--nextPart45480659.u1WpUfToFk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWuxRdAAoJEFNVTo/uthzAofEH/i8eVUmGVooJXnhd7Mg1HRRE
aYFwkksuy+xqdG1IBAfU5QTztiUEiFg7iXi3U6StItoxD11ZPVNyj1CUychuiX19
K0AvAXdmUOxVqbMQDEZTMxPIVxF36WaXWpcVrHktWlW70WyB6UKnsSm/lwnLrUN0
kxa4bCqZUgUxdrIpao1vDDwYjYPapnOtr4va/PMugQLRZPJo/mCgZ7Xi9t2Xo/Cy
9H6nt6Yj0Mdj6m0Wl3spQ6ckQvysqVidz9vKqzJ3v9vfRMpLR7VfiYruRfor2ROp
do+7JeUM95HTyKNbTS1sZmfaNapOL7s6BzrNih1IEcJqloKmRjCWsaFOO41+b14=
=kZu+
-----END PGP SIGNATURE-----

--nextPart45480659.u1WpUfToFk--

