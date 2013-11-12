Return-Path: <antonio@meshcoding.com>
Date: Tue, 12 Nov 2013 22:54:42 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131112215442.GN3713@neomailbox.net>
References: <525B11F2.5030605@altermundi.net> <5282A184.1020704@altermundi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YuJye9aIuN0w6xGV"
Content-Disposition: inline
In-Reply-To: <5282A184.1020704@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] mad mad batman ...
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


--YuJye9aIuN0w6xGV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nico,

I have no real clue, but is it possible that there is a loop somewhere? I
imagine you have checked already..but I can't come with something more usef=
ul at
the moment..

Cheers,

On Tue, Nov 12, 2013 at 06:45:40PM -0300, Nicol=C3=A1s Ech=C3=A1niz wrote:
>=20
> back in Quintana... this problem is still showing in every node. The netw=
ork is unstable and so it's difficult to debug. If anyone has a clue as to =
where to look for the origin I'll be glad to read your thoughts.
>=20
> cheers,
> Nico
>=20
>=20
> El 13/10/13 18:34, Nicol=C3=A1s Ech=C3=A1niz escribi=C3=B3:
> > While I'm still in Europe I've observed that the network in Quintana has
> > started performing very poorly today. It was working perfectly fine
> > until yesterday.
> >=20
> > The logs on every router have started showing entries like these:
> >=20
> > Oct 13 18:09:43 frigorifico kern.warn kernel: [12018.150000] br-lan:
> > received packet on bat0 with own address as source address
> > Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.040000] br-lan:
> > received packet on bat0 with own address as source address
> > Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.040000] br-lan:
> > received packet on bat0 with own address as source address
> > Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.550000] br-lan:
> > received packet on bat0 with own address as source address
> > Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.550000] br-lan:
> > received packet on bat0 with own address as source address
> > Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.570000] br-lan:
> > received packet on bat0 with own address as source address
> > Oct 13 18:09:45 frigorifico kern.warn kernel: [12020.580000] br-lan:
> > received packet on bat0 with own address as source address
> > Oct 13 18:09:46 frigorifico kern.warn kernel: [12021.040000] br-lan:
> > received packet on bat0 with own address as source address
> >=20
> > As you can see there are many per second.
> >=20
> >=20
> > I've pasted a bit of batctl ll batman; batctl log here:
> >=20
> > http://pastebin.com/HX1LBPK4
> >=20
> >=20
> > ...it's only showing the "originator packet from myself" lines and one
> > line before. (the sample is less than 5 secs of logs)
> >=20
> > Every node I checked is showing the same.
> >=20
> >=20
> > Last time this happened it was due to a router that had been affected by
> > a nearby lightning bolt. The switch went crazy.
> > It took a while to detect it and the network was 15 nodes big. Now it's
> > 40 and we are quite far away :)
> >=20
> >=20
> > If anyone has an idea of how to better test where the problem is
> > originated, I'll be glad to hear it. Also if any batman devel wishes to
> > log in to the net to check first hand, just let me know.
> >=20
> >=20
> > Cheers!
> > Nico
> >=20
> >=20
> > PS: batman version is 2012.4
> >=20
>=20

--=20
Antonio Quartulli

--YuJye9aIuN0w6xGV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSgqOiAAoJEADl0hg6qKeO0w8P/08pVnaQpnGXqq+P/L5nl9TF
TxFw8+T9W/0bayrzzZYz8Wec+gDRuAy8gi9nU9qvFIHAqbGu61GBdrZvB+rMLVTH
yAUtViNMcERegfEPXOk3WIngY1LFWsHgtdElvORaxWg/N6pYQDZo1FgqlnQDGfzK
GEk0RdPBH1DCoPS0KHMDiZbs/c3e8FTTz04hbskLoyGL6qo3PEwzSYuQMXjaZjIg
q+4HyHqQdNj7ktWUlaC9lhFgv6dhguT9YnLRHxACCNNh3Qxrs8MtXsAT3SuqhuVu
q1Y+Rm5+EBzBjiPyzFnnoFC62r5jsMNyd3B08HsqfJFUaZRugVjxcLl9u/xy6dXP
u4b0bdtFoyQDIK9TDmUEg1i5Fw1g5kp1/qdVab29TqEnZ4BHNOZA2CLyRt6WMi8Q
coM3EQQD/fjM0ruPdluZt0BYz66RFnOVe49CanALHzMpOiRR/Z3gtowZnSokpnfW
uNPvMVhdT7/lZcwPfKQ6ypvdItKhO3LLO99KvFz59yGq3IzSPpcKH/7esTgmYnih
0PsN3JXueCu+zOLrGR5C23HfXBmSQZdtN36fB1YzpQFe9rZE/4D98Nr4EByspyhj
gk4HSjoXO5JkLbXGbbNd7/GqxGU/LPgl8bp2Ni20ezmKlPineRxqo66xPEKGMDhG
lxIqKpivHWZYR2gO0OJQ
=BYzm
-----END PGP SIGNATURE-----

--YuJye9aIuN0w6xGV--
