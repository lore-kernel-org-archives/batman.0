Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 07 May 2015 19:25:11 +0200
Message-ID: <4837729.AoYrTN5tco@prime>
In-Reply-To: <841E254B092F4FC1839DD066D90CE802@telegridtech.com>
References: <841E254B092F4FC1839DD066D90CE802@telegridtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2300185.9DZcTXyqsz";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] FW: using Batman-adv
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


--nextPart2300185.9DZcTXyqsz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Joseph,

On Thursday 07 May 2015 13:00:52 Joseph Zimmer wrote:
> Hello,
> =20
> I am working with BATMAN-ADV and have successfully setup a mesh. In m=
y
> implementation of the mesh, the network requires BATMAN to operate in=
 a
> linear topology and ideally have node 1 hop to node 2 then through no=
de 3
> and finally node 4.
> =20
>         Node1=85=85=85=85=85=85=85=85.Node2=85=85=85=85=85=85=85=85=85=
=85=85..Node3=85=85=85=85=85=85=85=85=85=85Node4
> =20
> In this network hops are preferred rather than distant links with low=
 RSSI
> values(-70).  The problem that I=92m seeing is that the protocol choo=
ses
> routes that have the least hops but have RSSI values at about -78 to =
=2D90
> rather than routing through the closest node with RSSI values in the =
=2D50
> range.
> =20
> We adjusted the hop penalty to a low value (we used 1 and 0) and we d=
id see
> improvement with the hop selection but the throughput is very low due=
 to an
> RSSI of -64 or less.
> =20
> Questions:
> =20
> 1)       Is there a way to adjust BATMAN using batctl to select route=
s based
> on the RSSI value?
> a.       That is, choose to hop through a node with an RSSI of -50 an=
d never
> select a node that has a lower RSSI

Nope, BATMAN only uses packet loss as a metric. It could be possibly ad=
justed=20
to do so or low signal links could be filtered otherwise, but we would =
consider=20
that a bad hack.

There is another suggestion: You could increase the multicast rate to a=
 high=20
value, e.g. 36 MBit/s or even higher. Higher rates only work with good=20=

signals, and since batman-adv uses broadcasts (which is multicast for W=
iFi),=20
this will have a direct effect on your network.

> 2)       Does the algorithm for route selection use RSSI in the calcu=
lation
> and if so can we modify the algorithm to increase the importance of R=
SSI in
> the selection?

It currently doesn't use RSSI

> 3)       How do we gain access to the code to make these modification=
s?

Batman-adv is open source, and so is mac80211 and hopefully the WiFi dr=
iver=20
you use. However, it'd really suggest to start with tuning the multicas=
t rate.=20
:)

Cheers,
    Simon
--nextPart2300185.9DZcTXyqsz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlVLn/0ACgkQrzg/fFk7axaVgQCcD9G1tBI7dR12SjnWLi5hragy
O88AoPAH0QAmEvotazSa+rgBIpxVFf6c
=4iF5
-----END PGP SIGNATURE-----

--nextPart2300185.9DZcTXyqsz--

