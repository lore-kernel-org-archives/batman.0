Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 06 Sep 2015 16:04:17 +0800
Message-ID: <2022068.2T8H1vD5AL@voltaire>
In-Reply-To: <1439897821-7480-1-git-send-email-sven@narfation.org>
References: <1439897821-7480-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7972998.1PuJcDEeky";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH net] batman-adv: Fix memory leak on tt
	add with invalid vlan
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


--nextPart7972998.1PuJcDEeky
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, August 18, 2015 13:37:01 Sven Eckelmann wrote:
> The object tt_local is allocated with kmalloc and not initialized when the
> function batadv_tt_local_add checks for the vlan. But this function can
> only cleanup the object when the (not yet initialized) reference counter of
> the object is 1. This is unlikely and thus the object would leak when the
> vlan could not be found.
> 
> Instead the uninitialized object tt_local has to be freed manually and the
> pointer has to set to NULL to avoid calling the function which would try to
> decrement the reference counter of the not existing object.

Applied in revision dba67bc.

Thanks,
Marek

--nextPart7972998.1PuJcDEeky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV6/OFAAoJEFNVTo/uthzAKa0H+QGN9n0RA5pQbLYRbJCTdYin
j0+6d7q0RxXBinLj/ztoy1FoNaO45Nx1v9wcp6EyMJd2kaoh8KGxbDG8+zxGWykh
lk3RVPUpUfaJUmWYIa0gRvXVcM/3vGrjSF0Hv+oEomXEAAJ/D7VjR2cYs/oOmPSb
Y2+dGxlJA9KnvNF/MgBZvqjq4c23C/L7an8JPK9H5GB84myEb6S/H8VtDmILVzKA
+hE+yjC7epNVQgibYS9Z91Wyg357MTnr/GdWT/ud+qOhstaIIXjoUT+P7r7+jUY4
0CruKrHXD300foMajpzJw7Pa6FU9IGF0Ik+R9ir3A5qXAk10SfSDDBSH6sfpkfQ=
=kEU0
-----END PGP SIGNATURE-----

--nextPart7972998.1PuJcDEeky--

