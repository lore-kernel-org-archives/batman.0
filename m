Return-Path: <a@unstable.cc>
Date: Thu, 28 Jan 2016 10:59:34 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160128025934.GD22112@prodigo.lan>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/4] batman-adv: Add network name space
	support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2016 at 06:48:26PM +0100, Andrew Lunn wrote:
> This patchset makes batman-adv network namespace aware. A soft
> interface can be creates in a namespace and hard interfaces added to
> it. soft interfaces cannot be moved between name spaces.
>=20
> The biggest change is to debugfs, which is not natively netns aware,
> unlike sysfs which is. A new netns directory has been added and within
> that, a directory per network name space which batman is used within.
> The changes are backwards compatible, in that interfaces in the global
> namespace are not placed into a subdirectory.

Andrew,

I guess that after this patchset gets applied we need to change batctl and
provide some "netns" argument similar to ip ?

--=20
Antonio Quartulli

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWqYQWAAoJENpFlCjNi1MRTwQP/0qIy2Nnkxc8VLzpoFQZKPRy
By6S4/Ddr937w/t0FCMLw3m6f9eWwMm4R/F7/x1HqxTRN53DorPF/W9tZ+jpd1UV
S+wxcislpGjYr3LVv4UyOzgYoU+lfnokUon4I1ep3lXaPILayHVwrL/WUpm29mu3
1GhwOMQNJLX+DsFaW3eYpWEbCak3T3FdO+vSxKaConPkA4TeP7TQhWMkBRmXvMzP
DydWuvNffPuyeqlJLN49fK2tGRS/mt2Yv+zhdf8vI/4RxEebJhat3HS2dyiTGptd
Hd9+ZpxbWFlQCwrGlPaP7ULQ6ZRW/1o0TR65EwYd3yeNd19iR2u4gvYvEUuydk6H
gqtpFhWkLPskm9l0bdlZ8j0uuYTcrB+WwtTxzY3Zij8EOXKPZ1Sk0Kg5FHqIYBlO
5ulpg+xPYlzoPJSGDUmbdZ75dpmPu/eK8QMQ1n6eEEjDZrIlt/EDauyR1UJta4Sv
8vNkmMNjiLs+1exUU5uKxRbNHFkLPdrKJF0DVA4427cagPwZ0DXCoTDKY6Qb1Cg8
tTr8mUuVpdGKbYBjUTmazI6h2rRXjVhDe2aQ7Claci3l5OQgWqgmLX80KNANTD9v
JEA1Y/PtxF6Wm1zv1Zqi1AAqbpJhzc1FhyYt+ZF2KwBlA7UVAYbumxqnVvG75tdW
E+h7RUTJz9QoU3cDXMsQ
=g5Q5
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
