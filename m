Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 06 May 2016 09:53:26 +0200
Message-ID: <38489328.JjMjPGWWVN@sven-edge>
In-Reply-To: <41788197.Cke9H3Q0EA@sven-edge>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
 <20160506023434.GA16484@prodigo.lan> <41788197.Cke9H3Q0EA@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6502022.RIkNh21xhl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: remove useless inline
	attribute for sysfs helper function
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
Cc: Antonio Quartulli <a@unstable.cc>, mareklindner@neomailbox.ch

--nextPart6502022.RIkNh21xhl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Friday 06 May 2016 09:23:40 Sven Eckelmann wrote:
[...]
> Kerneldoc cannot parse these kind of substructures. Just run:
>=20
>    scripts/kernel-doc -html net/batman-adv/types.h > test.html
>    chromium test.html
>=20
> It just creates random noise from your kerneldoc input. So one way to=
 deal
> with it is to create a substruct hacks parse functionality for kernel=
doc or
> avoid these kind of anonymous-type substructs and use extra correctly=
 typed
> structs.
>=20
> You can contact Jonathan Corbet and inform him that these kinds of th=
ings
> are not "correctly" parsed (and don't use dirty hacks to creat
> kerneldoc-sections like struct sockaddr_caif used for its union kerne=
ldoc).
> Maybe with a small example.

From=20https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt=


> Nesting of declarations is not supported.

So you either have to add it to kernel-doc or do it differently.

Kind regards,
=09Sven
--nextPart6502022.RIkNh21xhl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLE12AAoJEF2HCgfBJntGjgoP/2zMACuV4FQsmCKs4ueaEijf
FW39zFRSU1GJEgVaqby8ZuSzhawty5aa5gDylxkQIAOYQupjma1mc3G3Ps44hEs/
oXn3j4UzPCZg0z39PtK+9x9RbSHJJuDPfF6suHcC1RbDknX6i8K9k9UeOKn/zqJz
sGPh14UkGfcSeLJTVhUw/gw2D2dqTNnZj4LtRA48sbymHZNG0/d/N34OKkk8eAar
CGuLEld8pZGLIQhyoX+2sbsWsYhBU1+Fjm+RsRW/mEvs6CA0db5SMl+sgLEKNkXw
Mylg0p1mRaVDpc/nm9GWHRPinvatCRPraUeME8OFzlq6aa8eyyFlAj/aHRdQDo0I
soJtRTYBoeEudsv7o3pWO/q4qGgSx/Voe/DVIT8CSBXgtpudkgwfuLJgUL3RfSHl
nG9jYJSXJ2Guezs7QCLNI7hf7McIppXZt4WQZcQtRs2Ip4DC3U7RHB4/9B5bY20L
LBQeHeHafJl9bfef/jkOXf2ZAUoHUYkY1aHYrW03SPZ+pBT3iQwk1NGIxS7CkNiK
7autY9s9UU1pt13ux6pvwdGL/BBlvVdJGYFd5vysiKMAafXLqs9FV6/GS9/mB0nN
mFn4Il8+SDJGyeOJVSLK2ATqZ+ABWG/2hlVli5CES2tq4WGWgtUWpWGWPLc1oPVP
mkJa+/wYSR6y4YfLheCx
=l/Zu
-----END PGP SIGNATURE-----

--nextPart6502022.RIkNh21xhl--

