Return-Path: <a@unstable.cc>
Date: Wed, 6 Jul 2016 21:11:43 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160706131143.GN5978@prodigo.lan>
References: <1465721000-9174-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X970w0TH+RQTigba"
Content-Disposition: inline
In-Reply-To: <1465721000-9174-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix speedy join in
 gateway client mode
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


--X970w0TH+RQTigba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 12, 2016 at 10:43:19AM +0200, Sven Eckelmann wrote:
> Speedy join only works when the received packet is either broadcast or an
> 4addr unicast packet. Thus packets converted from broadcast to unicast via
> the gateway handling code have to be converted to 4addr packets to allow
> the receiving gateway server to add the sender address as temporary entry
> to the translation table.
>=20
> Not doing it will make the batman-adv gateway server drop the DHCP respon=
se
> in many situations because it doesn't yet have the TT entry for the
> destination of the DHCP response.
>=20
> Fixes: 9cbc67d9da47 ("batman-adv: change interface_rx to get orig node")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <a@unstable.cc>


--=20
Antonio Quartulli

--X970w0TH+RQTigba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXfQOPAAoJEJ4aZjxxc6bKJWQP/3VYw8wpU7hq6Z4zgmOWuctb
5ObLxXOudlkkw7jIWu+0izJ4MaLXbhnby5BpF9fk/BjZQU+EMNSec27xyTeN40PP
VcDfQWBA6MEvA12qMmaWFQGzhq6QHP6vgJWkSIAokKj8UodiPDNfrO9CDlWXlUEJ
c1JQEEkagBBquLCm+VTDjWTlTBEdUnRVmRhjCDvye5c3YuKm1QXzRhPIg9GWMa0S
XYAlRnGvYZ1Bta89dZihks39STHNHQ9dgt/BFhYtf7w16/nLQJZALCK2d5ol8ytr
jxl6amRbms27Lr1/xkZLfysVqnjCDu3nN96WqnFmubEtUpvZA0Ve8qqR0qzCcUZr
6CREdgtXRH1K/tQzhxgOvY1Gvs/OyRT3oFzC6cmzb2e+bgnoY5GgoYRbqRT6z2A9
H9932jZwNtV+Hke6pfXcvtUCiwItH7vTXmAE8Dw62bFOsSYph9UkKsr8DwOe3kBT
u5e9gjKovoVFXNx2xu/jwSf/QC/qRSMhpuGWWu+lxRc6qvyK8O1FMHRI2tdXQMnh
SjYsvUxILtE4VwOnwbn0pa1az8i4GLZ+PPF7UsUAvJIciFiEkgM/2dzP6VaSIA+y
t43fWzjzYp/EutXNhv8Tb+waJOur5/o0e75fKqMQaI2IqXTg+Y2L4EVLnHk+fRZQ
Yuouo8FxuADohTUw4UIK
=iE1g
-----END PGP SIGNATURE-----

--X970w0TH+RQTigba--
