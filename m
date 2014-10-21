Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 21 Oct 2014 16:13:47 +0200
Message-ID: <2324813.fvPiepg1LU@prime>
In-Reply-To: <CAEBHRFHrcUUK0e84R6Xh7FhCOqN=1v=Eokmaf4aEhBPj-09nrg@mail.gmail.com>
References: <CAEBHRFHrcUUK0e84R6Xh7FhCOqN=1v=Eokmaf4aEhBPj-09nrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1515330.GIYDjRvvcE";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Local Clients Expiring from Translation Table
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


--nextPart1515330.GIYDjRvvcE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday 21 October 2014 09:55:23 Jon Fink wrote:
> I'm experiencing some issues where clients connected to a batman node=

> (through a wired interface) are expiring from the local translation
> table after a period of inactivity. I'm guessing this is an
> intentional feature to support roaming but I'm wondering if there is =
a
> way to stop this behavior for certain MAC addresses. Some more detail=

> of my setup:
>=20
> * I have multiple mesh nodes named pico9, pico17, pico24, pico41, etc=
...
> * Each node is running BATMAN 2014.2.0 attached to a wireless device.=

> * Each node is also bridging the batman device with its local etherne=
t
> device. * A subset of the nodes are then connected to the same wired
> backbone, lets say pico9/17/24 are all on this backbone.
> * I have my laptop also connected to the backbone and I am able to
> successfully connect to any of the BATMAN nodes (over the wired
> backbone or to other nodes via the wireless mesh).
>=20
> pico41 (not on the backbone) has a wired client connected to it, lets=

> call it clientA
>=20
> I can initially connect to clientA from my laptop and it shows up
> correctly in pico41's local translation table. However if I do not
> continually send data (ping, ssh, etc) between my laptop and clientA,=

> I see the "last seen" column of pico41's local translation table entr=
y
> increase. Eventually, clientA is removed from the table and I am not
> able to connect to it (ping or ssh) until I "do something" to trigger=

> some traffic from clientA onto the mesh network. This is problematic
> because it requires either physically accessing clientA (not practica=
l
> in our application) or manually ssh'ing into the node running batman
> and then connecting to clientA (makes for a challenging use-case)
>=20
> Is this expiration from the local translation expected?
>=20
> I've thought of a few hacks (make certain entries in the local
> translation table permanent, have a script on clientA which
> continually generates traffic) but I'm hoping someone else has though=
t
> about this same problem.
>=20
> Thanks!

Hey Jon,

this behaviour is intentional - the idea is to keep the translation tab=
le=20
clean with the timeout. Also other Layer 2 switches do that.

When using IP, what usually happens after not connecting to a certain h=
ost is=20
that the source host tries to request the IP again via a broadcast ARP =
packet=20
=2D and as soon as the destination replies, the local translation table g=
ets=20
updated. The ARP timeout should be considerably smaller than the 10 min=
utes=20
used for local translation table timeouts, and as far as I know there s=
hould=20
be a similar mechanism in IPv6.

That said, you should (in theory) always be able to SSH into your machi=
ne=20
since the ARP entry was timed out before anyway and needs to be refresh=
ed. Or=20
do you use some kind of static ARP entries, or other means which we did=
 not=20
consider?

Thanks,
     Simon
--nextPart1515330.GIYDjRvvcE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlRGah8ACgkQrzg/fFk7axYk/gCg5vhy59fSpTtd/ioxE5tFbO3D
HjoAoOULf5pAGRw9RvEMjBvsxfn/P+NO
=R48E
-----END PGP SIGNATURE-----

--nextPart1515330.GIYDjRvvcE--

