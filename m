Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 09 Oct 2013 20:05:18 +0800
Message-ID: <1865185.sMNWqjjBIC@diderot>
In-Reply-To: <20131009103515.GI8785@medion.lan>
References: <1380834133-10808-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <12447770.xO0R1XlQHM@diderot> <20131009103515.GI8785@medion.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4266902.I2yfO4lR6O";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix compat of
	net_ratelimited_function for >3.2.46
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart4266902.I2yfO4lR6O
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 09 October 2013 12:35:15 Bastian Bittorf wrote:
> * Marek Lindner <mareklindner@neomailbox.ch> [09.10.2013 12:28]:
> > > Appearently net_ratelimited_function was added to the stable series of
> > > from 3.2.47, which results in a lot of warnings when compiling against
> > > this kernel. This patch avoids this redefinition.
> > > 
> > > Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> > > ---
> > > 
> > >  compat.h |    2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > Applied in revision 227df84.
> 
> can this be backported to 'openwrt-routing' feed?

Is it urgent ? This weekend we planned to release the next batman-adv version 
which includes this fix.

Cheers,
Marek

--nextPart4266902.I2yfO4lR6O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABAgAGBQJSVUaCAAoJEFNVTo/uthzApBEIAJ4vfRBeT05yGmy9teNQr6ye
421WrYKfGKOsqUcjlOkZMu2NXHIfeilWRwLjD/gjmbycmYZKTtOwgFLD0bWBqaFU
1gRz5POUh0ydAsAjrb1ir8NvEJ503sRRautwsOtHUFibPpSafdIYreETFh6KMoPA
SQt5lH94B6hUIsjVWt4JSY+osf1ubrnALWqDvcZlaRFY7wXlX8aZnckE0tggbU/C
IdBavLtf9WyFmwsZ48BGaiXvDQic3OzG/2KTRmbSgpnkRXNgCy8ls8d6nHPI5316
JvQIz8IOaX+1A5UIzPRRA3Xvxoy2oGPNO5/bwrzAWCBWn9iEmmeJGTF3kYppF/A=
=6DsP
-----END PGP SIGNATURE-----

--nextPart4266902.I2yfO4lR6O--

