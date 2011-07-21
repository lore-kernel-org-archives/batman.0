Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Jul 2011 11:23:11 +0200
Message-ID: <10936294.59BhBL2GsI@sven-laptop.home.narfation.org>
In-Reply-To: <CA+qXHzOAVeGYcnqjz_=goW2Yzc+oJ5y1GpAYDcH8EeGZssL=wA@mail.gmail.com>
References: <CA+qXHzNUGtLUpFqOmvKge05wLYyyoCpkTJG4HKwkd+Zzv81hYQ@mail.gmail.com>
	<8523816.3y33SjpCxy@sven-laptop.home.narfation.org>
	<CA+qXHzOAVeGYcnqjz_=goW2Yzc+oJ5y1GpAYDcH8EeGZssL=wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15619295.xQz9D2yiDy";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Filtering BATMAN-ADV packet
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
To: "Nik M. Anas Kamarudin" <nikanas@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart15619295.xQz9D2yiDy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 21 July 2011 17:14:28 Nik M. Anas Kamarudin wrote:
> AP mode? Sry, forget to tell, i using in ad-hoc mode. Maybe i explain
> more. I try to test batman-adv in MANET. In order to doing that, i
> need to make a scenario that have changing in topology. That why i
> need to filter some batman-adv packet, if not i need to move the node
> myself in and out of wireless range.  So, anyone have any idea how to
> filter batman-adv packet?

I already told you about it in the first mail what a solution could be. There
are two other solutions use the initial idea of ebtables and bridge.

The first one is to use 4 address mode with a compatible driver (I used
madwifi with one of the patches from http://madwifi-project.org/ticket/1131 ).

The second one (assuming that you are using a mac80211 based driver) that you
remove the checks at
 * http://git.open-mesh.org/?p=linux-
merge.git;a=blob;f=net/wireless/core.c;h=c22ef3492ee6f0b8f58f1d663c995a977a7bcc6b;hb=HEAD#l821
 * http://git.open-mesh.org/?p=linux-
merge.git;a=blob;f=net/wireless/util.c;h=4d7b83fbc32f0eb042e3a70e23d01d626a5add04;hb=HEAD#l854

and use the same MAC on the bridge and only one interface inside the bridge
(so the bridge is a transparent filter). I never tested it, but at least
sounds promising.

Kind regards,
	Sven
--nextPart15619295.xQz9D2yiDy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOJ+//AAoJEF2HCgfBJntGv9QQAIzy6osWyWavhXqFLiv/zMj3
6VAQfcDshKHWSe/SGCieiJhi/WKJLaEaSdWOefya//5FM6Z86I69nHMCmby5KhT/
Hrhrugi73oL+/ElIJIRyDj24GC035LW3261I62fFd2I1WSsMhvPdvwMBSJRMEooh
PtWrYYD5zpOzwb7NE++txR6h6mofKbW4X544evkUpvtJXZmTRMaaD2c9a6yl/kmq
o4gPOMOiC5DsaBl5wfqhHDzPL77XUkLoY6WahsKmCZsZs9QXx1EdZZPxQx4nUWce
HNUgNxdnSA73vNixyql9HoVUvyngukcPUIlaRHwrIXKCwxV9c9HCRqeCfaEuE+/i
y2cSHaE7a9bfqVrUV4EqvKC2z3y5HVrQPE5DBN4ujdbb9IcvrUL7k1aM5xzPzgSc
GYzlxTwx1UZbuk+kyutcJ/D1RC+2NLoybKxN94wSZ9ddIvVq2hHkTR+/d6Sk6toI
2pnh09Pwq/gIMJKaOvSlkp6tpna1btDxP16+nwNb50Cwh3ZwiCYeisXKRsmqNWOu
6Tx5NDBFLN9Tj0cz0AjO6SkakV6r30yf47NAFZUkfRsYRmb4eMRZKsZMWjx07Hzj
QXwsIDoYiVsOMug7dmc6GK2Cgdnahj6OkiGPE+lusrim3fZkJrlAZM0NXYmwvj4n
fkkBiTCrOKev6210X0C/
=k1D+
-----END PGP SIGNATURE-----

--nextPart15619295.xQz9D2yiDy--

