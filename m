Return-Path: <ordex@autistici.org>
Date: Sat, 25 May 2013 23:44:43 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130525214443.GL1679@ritirata.org>
References: <1369516631-11982-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jB+02Y6wHc2pEa2x"
Content-Disposition: inline
In-Reply-To: <1369516631-11982-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add dummy soft-interface rx
 mode handler
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


--jB+02Y6wHc2pEa2x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2013 at 11:17:11PM +0200, Linus L=C3=BCssing wrote:
> We do not actually need to set any rx filters for the virtual batman
> soft interface. However a dummy handler enables a user to set static
> multicast listeners for instance.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
> * Fixes issue #171

Thank you Linus for digging into this.
I've seen that the bridge code does the very same thing.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--jB+02Y6wHc2pEa2x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRoTDLAAoJEADl0hg6qKeOhJQP/i17ncjSHrsjL33U6OQem9Ne
tdIgPJUHEqSvV3vW7ATA2GqpuPgeSl/77nNWuujkZqGDCVoYAJSaBQd4sRGO7iHM
TTDsa/7PoWADWNhZXo/B87Q3YwvpohrxQFfGK2Td3b1sn9Ym482+jMf0sysuqfVs
6k4LIi4cODbpSYhwS7HxrgkU9H/bizwa4sx8Eu7hDRenUX99BTqRQ0jFuNyCVv11
0KnnPdrkv1sBSE4aC6PRBeLQSiDtFangZyVnTtaErqNhc1Q2neE0yHhwsXjZTvaq
AFI1faq+fRGI6IS0SQZJ4rsdLeMXazHVJXOUd+kkhGeqeTYpoAH+KtpKhFRfpL7f
h/CSxMtyGRXtOSlbPXIwH3wcxTdbtIDkuy1Cobxe+psgo04e3L1bfOKQCNsjoopn
82+AIO+xgMErML2cap20cT0KkHUh7QHMWao5pUypDGp5UtQqAmu4HKMMS3ibc8nS
hg95sVwnPtn1wV0azFJBr9RCTLkkfAgV8guoQ7upx9Au9EG0HkUf44HEkT5rR6RL
oAelDszDYyMfYe9OUa8vCs4DmaGjJsTdXs7qzyDG26NxH9t30qVVKq9iIS01q//D
NtGroHgnrEnUGHZPNPjTNHN0AoVaNRpoO13m3A6UCE7tsi9BHRtfCx3kaaNYZdHJ
B+MWShp43f7SHhthVQ3g
=LY6R
-----END PGP SIGNATURE-----

--jB+02Y6wHc2pEa2x--
