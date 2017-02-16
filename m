Return-Path: <ben@decadent.org.uk>
Message-ID: <1487261150.22520.6.camel@decadent.org.uk>
From: Ben Hutchings <ben@decadent.org.uk>
Date: Thu, 16 Feb 2017 16:05:50 +0000
In-Reply-To: <20170216065613.GB24635@otheros>
References: <lsq.1487198490.691915840@decadent.org.uk>
 <lsq.1487198494.509932883@decadent.org.uk> <20170216065613.GB24635@otheros>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-81tzo38deM2eTW+K9GOg"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH 3.2 049/126] batman-adv: fix splat on
 disabling an interface
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, akpm@linux-foundation.org


--=-81tzo38deM2eTW+K9GOg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-02-16 at 07:56 +0100, Linus L=C3=BCssing wrote:
> On Wed, Feb 15, 2017 at 10:41:34PM +0000, Ben Hutchings wrote:
> > 3.2.85-rc1 review patch.=C2=A0=C2=A0If anyone has any objections, pleas=
e let me know.
> >=20
> > ------------------
> >=20
> > From: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> >=20
> > commit 9799c50372b23ed774791bdb87d700f1286ee8a9 upstream.
>=20
> Hi Ben,
>=20
> This commit was reverted in
> 27915aa61060fd8954a68a86657784705955088a
> ('batman-adv: Revert "fix splat on disabling an interface"').
>=20
> Greg dropped this patch from his stable queue back then, too [0].

Sorry, I should have seen the note for this.  I've dropped this from
both 3.2 and 3.16 queues.

Ben.

> Regards, Linus
>=20
> [0]: https://marc.info/?l=3Dlinux-kernel&m=3D147938417410032
--=20
Ben Hutchings
The most exhausting thing in life is being insincere. - Anne Morrow
Lindberg


--=-81tzo38deM2eTW+K9GOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlilzd4ACgkQ57/I7JWG
EQncsxAAw1jKwKJTl8F1QXXWE0BP73rcFZ0VM6xlt7IrLwLnFxXxw8HZa9amXYfO
VwDRv671ER/+5ilwhMikgnsrEz3EON8pKCR4x17LB1KOhHAKemUflHoJQA/pgL5Q
WNuGnZ5N0+PFwG5MLC8qYBYfEUXFMqUjkJBZUIZDkAHw0FVEj3myQ7xKAh3ZCUkg
pfEJpUmF6h329pignnrgHeV5Zipss7/tzOwYybxGTG/zvsPgNJKjC94poKtrEQVn
X4/Vk/p5O0x55ys8W6aZse/0z4o1sKpPegSgmboUuO8aX8zmRAEt2l0z+C4EmNRb
/cgMbcjJrSQABAErVI7bD5+9lYbaoeC75CSiisx2weLqJhBK7UtyYJb7tUxib6K3
CE6ytbcl4kTHvxpaX5vRF82v608DCUUOuzT9gydeJmBsNKbX9AwwNB8QCpx3cehT
yl6hXeRAXFvrXwVvs4HRoC6HQkyC0sdXCMvYF1kWD2yQdAwB7msrqRR0zV0g53+e
qr9lBK2pYhoQt4LMZVrzc8OR32e/c/ngcEX/t1y4KUYWxieno1MdU4OheIZcce/e
qrR9HqHgIUHTdiqPdeCc5YvOIDgEIdr8gM0ZMjh6WGreA2NqihITir78MTbbPQT2
Fyx4S+Qk2tWCapRKkwn+CpZa3bDFAd96Uo+dN+UKM0u9v/WPUn8=
=PcQs
-----END PGP SIGNATURE-----

--=-81tzo38deM2eTW+K9GOg--
