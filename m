Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 09 Nov 2012 14:15:26 +0100
Message-ID: <3285003.E6HttQ5L4c@bentobox>
In-Reply-To: <509CFA00.7000106@gmail.com>
References: <509CFA00.7000106@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2470322.G0zFtTdH7l";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] 11s mesh mode on openwrt + batman-adv
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
To: Flavio Leonel <frleonel@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2470322.G0zFtTdH7l
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 09 November 2012 10:41:36 Flavio Leonel wrote:
> hello friends
> come again disturb the lords
> 
> - I have a network with openrando opewrt customized by me, here in
> Brazil as jah reported in other emails, but this network is growing and
> am having some difficulties that I can not solve it alone ...
> 
> my ath9k driver operates today with 802.11s (mesh) on a virtual
> interface and another interface with 802.11g + n for wifi connections ..
> 
> but I'm from the beginning in 2011 fighting with routing in the network ..
> 
> AP: (config)
> Attached ...

There is nothing attached.

> eg not know where I really run batman-adv or even whether he really
> works well with HWMP ...

First: IEEE 802.11s (HWMP) and batman-adv are complete different things. 
Please don't use batman-adv over HWMP links. And you can check whether you are 
using batman-adv on an interface by checking the output of "batctl if". It 
should show you all interfaces which are attached at (and therefore known by) 
batman-adv (at least for bat0).

Kind regards,
	Sven
--nextPart2470322.G0zFtTdH7l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQnQHuAAoJEF2HCgfBJntGpDsP/iebNZhoDVW30DODcEv0hfm4
zpH4EDE7kCaHJTNyYSH03BoTSJrKtIw0jnakyHfRKvAhwTU0qlrglwMSjBleQmge
c90qta6a7ZG4gaFsTZVnrjIsKrwXLWY/ZMc6YsSdYUtMdVejBgESbTbTj8kR4keg
TBfHCM0wYRiEFwnuwvf6pYJpGMkSFNmCkrW1ew7nqVsVSypYazjbmj2Qm9J6SlTD
krBJmN113NyObky/4CeRYolv70+Pv7Q9R0cDVQCT8u1ZOZIG9RbWTvyEbq7QLVqS
R67tMp/B1zCZo2Y4au+i3KSWCIeJ2iXsMFF9X9Y89VL4UZfTBg68humrAo6IlDnK
iRQ24O1g/zF1166VwExMrtK32lBVGhOWMNanx+3Xz2t9mFLU+QcZYzvmBl03aZIZ
EhPf+IW5S0XimPabwFCTcWzA5EvoJNqWbluB4E3q+e09LL12QIRPHitIjxrnqOjW
pHVH3PnSecIUiMnQrGDVC8/gA7UcSkkGG7FgMRB2U+SeGF0VarHm65HKlCKhNowO
5omdnHp4H7n3kbNLHuPQZGQ+syB2vhylVNVvIzBG6+7uspVXN/22M5KxPXDIc7zg
3bI4r5h3hV1pL4SiajHLkjYoO1HAmXkhm+tyVF/Og4KDbLdzL5yhjiBeds3W8y4N
CC/oV8MkqM7EKYpyfdGv
=3Orh
-----END PGP SIGNATURE-----

--nextPart2470322.G0zFtTdH7l--

