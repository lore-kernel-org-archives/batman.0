Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Mar 2016 10:38:21 +0800
Message-ID: <6005839.o5jWIFZeG0@voltaire>
In-Reply-To: <56F5C782.6050009@t-online.de>
References: <56F5AF2F.6060904@t-online.de> <1575797.YB1vrtWgyD@sven-edge>
 <56F5C782.6050009@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2134642.TBcN4JjJ5o";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

--nextPart2134642.TBcN4JjJ5o
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Roland,

> Thank you for response. When looking at
> "https://patchwork.open-mesh.org/patch/4384/" it seems, the patch isn=
't
> implemented because of no more activity after 2 years of discussion.
>=20
> AFAIK Linus L=FCssing, author of the original patch, is still active =
in
> batman-adv project:
>=20
> Linus, can you please bring this issue to a good end? There will be a=

> lot of Freifunk friends happy with it - including me.

if you are advocating in favor of this patch I see no real need to wait=
 for=20
Linus. Maybe you can help us understand what this patch does and why it=
 is=20
useful. These were the questions raised in https://patchwork.open-mesh.=
org/patch/4384/ and remain unanswered till today.

I am also unclear why this old patch is re-hashed once more since we me=
rged a=20
patch 3 years ago achieving the same goal without a manual knob. Can so=
mebody=20
shed some light on this ?

The patch in question:
commit cc1fde312b6d3c010784a80aff9e942e3b16d015
Author: Matthias Schiffer <mschiffer@universe-factory.net>
Date:   Sat Mar 9 23:14:23 2013 +0100
Subject: batman-adv: send each broadcast only once on non-wireless inte=
rfaces


> On 12.03.2015 Ticket #207 was opened by Ruben Kelevra relating the sa=
me
> issue, but immediately closed due to formal error.

It might appear as a nuisance to you but it is standard Linux kernel pr=
actice=20
to send patch submissions to the mailing list. That is why the ticket w=
as=20
closed.

Cheers,
Marek

--nextPart2134642.TBcN4JjJ5o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW90edAAoJEFNVTo/uthzAjbsH/i6DX2j+pmWPy5LaXzHo6sqK
7VMyhUoB4FbT8281vPPoLYMMuIPZjQrM0c6/pDb1LxOOIWGZJJ/2HOoPhAJGmOkn
Gl0ys5LlMxHqOlu4HhdaR5Mxo0Y8Ha/+HS2FXzmPv8daptMbM96goN4uiYT+5DH6
McQazmoZg0VTSd1q2guYjIyhO/9GToBt1lQdc/vBzYfwts0P1subFvMhASFFxWSI
6fn7hZsnWC9dhFsXPmoDcrhNwhPkqevsvw9aRDcGthmg2MFsmNX9u49CBzY6ys/z
GssN7qQZ774FmwvOFQ9VKyBYLKq9b/qjJYjL4vfTgFDDBGL3XVSH75DUTT1yGVw=
=7r2b
-----END PGP SIGNATURE-----

--nextPart2134642.TBcN4JjJ5o--

