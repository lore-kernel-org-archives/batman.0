Return-Path: <ordex@autistici.org>
Date: Tue, 21 Feb 2012 17:24:03 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120221162402.GC4624@ritirata.org>
References: <1329583133-11681-1-git-send-email-ordex@autistici.org>
	<1329583133-11681-2-git-send-email-ordex@autistici.org>
	<20120219145419.GB7006@ritirata.org>
	<201202201343.35230.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <201202201343.35230.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 1/7] batman-adv: add UNICAST_4ADDR
 packet type
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


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2012 at 01:43:35PM +0800, Marek Lindner wrote:
> On Sunday, February 19, 2012 22:54:19 Antonio Quartulli wrote:
> > I was wondering...what about adding a "payload_size" field to the new
> > packet?
> >=20
> > The handling code would probably be generic enough to handle any future
> > change leading to a more stable compat_version (instead of increasing i=
ts
> > value everyday).
>=20
> What will be the purpose of the payload field ?

After discussing this on IRC we came up with not introducing this field.
Actually we don't need it so it's not worth bloating the packet format now.

Cheers!


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPQ8UiAAoJEFMQTLzJFOZFzl4IAJ39qvVkbOwkWAOy3mhpZ2Rm
TVLjBo5/TeZ9TBckEYaSDs/bOnD7sUKpQVfNbCtqGn4EXmgdy4uevzwYE1Rv6aqm
VNgWKAQIRl1keAuw5CijZiHO99g/o2LBxq2jYCQgAlzYGLsrrnE9cSpvGyn/BVlL
R00puuicNglwcUTnnryw8SymtisHMZVdwyb2HuI91KxfE3qABOCBPz+A2c6I5BfS
KUKJd9S+nDsDDWCydHerkNM4u3Dm3Mq/lFAnxFZEMKekKgzXKcxYjIIc0MTvCWkP
Ir1B6ykiNBcdDRsi2MQgRRgOkkrfO+TEQ0o3NxyxPC71K8RzAMGFd22QK18K5uY=
=a9eU
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
