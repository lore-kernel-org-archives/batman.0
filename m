Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 03 Jun 2018 18:53:50 +0800
Message-ID: <1938034.6FGcKLtQyt@lafayette>
In-Reply-To: <20180602152635.2923-1-sven@narfation.org>
References: <20180602152635.2923-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3252489.06oGGvvVjV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Fix bat_ogm_iv
 best gw refcnt after netlink dump
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

--nextPart3252489.06oGGvvVjV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, June 2, 2018 11:26:34 PM HKT Sven Eckelmann wrote:
> A reference to the best gateway is taken when the list of gateways in the
> mesh is sent via netlink. This is necessary to check whether the currently
> dumped entry is the currently selected gateway or not. This information is
> then transferred as flag BATADV_ATTR_FLAG_BEST.
> 
> After the comparison of the current entry is done,
> batadv_iv_gw_dump_entry() has to decrease the reference counter again.
> Otherwise the reference will be held and thus prevents a proper shutdown of
> the batman-adv interfaces (and some of the interfaces enslaved in it).
> 
> Fixes: fa3228924152 ("batman-adv: add B.A.T.M.A.N. IV bat_gw_dump
> implementations") Reported-by: Andreas Ziegler <github@andreas-ziegler.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek


--nextPart3252489.06oGGvvVjV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlsTyL4ACgkQU1VOj+62
HMByKAgAh56Jz0Y8mPHROE099iI4VHs/V/gUFtgaI5zChZv1xaNM4nhLw/hPkg6Y
Ps5tmezJMYulsXRoOhgGb9MedznwPYfPvqBYFs9q1iVyzvMNrvilo2EkcrzosZ9A
6VpuEMn+qhfkGYMIKdPhV5Sxnp4MgoyIiPGFtf8BBnULYPyd4yCyX3zM6ydEHMp3
fgQyFXprwNkNSxid7QGu9iwSjIXTYh5c3cRcfiG+fyvAbFSWq75KzkIw8TYYjUKJ
P+44p+M5EmvaRchiHe8co9lnQMzvycukWjbReqewrCstpe/LZfRI+MqDyLE/HUBZ
MTrMepiTOFmCl8EO7Ctr7/sks+v0vg==
=yI5v
-----END PGP SIGNATURE-----

--nextPart3252489.06oGGvvVjV--



