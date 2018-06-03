Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 03 Jun 2018 18:54:14 +0800
Message-ID: <6822908.HhYsLP0eh1@lafayette>
In-Reply-To: <20180602152635.2923-2-sven@narfation.org>
References: <20180602152635.2923-1-sven@narfation.org>
 <20180602152635.2923-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4392247.GH2cdYv8QL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Fix bat_v best gw
 refcnt after netlink dump
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

--nextPart4392247.GH2cdYv8QL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, June 2, 2018 11:26:35 PM HKT Sven Eckelmann wrote:
> A reference to the best gateway is taken when the list of gateways in the
> mesh is sent via netlink. This is necessary to check whether the currently
> dumped entry is the currently selected gateway or not. This information is
> then transferred as flag BATADV_ATTR_FLAG_BEST.
> 
> After the comparison of the current entry is done,
> batadv_v_gw_dump_entry() has to decrease the reference counter again.
> Otherwise the reference will be held and thus prevents a proper shutdown of
> the batman-adv interfaces (and some of the interfaces enslaved in it).
> 
> Fixes: 15315a94ad98 ("batman-adv: add B.A.T.M.A.N. V bat_gw_dump
> implementations") Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek


--nextPart4392247.GH2cdYv8QL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlsTyNYACgkQU1VOj+62
HMB1tAgAgG8mSNSlWuGlmh155CraOC6BuCIznlidqXSzICFVvh3M0CdQ0wYbYdGm
3MeQBxWVJXZnoqBWeJRHE6OGtkSIOalGKa8iRGT6YADKLU5UML+hE6MBxouSs9tm
JXlwdUpS00VOcFz2yDbwsydq9WHeBMWj6IF/T7f2OhtdVgn84e9I+N9ku6m8rpb1
w/HQiCIaKA7LAtO6DNzerSnv7W5EqF7hWe5/psQ/+Ap3qx7liyh/8wgP8SeXJ+k1
wAHZBP+flmIjnxv8YKgpgnppLVslmwYXPzJMQBvWlcal/K1KGbWeAyjBnQJmrJ0z
VnUKb++cig5jr6k+PoJQ6QQxH7Sm4Q==
=MU60
-----END PGP SIGNATURE-----

--nextPart4392247.GH2cdYv8QL--



