Return-Path: <ordex@autistici.org>
Date: Wed, 1 Feb 2012 08:15:35 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120201071535.GC28554@ritirata.org>
References: <1328045710-32600-1-git-send-email-ordex@autistici.org>
	<14133018.uqaqHtSXXJ@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <14133018.uqaqHtSXXJ@sven-laptop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: pass the correct header size
 to interface_rx
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2012 at 11:53:33PM +0100, Sven Eckelmann wrote:
> On Tuesday 31 January 2012 22:35:10 Antonio Quartulli wrote:
> > in recv_unicast_frag(), the third parameter of the interface_rx()
> > invocation, which is the size of the current header, is wrongly compute=
d.
>=20
> Really (actually it is the fourth, but I don't want to talk about that)?=
=20
> Wasn't the reassembled unicast packet just a unicast packet and not a=20
> unicast_frag packet (see frag_merge_packet)?
>=20
> I could be wrong (didn't checked it), but I just have the feeling that th=
e=20
> current version could be correct.

I double checked a few second ago and yes, you are right. Once the packet h=
as
been merged again it is a unicast_packet.

So, please guys, drop this patch.


Regards,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPKOaXAAoJEFMQTLzJFOZFufIH/3B6e/2Lrwe5yQwM7YWteoLg
DgePy0wnMRXzEYootHHpwH7MgpdIJRUxmpstS07oRLEJgXIk0aJfiapyvtT9LpEi
Gu54xvc/f/Oka3TVPUraTEAVOSoJGgvqsshAaicFb7/tKZ8e5R8CbOuGSFHxVS77
H8kmJhkc05oh3UllvB6e+8uIG8/wWilB8wxoUfdPZWmq8ZLhhyxbKaY/RaRgtvcz
FGDq+q+Kfx24LAB62EeolcpqDl5Mf4/bTE1gtFT4IuZsrDvV3cIxz017QmAHbqO0
FpfDCnKnu9inMKZtcbsjchJDVRatdBKfJh7VQj8pO3YGmQ5Q27O/7pTRxUwBcPc=
=GcmD
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
