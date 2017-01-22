Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 14:08:50 +0100
Message-ID: <7073965.bG8vkJTefB@sven-edge>
In-Reply-To: <20161219112535.9446-1-linus.luessing@c0d3.blue>
References: <20161219112535.9446-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5482144.VeDrOFFecI";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH 0/6] batman-adv: broadcast packet
	aggregation
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

--nextPart5482144.VeDrOFFecI
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 19. Dezember 2016 12:25:29 CET Linus L=FCssing wrote:
> Hi,
>=20
> Here is a first patchset to reintroduce aggregation support for BATMAN V,=
 too.
> And while at it, for BATMAN VI, VII... etc, as well - in fact, it allows
> aggregating any batman packet with a broadcast destination ;).
>=20
> I am sending it as an RFC for now as compat code is still missing. And al=
though
> it was tested in VMs, I still need to do some stress testing on some
> embedded routers.

I have not actually looked at the code. But I would guess that your ultimate
goal is to reduce the overhead when sending broadcast either over wifi or
complex setups with things like VPNs (fastd). Did you do some captures on s=
ome
gluon supernodes (or actually only on a link to this supernode) and calcula=
ted
how many packets/bytes were sent over the DSL (up/down), how much overhead =
was
added, how many packets would potentially be aggregated by your approach and
how many packets/bytes would have been send over the DSL (up/down)?

Sounds to me at least like something which could be done on some existing
setups with some small script/program reading a pcap, creating some input
for some simulator and then sending this data through the actual simulator.=
=20
And this all without having to actually break a working system :)

I think Simon (or I should also) have a very recent dump for a 2 1/2 days t=
est
which captured (bcast/mcast/batman overhead) data from a spare Freifunk
Vogtland node (its ethernet port) without any clients attached. This would =
be
a potential source of test data (which we would have to anonymize for the
simulator input).

Kind regards,
	Sven
--nextPart5482144.VeDrOFFecI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliEruIACgkQXYcKB8Em
e0YwXw//bd42rSVHwDhi8+cf0wfHO1XCXyqXPgJH4+qnEcH8HAfLPYM7Y4uJHYVf
y73PbaB43xGtnl9TLD2XDMxT6A/Ji2+jKPVoGQNGb1GZ25ahXaX/uXEhDYuBZ2m8
MBkpWjEsWEgkj67KPPaaw/QPS0j9ObLeZDymISj18x3T1ibe4/rnhqT0NWKNVUK+
G02EFSLzNfczWBtyfx9W4ocDnpBo7ib7dsSmvuvD/IuVyRcrgtstkAv3Q9bRYehX
+re2qLbAcAjf3TQhui8lCdWkYdS8GJo6P4jVIXuJLxn93JITFaXuYoZcpBt+N2Y5
k+m9kIRCp6AsmGax+AxMNVHT2dVnd0u+ZCqN3nS7emp9X8euAYNnV2VrNVWKkgJP
tFaU1bqlmMgOr6f/HHgXrjJTNIG8IamNpbTEWEXfUb8eullDzpt/TzlxnUe8k6hC
06ZJNgQWzKipOyauklNdVK5u5lSuTFfqb/KpekF8fg/QXnGHuIGXhmOdiTC0iYzR
YeHVDGrPAwnb2GCv8Y5inWpA0Qng07yh2dh9hlm/gkqX7WMODk81XsJCZ3aLqJX+
x077X+mjKggbPw19r2uc/h4l16ZMIxvHrqecQZuK9m7cuwmlqysMGK04WlCIOQ9a
l07bCMJkEZaVshYdCWVMEBUCFJjTylzd1SG2yfHHWo4TYCofIQM=
=ATIy
-----END PGP SIGNATURE-----

--nextPart5482144.VeDrOFFecI--

