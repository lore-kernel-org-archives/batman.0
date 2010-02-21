Return-Path: <linus.luessing@web.de>
Date: Sun, 21 Feb 2010 14:10:41 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100221131041.GA31011@Linus-Debian>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch> <20100211094659.GH2900@lunn.ch>
	<20100211100156.GI2900@lunn.ch>
	<20100219171905.GA17836@Linus-Debian>
	<20100220180411.GA15286@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20100220180411.GA15286@lunn.ch>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2010 at 07:04:11PM +0100, Andrew Lunn wrote:
> On Fri, Feb 19, 2010 at 06:19:05PM +0100, Linus L??ssing wrote:
> > Hi Andrew,
> >=20
> > Sorry, didn't have the time to try your patch any earlier, I'm
> > right in the middle of my exams :).
>=20
> Hi Linus
>=20
> Marek told me. No problems. I remember what its like studying for
> exams. However, it is nice to sometimes take a break and do something
> totally different.=20
>=20
> > Your patch already looks quite good, I couldn't reproduce any
> > memory leaks or crashes here (tried that with three routers and 1
> > or 2 vis servers activated, also activating/deactivating them a
> > lot, no problems with that). And yes, the slow-path warning has
> > gone with your patch.
>=20
> Great. So we are on the right tracks.
>=20
> > However, I'm having some weird output when connecting two routers
> > over wifi _and_ over ethernet cable. The setup:
> >=20
> > Before plugging in the cable:
> > r1-ath1 <-- wifi --> r2-ath1
> > ------------
> > root@OpenWrt:~# batctl vd dot
> > digraph {
> >         "r1-ath1" -> "r2-ath1" [label=3D"1.32"]
> >         "r1-ath1" -> "r1-hna" [label=3D"HNA"]
> >         "r1-ath1" -> "5a:2e:1e:1f:64:6b" [label=3D"HNA"]
> >         subgraph "cluster_r1-ath1" {
> >                 "r1-ath1" [peripheries=3D2]
> >         }
> >         "r2-ath1" -> "r1-ath1" [label=3D"1.11"]
> >         "r2-ath1" -> "r2-hna" [label=3D"HNA"]
> >         "r2-ath1" -> "82:31:95:f9:14:6f" [label=3D"HNA"]
> >         subgraph "cluster_r2-ath1" {
> >                 "r2-ath1" [peripheries=3D2]
> >         }
> > }
> > ------------
> > After plugging in the cable:
> > r1-ath1 <-- wifi --> r2-ath1 +
> > r1-eth0.3 <-- cable --> r2-eth0.3
> > ------------
> > root@OpenWrt:~# batctl vd dot
> > digraph {
> >         "r1-ath1" -> "r2-ath1" [label=3D"1.0"]
> >         "r1-ath1" -> "r2-eth0.3" [label=3D"1.66"]
> >         "r1-ath1" -> "r1-hna" [label=3D"HNA"]
> >         "r1-ath1" -> "5a:2e:1e:1f:64:6b" [label=3D"HNA"]
> >         subgraph "cluster_r1-ath1" {
> >                 "r1-ath1" [peripheries=3D2]
> >                 "r1-eth0.3"
> >         }
> >         subgraph "cluster_r1-ath1" {
> >                 "r1-ath1" [peripheries=3D2]
> >         }
> >         "r2-ath1" -> "r1-ath1" [label=3D"1.0"]
> >         "r2-ath1" -> "r1-eth0.3" [label=3D"1.15"]
> >         "r2-ath1" -> "r2-hna" [label=3D"HNA"]
> >         "r2-ath1" -> "82:31:95:f9:14:6f" [label=3D"HNA"]
> >         subgraph "cluster_r2-ath1" {
> >                 "r2-ath1" [peripheries=3D2]
> >                 "r2-eth0.3"
> >         }
> >         subgraph "cluster_r2-ath1" {
> >                 "r2-ath1" [peripheries=3D2]
> >         }
> > }
> > root@OpenWrt:~# cat /proc/net/batman-adv/vis_data
> > 06:22:b0:98:87:dd,TQ 04:22:b0:98:87:fa 251, HNA 00:22:b0:98:87:dd, HNA =
5a:2e:1e:1f:64:6b, PRIMARY, SEC 04:22:b0:98:87:de,
> > 06:22:b0:98:87:f9,TQ 06:22:b0:98:87:dd 255, TQ 04:22:b0:98:87:de 251, H=
NA 00:22:b0:98:87:f9, HNA 82:31:95:f9:14:6f, SEC 04:22:b0:98:87:fa, PRIMARY,
>=20
> Actually, this vis_data to does not map to the dot above!  There are
> the wrong number of HNA, wrong order etc.
Hmm, just noticed, the output also seems to be flapping between
those two from time to time:
------------------
root@OpenWrt:~# cat /proc/net/batman-adv/vis
06:22:b0:98:87:dd,TQ 04:22:b0:98:87:fa 251, HNA 00:22:b0:98:87:dd, HNA f6:a=
e:97:b3:9a:5c, PRIMARY, SEC 04:22:b0:98:87:de,
06:22:b0:98:87:f9,TQ 04:22:b0:98:87:de 251, HNA da:3e:79:2c:d3:3e, HNA 00:2=
2:b0:98:87:f9, PRIMARY, SEC 04:22:b0:98:87:fa,
root@OpenWrt:~# cat /proc/net/batman-adv/vis
06:22:b0:98:87:dd,TQ 04:22:b0:98:87:fa 251, HNA 00:22:b0:98:87:dd, HNA f6:a=
e:97:b3:9a:5c, PRIMARY, SEC 04:22:b0:98:87:de,
06:22:b0:98:87:f9,TQ 06:22:b0:98:87:dd 255, TQ 04:22:b0:98:87:de 251, HNA d=
a:3e:79:2c:d3:3e, HNA 00:22:b0:98:87:f9, SEC 04:22:b0:98:87:fa, PRIMARY,
------------------

