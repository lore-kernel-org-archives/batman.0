Return-Path: <ordex@autistici.org>
Date: Wed, 6 Jun 2012 08:53:38 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120606065338.GB12262@ritirata.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
	<1773376.eftnT4ifSy@sven-desktop.home.narfation.org>
	<!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPNuGB5hMDtNhUs29egcVLUBAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPNuGB5hMDtNhUs29egcVLUBAAAAAA==@gmail.com>
Subject: Re: [B.A.T.M.A.N.] bridging problem
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


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Walter,

On Wed, Jun 06, 2012 at 12:16:07AM +0200, Walter Robert Ditzler wrote:
> so my question is:
> 1) do i need 2 wireless network card for each batman host?

This would probably be the best choice, but it is not always possible. Like=
 in
your case, your box has only one wlan device.
What you can do is to create more VIF. Each wireless device is represented =
by a
phy interface (phy0 in your case) and on top of it you can create more than=
 one
Virtual Interface (VIF). Actually, when you issued the command:

iw phy phy0 interface add mesh0 type adhoc

you are creating a VAP named mesh0 on top of phy0. What you could do to ach=
ieve
your goal (and what we usually d in the same scenario) is to create another=
 VIF
which will be used as AccessPoint interface.

At that point you will have=20
- mesh0, that will be put in bat0
- ap0 (or whatever the name you chose)

Now I think you know what to do :-) You can bridge bat0 and ap0!

Here is a link that explains how it works:
http://linuxwireless.org/en/users/Documentation/iw/vif/


Cheers,

> 2) can i connect tot he batman mesh essid to get access the base lan?

You want to use ap0 at this point.


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPzv5yAAoJEFMQTLzJFOZFLrUH/1LDsHT+Q/9Ax3jeGhEP0GHT
pnTw7HGEUcmmZcBa8MdRxntRFfIwqcemNvnliN1+9jFP8rXFdaROpmHyN6Sg9QmJ
2Kc8DDQ3sbG76WqeKOMw5Qg1xO9UiMe/rUSujgZmBB3pR5tplzuMKFmWI1q+Kzt/
43J9iGe2s6MVn0gd++qyQ+1YGCBbOJMTVfjVv2NyLI5daKxuZuvWXgeyR2OCN/zy
i4XnLtIVQ1mMJ3o55lWfS0BDwnRQ9eVKV2mHCOMR7A2kzLmNGM1xGMzbMHk2FIn1
SM/7ppkO5xKhwp4WrfEID2zhL5/TZq4IYLPOng51027bDLYiVrhOJQ4DfogH7SA=
=SgMy
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
