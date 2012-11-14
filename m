Return-Path: <ordex@autistici.org>
Date: Wed, 14 Nov 2012 12:59:07 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121114115907.GA29879@ritirata.org>
References: <1352886828-24651-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <1352886828-24651-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: pass value in batadv_hash_bytes
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
To: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2012 at 10:53:48 +0100, Simon Wunderlich wrote:
> Passing the hash value by reference creates unneeded overhead. Pass by
> value instead.
>=20
> Reported-by: David Miller <davem@davemloft.net>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

I think this was not meant to be an RFC :-)
And I suppose this patch should be applied to next and no to master, becaus=
e it
should be merged with the next pull request.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCjh4sACgkQpGgxIkP9cwdLJACeLU+n7G4lILZUNURJjJ9zE0W+
4YoAnjFuYCLs33Vw2Zf8uERFeDG/ixvn
=Ds7M
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
