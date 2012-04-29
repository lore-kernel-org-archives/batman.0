Return-Path: <ordex@autistici.org>
Date: Sun, 29 Apr 2012 09:00:02 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120429070001.GA30759@ritirata.org>
References: <CAKLmikOLbh20g3j4UcKbBjhmvKsoXB9A0jHTR75NZLtuWBCtCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <CAKLmikOLbh20g3j4UcKbBjhmvKsoXB9A0jHTR75NZLtuWBCtCQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Batman with Ubiquiti SDK
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Jernej Kos <kostko@unimatrix-one.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 29, 2012 at 01:56:02 +0200, Mitar wrote:
> Hi!
>=20
> Ubiquiti provides OpenWrt based SDK for their firmware. To my
> information, it contains some proprietary madwifi-based WiFi drivers
> with some older OpenWrt version. My question is how it would be
> possible to run Batman on top of their firmware (thus not latest
> OpenWrt). As Batman is in kernel, is is enough kernel-backwards
> compatible to be able to run also on older (2.6) kernel versions? For
> olsrd it is much simpler: you just install olsrd package and this is
> it.

batman-adv supports old kernel versions starting from 2.6.29.
What kernel is exactly provided with that firmware?
I know about someone else which still maintain compatibility with much older
kernels, but I don't know the state. By the way keeping backward compatibil=
ity
with older kernels is really difficult..

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPnObxAAoJEFMQTLzJFOZFXygH/2+2p5Pv4FQ2HECTQiTGIZJP
V7yqiJtt8PMjSXSarcTj5mbNrjnmseFeJ8KXYcY+BSMw0nSbojQ4bM+gkXFqd7dY
X7Jj1JAywTKG3KlnARgi9O9xOKkORfEf+C8CQYjluduM2z/j6+oqeIQnMEijZVG+
96U1GZQWXMz8OfL+iMaXqvCXdMnRE/bhZf0clldqzmPQHZHrE9E9Y8pVEFic6Ae5
r71gEkMcXyMTeA8UPvhLMlp4gFieqL1hIprhk5ebNVMi8UNfDbS0D0LfM+FD6/S9
HdygmipthOFbQ6P45FUqFq2KBjIjkESPunnvtZPXWuJsf2rkjtv8SBc5ZzmB42A=
=cK0q
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