>=20
> Here is what i think your bat-host file contains:
> 06:22:b0:98:87:dd r1-ath1
> 06:22:b0:98:87:f9 r2-ath1
> 00:22:b0:98:87:dd r1-hna
> 04:22:b0:98:87:de r1-eth0.3
> 00:22:b0:98:87:f9 r2-hna
> 04:22:b0:98:87:fa r2-eth0.3
>=20
> and this is what i get, assuming i got the MAC->name mapping correct:
Yes, correct mapping :).

>=20
> digraph {
> 	"r1-ath1" -> "r2-eth0.3" [label=3D"1.15"]
> 	"r1-ath1" -> "r1-hna" [label=3D"HNA"]
> 	"r1-ath1" -> "5a:2e:1e:1f:64:6b" [label=3D"HNA"]
> 	subgraph "cluster_r1-ath1" {
> 		"r1-ath1" [peripheries=3D2]
> 	}
> 	subgraph "cluster_r1-ath1" {
> 		"r1-ath1" [peripheries=3D2]
> 		"r1-eth0.3"
> 	}
> 	"r2-ath1" -> "r1-ath1" [label=3D"1.0"]
> 	"r2-ath1" -> "r1-eth0.3" [label=3D"1.15"]
> 	"r2-ath1" -> "r2-hna" [label=3D"HNA"]
> 	"r2-ath1" -> "82:31:95:f9:14:6f" [label=3D"HNA"]
> 	subgraph "cluster_r2-ath1" {
> 		"r2-ath1" [peripheries=3D2]
> 		"r2-eth0.3"
> 	}
> 	subgraph "cluster_r2-ath1" {
> 		"r2-ath1" [peripheries=3D2]
> 	}
> }
>=20
> batctl parses top-to-bottom, left-to-right. It does not consolidate
> the PRIMARY and the SECONDARY into one cluster. It leaves DOT to do
> that. Hence there are two cluster statements for each cluster actually
> drawn.
>=20
> > So the second 'subgraph "cluster_r1-ath1"' is obviously
> > unnecessary.
>=20
> Yes, unnecessary, but makes the batctl code easier.
>=20
>  Also "r1-ath1" -> "r2-eth0.3" looks wrong, should be
> > "r1-eth0.3" -> "r2-eth0.3" instead (and the same with r2 a few
> > lines later).
>=20
> These comments i agree with. A wireless and a wired device should not
> be neighbours. We don't have any records which originate from the
> secondary MAC address. That is guess is the major problem here.
>=20
> So, did my/Mareks patch break it, or was it broken before?
>=20
> First i suggest you go back to just before Simon's patch which
> introduced receiving using skbufs:
>=20
> http://open-mesh.org/changeset/1517
>=20
> That will tell us if we need to go back further, or our patch broke
> it.=20
>=20
> If you need to go back further, i would suggest just before:
>=20
> http://open-mesh.org/changeset/1510
Okay, just checked, this got introduced with 1510 already, yes. I
might have a closer look at this next week.

Cheers, Linus

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLgTDRAAoJEBKw7u43QNpf1QsP/05WUQEH4ds7RauE0p9q8F68
W6StHRS9mG4mv2sO/Af34Vx4rCNfx1KCW8DKrZrmbznLqPPLCwTwmVjt0nopU8fx
72FZ/GvsmyqC6wRJY5aCD9VpIfVueN+t2WQvIMzGGG3cfnagtPhjawjQlO48tHPW
Zunr9WWU4YF3uo9QZr1JW9xSJlHNdImQWiENPvf8WnAujFoN4JCw1mR/nREF/QJa
/n5k1huUgPeARKPob/0mTFjG1D85V6/oz3K1iwsIYNSXvPHn/PbTeWzfKb4np8uL
vdqm0zsrBkHX2STkCqLIPUge/fpFNnd/3LCfHlmrvtIhgiMLtB6DRkS+JEPuhOxz
bmp/5HJg7NmGStMSyqAkelAgyvoKpPIzz44pz04qR0+C2w84Xn5LRSxoRoRqcb1n
Tew/xfebjx1U45pxzFjUn5NwZRw3sKImsyqMkKicExJEDVBAU2jYx1wHCUcwOUgU
hdOLTNL+aAFdtVFH6dsSGk4BzocotfpZM2vL3DF+UYs0mKInegJ6Fbnmk4yAWKQD
PAwZ94VJsYAKUhnMuDx+sJkxEqX55EFwrAtTCcFNDwA3JXbzN0rwV54llrz6BPIC
GoKzlV+IQzai2Akw2YqWZOVsh36kK3voP/f2ECZf9qdWoUiflCjXmiYm3vZxPrzv
jQnRrEY3UyLb0yLXsffp
=CUMi
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
