Return-Path: <a@unstable.cc>
References: <08d40a5302ac411895c49cf6b7e17d5b@MB82.inbox01.com>
 <1824062.p4cHhaC8Qk@prime>
 <e4bb792ab8264961a4ecb1921abd4cca@MB82.inbox01.com>
 <ccb6aeba-0e65-87c3-9464-aa062610c6b2@unstable.cc>
 <02f87c47f64a431cb7ef945e99841bf8@MB82.inbox01.com>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <e3f3e203-898d-ef7f-6d49-ad8f5d93629c@unstable.cc>
Date: Sat, 6 Jan 2018 04:38:50 +0800
MIME-Version: 1.0
In-Reply-To: <02f87c47f64a431cb7ef945e99841bf8@MB82.inbox01.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tzz6kwsBrKvAfwfB6JD2TXqS8cwHbZ9cu"
Subject: Re: [B.A.T.M.A.N.] Can b.a.t.m.a.n. be configured to ARP for
 unknown clients?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Robert Bates <rbates@freewave.com>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Simon Wunderlich <sw@simonwunderlich.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tzz6kwsBrKvAfwfB6JD2TXqS8cwHbZ9cu
Content-Type: multipart/mixed; boundary="Ze7sNDumoBTFxdfJrgHeuwdSr2GRtLtuy";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Robert Bates <rbates@freewave.com>,
 The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Simon Wunderlich <sw@simonwunderlich.de>
Message-ID: <e3f3e203-898d-ef7f-6d49-ad8f5d93629c@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] Can b.a.t.m.a.n. be configured to ARP for unknown
 clients?
References: <08d40a5302ac411895c49cf6b7e17d5b@MB82.inbox01.com>
 <1824062.p4cHhaC8Qk@prime>
 <e4bb792ab8264961a4ecb1921abd4cca@MB82.inbox01.com>
 <ccb6aeba-0e65-87c3-9464-aa062610c6b2@unstable.cc>
 <02f87c47f64a431cb7ef945e99841bf8@MB82.inbox01.com>
In-Reply-To: <02f87c47f64a431cb7ef945e99841bf8@MB82.inbox01.com>

--Ze7sNDumoBTFxdfJrgHeuwdSr2GRtLtuy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On 06/01/18 01:23, Robert Bates wrote:
> Hi Antonio,
>=20
> This "ARP if unknown" idea has been suggested within the group, and it =
was referring to the notion of seeing if it was possible to have batman A=
RP if it receives a packet on bat0 destined for a client which is not in =
tt_global.  I should not have mentioned that one, since Simon already con=
firmed that is not possible.  Another idea I have heard mentioned is to i=
mplement a timer-based ARP mechanism - again, by some other component in =
the path on our AP.   I'm not clear on exactly what the idea is there, or=
 how it might work (need to sync up with that person once he's back from =
holiday).
>=20
> Thanks for your other points.  Regarding the potential for it to become=
 racy to periodically read tt_local and probe clients, yes, the idea is t=
o do so every 5 minutes, for example.   We haven't discussed this much ye=
t (for the same reasons - people are still out on holiday), but we would =
probably not attempt to distinguish between clients which need it, and th=
ose which do not.  Though I suppose we could implement some logic to do i=
t only if last seen time is greater than some value.
>=20
> Very interesting point about an ICMP ping to the local client not gener=
ating packets which will come back through the bat0 interface.  Hadn't co=
nsidered that, thanks.  Would you have a suggestion for a different type =
of probe?

If the "probing" software will be installed on each of your devices,
then they could periodically ping some kind of central GW in the
network. This would force a few unicast (and maybe broadcast) packets to
cross the mesh and thus refresh the tt_local entry.

I would imagine this probe as some sort of "client keep alive" that tell
the mesh "hey, I am still here".

Cheers,


--=20
Antonio Quartulli


--Ze7sNDumoBTFxdfJrgHeuwdSr2GRtLtuy--

--tzz6kwsBrKvAfwfB6JD2TXqS8cwHbZ9cu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpP4loACgkQB6U8WA7y
zXR1dBAAg5z4+h0yyZnEvZpyDstBJVtsXnILsHSqqbEDmOOO9LYu2q9uenBDm3wr
XCAPBOo1WIoNsx5BlFXleMGXX7sXVOBlU0dnPINp5S0BfSBkudm+q0264DEvAs+J
NS66RRkaQyMEFFMTBj6rhkjcypqg/tRydEAS3QfS14DuMiSwzqIZi8GamtzY8/rE
eVS4k/oJul48w+gMmZICBx7Z71GCuGDi5AmT+mIyED9WVkphZAcD/QuTNvZSXjn6
EQ5msVAGw78xyfFuMBYJ9X39xF29ZMlOG4qBC3D20lb/t5iLadp7QC3/rkXCPLHQ
A67wfXT8oopRrr1Apf7Kk3T7bcWyI1kBviBmxRPdUmwSPN21Eb4gmhXKgAbjihJJ
DyXFDQnEoXahgYE8EbvHrw7/NG+FvykYKiVbAu4YWX5aN1A+YW/PSTMTzXImOlXo
OLfA6qYmM469wh1tRSdgI42+NMJT3nyfLC27iY/cIin53G5v3Y8gcrogw59H//to
8x5TTeMKBYni/JlcHqy0QPYkV/d9vb13UheSj7P2VJ+IrlBKzy1j1wNA3zZcIldt
Nvuga71fLUiQDhHGMmAZ1zg4j1rylCqUOOhCODj1KTSOOayO0nroaeVfg7NrFsBs
YMNSJIIO5t3emHCIGqlf8DyuWzvJdi4zuiAJNmJvml05hNgxEI4=
=w1JN
-----END PGP SIGNATURE-----

--tzz6kwsBrKvAfwfB6JD2TXqS8cwHbZ9cu--
