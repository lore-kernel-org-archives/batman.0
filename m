Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 25 Sep 2013 23:03:48 +0800
Message-ID: <1680806.MqrY0WE4J8@diderot>
In-Reply-To: <20130924145723.GN18530@Linus-Debian>
References: <1380030033-11533-1-git-send-email-linus.luessing@web.de>
 <20130924134650.GP3911@neomailbox.net> <20130924145723.GN18530@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1684891.YT7NJCyhcq";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce 'no_rebroadcast'
	option
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


--nextPart1684891.YT7NJCyhcq
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 24 September 2013 16:57:24 Linus L=FCssing wrote:
> On Tue, Sep 24, 2013 at 03:46:50PM +0200, Antonio Quartulli wrote:
> > On Tue, Sep 24, 2013 at 03:40:33PM +0200, Linus L=FCssing wrote:
> > >=20
> > >
> > > Using this option wrongly will break your mesh network, use this =
option
> > > wisely and at your own risk!
> >
> >=20
> >
> > Exactly for this reason (As we discussed on IRC) I think this mecha=
nism
> > should be reasoned a bit more.
>=20
> Hm, my personal reason to want such a feature is included, the VPN
> example. And since I know that using batman-adv over VPNs is not
> uncommon, I'd love to have this feature upstream.

Admittedly, I haven't followed the entire discussion but what speaks ag=
ainst=20
setting the rebroadcast count define for non-wireless to 0 ? Matthias (=
if I am=20
not mistaken) provided a patch for the wireless / non-wireless distinct=
ion not=20
too long ago.=20
Seems way easier as we are looking for a quick and temporary solution ?=


Cheers,
Marek

--nextPart1684891.YT7NJCyhcq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABAgAGBQJSQvtYAAoJEFNVTo/uthzAwXwH/3bsAze41wO7zUxbUFd+QkD3
p0U+HQwFaMixTFXwp/MuIJmkAS9rU4OuAHrEBpY1QJVkwzC8B/CuxA1T0WqSZ+X5
YAGo4ZTY+ChD0mXM5Kiirnu6ddKYVBdfkkd+Fb0+1LvrKaXzUqKsfiIEkBdJDtpt
AvCQ7a05zEfdbao9FaBAwB+X1gHWusjFCbH27JnfbRGEpxN8+8yUrh/pXrMYwdVT
jfELz9qN4dOXmZiepAXPs/MDnGfULlE9cTNAsrZulFG+EXTuaDD8EY0VhHkXSNYT
weg77O97csFO2quqacN1OdKa+vADYb9YMbzlihJ/5ucwe2iuEtNJnfe3uSHgByM=
=qnuB
-----END PGP SIGNATURE-----

--nextPart1684891.YT7NJCyhcq--

