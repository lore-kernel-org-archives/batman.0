Return-Path: <antonio@meshcoding.com>
Message-ID: <52F9FD08.9040307@meshcoding.com>
Date: Tue, 11 Feb 2014 11:35:52 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392114403-4069-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392114403-4069-1-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="drbsq76x82su9FvaRWo5U6Ke3lANIlhMj"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix memory access by setting
 mac_header in DAT
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--drbsq76x82su9FvaRWo5U6Ke3lANIlhMj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 11:26, Antonio Quartulli wrote:
> In the TX path we now have functions that rely on the
> skb->mac_header field. DAT does not set such field when
> creating its own ARP packets thus leading to wrong memory
> access.
>=20
> Fix it by always setting the mac_header after having forged
> the ARP packet.
>=20
> Reported-by: Russel Senior <russell@personaltelco.net>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> Tested-by: Russel Senior <russell@personaltelco.net>

This patch is supposed to be applied on maint.

Cheers,

--=20
Antonio Quartulli


--drbsq76x82su9FvaRWo5U6Ke3lANIlhMj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+f0SAAoJEEKTMo6mOh1VAXEP/1BsQvL0n9ie5a4QKJV/uoK+
yDN5HqLlQ5w5cVlzpWzD4PMMdKSxvRvE8aZpA+hQPVCjZ0JZ5mmNRwPqsLr+75MS
PPj0PrlmlNa8ykwuOo2k67IScdTQg1gquL3T+uMhDA1ssYjyfsVc9Mxj/3OXp13X
8i8/0tPEC354JPAjNYWQnZUM2mLjfOmzvuXYUrLxAMGoRD85ToJXfPNEYYbwBlj3
NaljQk3ednOdq+I+bjBVg/l4vc4/r5Z7DRFa0WiqSm4r/q8+FiZ/cIMrhFnCoOT1
HboSsoZnhiCrWR0AorNZ05cKjV+7C9MAVVyyEBDPcy+PnCHP2b4oHTlioqpO2sJ8
z4tkSPFmid+Mvy3mZi0bxrTAE5HBaz2Yda4QnDwGB1laS8LBwjDbXRM+VV9wWebh
0wbdIXiAOj9aOlxWAP/VcbGG8T9MFX5da/Mm0J6kLC+h4xLIRmtlYGhrBdbB2MuN
ZuIl0LotMhgcHmxU3wACGv1ZLW0lzW3YaXuU7Ic8OMypQPIFUD9gBcXdmSSRNZql
zhtTJ8uBfZLesCDkUla9dzojpQd9Gcb7I2ghicaybp1KOvpUhzlqfYuMRuhnOta4
dRnUcvq/UZ1lacc4uXcCiVu70GPWVbrug3kfvc45lB3IPmKKDoBN/6IjpP9GaeUe
mXL/R/xcDrTlOqTLz8kp
=43I2
-----END PGP SIGNATURE-----

--drbsq76x82su9FvaRWo5U6Ke3lANIlhMj--
