Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 13:23:18 +0800
Message-ID: <1946991.QjZUrbKzPJ@voltaire>
In-Reply-To: <1451992006-13191-8-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-8-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1691986.WeFZ0o9tEz";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 08/31] batman-adv: Drop immediate
	batadv_hardif_neigh_node free function
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

--nextPart1691986.WeFZ0o9tEz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 05, 2016 12:06:23 Sven Eckelmann wrote:
> It is not allowed to free the memory of an object which is part of a list
> which is protected by rcu-read-side-critical sections without making sure
> that no other context is accessing the object anymore. This usually happens
> by removing the references to this object and then waiting until the rcu
> grace period is over and no one (allowedly) accesses it anymore.
> 
> But the _now functions ignore this completely. They free the object
> directly even when a different context still tries to access it. This has
> to be avoided and thus these functions must be removed and all functions
> have to use batadv_hardif_neigh_free_ref.
> 
> Fixes: fed2826b490c ("batman-adv: add list of unique single hop neighbors
> per hard-interface") Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 918a769.

Thanks,
Marek

--nextPart1691986.WeFZ0o9tEz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmdPGAAoJEFNVTo/uthzAOdUIALMtP9opyba3PWj8MBVL+G4H
0FIWOe9dkql7Gt2dNta2gj4jfa8Dhr4fnzgvJWY38rAobHj+AxTXLi5kDn4O7aVs
Ds5DtjhyIUuuDxS4Bl3kMOIlJ5E9rm9HkEYJUeJ4v0NOMJOpm7rLHolQIsfxKBUX
VqLdYSso4F3n7hLQ4pM20T6uZZFZ1YNIk7pbMiIsEgv9ziohWnVCOuHamXCH4GWf
PKtK3Vdlkh4dcA+Lwalrdq8HI301yFndg26U+Fb7blboWwmB208zLDymJwefFi9c
VYmrDrErIgEh1T10+AaFJrKbhCTg0bE9eDdG6qGj0Gs/f75TxZfKGAf9joAuMh8=
=X809
-----END PGP SIGNATURE-----

--nextPart1691986.WeFZ0o9tEz--

