Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 16 Jun 2013 16:08:42 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130616140842.GA13449@pandem0nium>
References: <1371232209-7808-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <1371232209-7808-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Looks good, Tested/Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Thanks,
	Simon

On Fri, Jun 14, 2013 at 07:50:06PM +0200, Linus L=C3=BCssing wrote:
> This is the sixth revision of the basic multicast optimization patches.
>=20
> It simplifies and speeds-up the new batadv_tt_global_hash_count():
>=20
> * We now use batadv_tt_global_hash_find() instead of our custom look-up.
> * A counter for the orig_list was added, so that we won't need to recount
>   with every multicast packet.
>=20
> Cheers, Linus

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlG9xuoACgkQrzg/fFk7axYdHgCgrf+9SQQfEUZCl/TBLHz5aUqT
+LEAn0K84P+4SQaUYXd9VtHB+5R2UoIh
=L3Tw
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
