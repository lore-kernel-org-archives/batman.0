Return-Path: <ordex@autistici.org>
Date: Thu, 9 May 2013 18:44:26 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130509164426.GF1415@ritirata.org>
References: <1368109009-2100-1-git-send-email-ordex@autistici.org>
 <201305100007.08742.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <201305100007.08742.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: fix VLAN Ethernet
 header access
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2013 at 12:07:08AM +0800, Marek Lindner wrote:
> On Thursday, May 09, 2013 22:16:49 Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > In interface_rx() skb->data cannot be directly used to
> > access the Ethernet header because it point to the batman
> > one.
>=20
> You don't believe that these calls (shortly before the code chunks you ar=
e=20
> changing) are helpful ?
>=20
> skb_pull_rcsum(skb, hdr_size);
> skb_reset_mac_header(skb);

You are right. Hence this is not fixing anything. It is just a beautificati=
on
and therefore we don't need it in maint.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRi9JqAAoJEADl0hg6qKeOvK4P/0HTyhjm8n6hUqOhKlnRwKXM
THO/qfEYDUr5rOIcBPY4pGgcTYOdV0TQyKNWzM3oIJyoTPI7pyLYJ/oVI41hnYS5
OBlsc8C4t0EbAMfAMq0oDQMqiPVhrJo+LwWPp4g2+KtlSeSgqdn0sRwWee9Ed9J1
FMKDSZ1bmjkquLNCNDAw2YTQln6HICWMin/MWYHAvY2oZhp2fWwrUKV78cQGpu5e
SPY+jqYidgJ3NQwCRIsa1AkzJf9QCer6LXXPqLUTdCKRA/+xUr5P525bbg7+md24
l208Xl5FuxRVgPIyHPSbaQXF/w4GvW1S51VjvWwPTJqZ8QRJhI4E52QwT7Pw6d0p
kKOYhkTWPpbeh85DhugQjkFQwRetW3qVIzKVj2Oau8PwvLq77R79DqdQ9amVEr6y
k4g6cTf0mTn3TYQmD2ZUR2eWZJf0mgyEE59U95f4VbiSEaD75LG6T8Towm9JEULU
7uwYJPwU7kfP5tgwk7M9/ZUvKJANGRFXZNGYz9AbTimyTB/UlN5+3FhS1Oy5VgPD
FeR3gVpY5s9UL8sL8E+Uvcgkf5irjqk1UC4rXi8M3+m6t5WfAuo5kKNRbhGsXeUD
K1cirtaUk6rBb+Ahm2ziITAxIMloCj3zEawieBhcLxJWy7CXE99deeGNYpm7PKK3
3FY0pAVhcgKu0kzE54Bg
=ZB5z
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
