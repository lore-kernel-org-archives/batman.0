Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 15 Jun 2012 11:55:25 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120615095525.GA32707@pandem0nium>
References: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
	<CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
	<CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
	<CAHD-aqK_CGbc8u5GuEBJyFzrk2rTHHTw=bAiWjFafAW9xOqWiw@mail.gmail.com>
	<4FDA40A5.1050008@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <4FDA40A5.1050008@inti.gob.ar>
Subject: Re: [B.A.T.M.A.N.] link alternation when radios are not on
 batman-adv router?
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


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2012 at 04:51:01PM -0300, gtolon@inti.gob.ar wrote:
> Hi,
>=20
>     we are interested too in interface alternating, so we made some
> tests to understand how it works. As you can see on the attached
> sketch.png, we connected two pair of routers using their ethernet
> interfaces, E6 with E7, and E8 with E9. All of them have eth0, and
> an ad hoc interface, wlan0-1, managed by batman. E6 and E8 are in
> channel 11, whereas E7 and E9 are in channel 1. Besides we used two
> other routers, E12 and E13, both in channel 11, with their tx power
> set to just 0 dbm, to avoid a direct sight between them.
>=20
>     Then we sent traffic from E12 to E13. We expected that packets
> travelled from E12 to E6, and that E6 forwarded them to his eth0 to
> use the interface alternating feature, making traffic flow to E7,
> then E9, E8 and finally E13. But instead, we observed that the
> actual path was E12--E6--E8--E13. The resulting routes for each
> router are attached in a text file, and also the graph from the
> batctl vd dot command.
>=20
>     After this result, we read again the thread mentioned by Guido,
> specially in this part:
>=20
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-March/006344.html
>=20
>    And if we understand correctly, the alternation feature works
> after the batman path has been selected. So in our case, E12 looks
> at his table to know where to send a packet to E13, and finds E6.
> Then E6 receives the packet and looks in his own table, finding that
> the best path to reach E13 is E8. At this point, the alternating
> should work, but there's only one interface directly connected to
> E8, so the packet goes there, and so on. We think that if E6 and E7
> were not two different routers running batman-adv but they were two
> radios of the same batman-adv router, and the same for E8 and E9,
> the alternating would work, because the unique router would choose
> the best path, and then would find two possible interfaces to the
> same next-hop, changing the interface.

This is entirely correct - batman-adv has only one link to choose from
(E6 -> E8) to reach its best nexthop E8, so there is no way to
"alternate" the interfaces.

>     We'd like to know if this interpretation is correct, and in that
> case, if it were possible to use interface alternating in a case
> like this, with two routers connected to work together. Thanks!

Mhm, with the current implementation - no, unfortunately not. We would
need some kind of multipath routing to select between routes, this is
much more complex.

An alternative might be to use the routers E7/E9 as secondary routers
without batman, but only forwarding traffic between Ethernet and
WiFi. Then the "primary" routers (E6 -> E8) would think they have
an alternative route via Ethernet (because they don't see the
intermediate hops E7/E9). This comes with some caveats however, e.g.
4-addr mode in Ad-Hoc, you need some very simple ethernet forwarder,
and most probably other things I forgot.

Cheers,
	Simon


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk/bBo0ACgkQrzg/fFk7axa+fACgt2bWesFvMtOlej5ViJOsxXfA
j24AoOmyBtDNsBIeXsGK/HHc/NhBF09o
=S/6D
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
