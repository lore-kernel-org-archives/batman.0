Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Dec 2018 20:11:18 +0100
Message-ID: <5881296.i1tslI3xJu@sven-edge>
In-Reply-To: <20181231110950.GD4150@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-3-sven@narfation.org> <20181231110950.GD4150@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6874263.85UqNy2q2d";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 02/19] batman-adv: Prepare framework for
 mesh genl config
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

--nextPart6874263.85UqNy2q2d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 31 December 2018 12.09.50 CET Linus L=FCssing wrote:
[...]
> [...]
>=20
> >  #ifdef CONFIG_BATMAN_ADV_BLA
> >  	if (nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
> >  			ntohs(bat_priv->bla.claim_dest.group)))
> > -		goto out;
> > +		goto nla_put_failure;
> >  #endif
> > =20
> >  	if (batadv_mcast_mesh_info_put(msg, bat_priv))
> > -		goto out;
> > +		goto nla_put_failure;
>=20
> With the rename of "batadv_netlink_mesh_info_put" to
> "batadv_netlink_mesh_put", I'm wondering whether
> batadv_mcast_mesh_info_put() should be renamed, too.
> batadv_mcast_mesh_put() would probably be a bit too generic.
> But maybe something like batadv_mcast_nl_mesh_put()?

Not relevant for this patch. But feel free to check what we can do to make =
it=20
more consistent. We can then do it after having the rest in place.

Kind regards,
	Sven
--nextPart6874263.85UqNy2q2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwqadYACgkQXYcKB8Em
e0aTNBAAu27T5cn3rZbFZvkeYfRRmRzsw1UDByimWKftagDv0CuPkgtwZOUp8PIy
r76hQvFoVNKTE5Xr/dw46yHSynascYk4AsiIQP6v3qttiIUzytarI7NzfHRdR6E9
5FZKn1JpJzImL3jWrqfY7VlJW50sYET1ICY4jy9vgnT3BdpxPmtwHs3x2kY6mkQ2
u32acV0i9uwvyifZNDytb9kxC9ogj/IhqBI3E00V68Kqh5O0YC6c0EH99evj54m9
GSHqaTkIT+u/o7Z5pKC/2Qdb43P1evorivSWC1xU1hhD20edXaFJMx7wr6Ml8zY2
T2Oin58S3QbzSYOSRF0EntyH49sRkJkcFVh7w9Z473raQpZrCdkex7WlXXj4pMaD
j2px13SV6AlZZhSAUa4kJKc8Up4Dqp7SsF7ibPkQn/CTKutRO7I+J4sHkl29wYa3
J2EqwsjprdkwgLrBsrKiudZM0UIUYypgl++8Vdzfdw0wpVAU6FIGmiqak/+Uf4cG
dQtDt31IJtUMTkQGwZ1ooggvcHNIHpEKUg/L5fPJCb9Z/dv+rhuD2pR1z18Qg3EW
imkN7okW3EGuA5hoWOtHtCoSW2HkOal+nBTpcvZVUhIVfwImzKkrtGsfcBYh/cBO
T7zOsh+PQceEn79TwPjKu3dU6n0Cz5S1i3uo0W0eFNpP9lqRvDY=
=OmzM
-----END PGP SIGNATURE-----

--nextPart6874263.85UqNy2q2d--



