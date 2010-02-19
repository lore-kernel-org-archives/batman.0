Return-Path: <linus.luessing@web.de>
Date: Fri, 19 Feb 2010 18:19:05 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100219171905.GA17836@Linus-Debian>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch> <20100211094659.GH2900@lunn.ch>
	<20100211100156.GI2900@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20100211100156.GI2900@lunn.ch>
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


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Sorry, didn't have the time to try your patch any earlier, I'm
right in the middle of my exams :).
Your patch already looks quite good, I couldn't reproduce any
memory leaks or crashes here (tried that with three routers and 1
or 2 vis servers activated, also activating/deactivating them a
lot, no problems with that). And yes, the slow-path warning has
gone with your patch.
However, I'm having some weird output when connecting two routers
over wifi _and_ over ethernet cable. The setup:

Before plugging in the cable:
r1-ath1 <-- wifi --> r2-ath1
------------
root@OpenWrt:~# batctl vd dot
digraph {
        "r1-ath1" -> "r2-ath1" [label=3D"1.32"]
        "r1-ath1" -> "r1-hna" [label=3D"HNA"]
        "r1-ath1" -> "5a:2e:1e:1f:64:6b" [label=3D"HNA"]
        subgraph "cluster_r1-ath1" {
                "r1-ath1" [peripheries=3D2]
        }
        "r2-ath1" -> "r1-ath1" [label=3D"1.11"]
        "r2-ath1" -> "r2-hna" [label=3D"HNA"]
        "r2-ath1" -> "82:31:95:f9:14:6f" [label=3D"HNA"]
        subgraph "cluster_r2-ath1" {
                "r2-ath1" [peripheries=3D2]
        }
}
------------
After plugging in the cable:
r1-ath1 <-- wifi --> r2-ath1 +
r1-eth0.3 <-- cable --> r2-eth0.3
------------
root@OpenWrt:~# batctl vd dot
digraph {
        "r1-ath1" -> "r2-ath1" [label=3D"1.0"]
        "r1-ath1" -> "r2-eth0.3" [label=3D"1.66"]
        "r1-ath1" -> "r1-hna" [label=3D"HNA"]
        "r1-ath1" -> "5a:2e:1e:1f:64:6b" [label=3D"HNA"]
        subgraph "cluster_r1-ath1" {
                "r1-ath1" [peripheries=3D2]
                "r1-eth0.3"
        }
        subgraph "cluster_r1-ath1" {
                "r1-ath1" [peripheries=3D2]
        }
        "r2-ath1" -> "r1-ath1" [label=3D"1.0"]
        "r2-ath1" -> "r1-eth0.3" [label=3D"1.15"]
        "r2-ath1" -> "r2-hna" [label=3D"HNA"]
        "r2-ath1" -> "82:31:95:f9:14:6f" [label=3D"HNA"]
        subgraph "cluster_r2-ath1" {
                "r2-ath1" [peripheries=3D2]
                "r2-eth0.3"
        }
        subgraph "cluster_r2-ath1" {
                "r2-ath1" [peripheries=3D2]
        }
}
root@OpenWrt:~# cat /proc/net/batman-adv/vis_data
06:22:b0:98:87:dd,TQ 04:22:b0:98:87:fa 251, HNA 00:22:b0:98:87:dd, HNA 5a:2=
e:1e:1f:64:6b, PRIMARY, SEC 04:22:b0:98:87:de,
06:22:b0:98:87:f9,TQ 06:22:b0:98:87:dd 255, TQ 04:22:b0:98:87:de 251, HNA 0=
0:22:b0:98:87:f9, HNA 82:31:95:f9:14:6f, SEC 04:22:b0:98:87:fa, PRIMARY,
----------
So the second 'subgraph "cluster_r1-ath1"' is obviously
unnecessary. Also "r1-ath1" -> "r2-eth0.3" looks wrong, should be
"r1-eth0.3" -> "r2-eth0.3" instead (and the same with r2 a few
lines later).

Cheers, Linus

On Thu, Feb 11, 2010 at 11:01:56AM +0100, Andrew Lunn wrote:
> On Thu, Feb 11, 2010 at 10:46:59AM +0100, Andrew Lunn wrote:
> > Hi Linus
> >=20
> > Here is a new version of the patch. I've tested it this time using
> > five UML machines. It should not immediately opps now.=20
>=20
> Instead is will leak memory and crash after a while...
>=20
> I will try to find the memory leak.
>=20
>   Andrew
>=20

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLfsgJAAoJEBKw7u43QNpfVbIP/3Zw5YGrKBowmXDmTHyxM4Et
fvaMhXd+q7s1tPTdt7ejxxG5OGh4aiVWSIo/8vfudIGYGuMd131Z/ByMC6jekFzJ
zQXfQ6V0i9DS1cljXMijoYZK8Rl7ZVw3eZDFzBsEXrfvXEJT3hdjrqTJHzopr2lX
K+Roy3IyW3BIvSkth1qDdgj65JJhXB/jKt77e/fwzLA24e5e1s+RTEFFDYF1Z5mm
gDtHCDns+JNrJo6qoWpAapMKj1WRFOA6bzSAdDojUByll9PbxOYIJNi6Dzhyy4rc
ua5vWROni9pVixmSsdUNbm42WLedpSy5OW3XMMYPj4fzxtmfYDCftMdlP5HWN6bn
MXFNqDmCUCSSAHycejRkVeBEfs6oF9sMiWYk1uTK+v9Ubdd20Ydjpaut07AJK50f
CcdvtnpsFo7zS8+7gGrxa0Y+Rdxbz89ZzEc8X4EgodqJeInEGKiUi4Hz5lTAVqMv
wZ9SvFb52XvoxMamPKWfD67GBq8PeDKyx1z3OnYEo8z3xXJNnfSwhF8okmQOtYhQ
KsXBCr4Il88k10wY/btfvrc+ETb1gTjXuGjh11mNOaC4AnagTuefMuPyl7DlMCMC
3I5L4orUSnrsgDtpUD+mA3cQ6EJwp1I+axI1B440qF4xpPunyNuvx4vVYDjnkAS6
USOuHPQROGAv6+akz5zW
=31WT
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
