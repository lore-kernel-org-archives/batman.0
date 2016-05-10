Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 May 2016 05:14:36 +0800
Message-ID: <14631712.0fzM9k8hTT@voltaire>
In-Reply-To: <20160510145705.GB22414@prodigo.lan>
References: <1462890719-2146-1-git-send-email-mareklindner@neomailbox.ch>
 <20160510145705.GB22414@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12835150.4iWiOO02TP";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: init ELP tweaking options
	only once
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart12835150.4iWiOO02TP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 10, 2016 22:57:05 Antonio Quartulli wrote:
> On Tue, May 10, 2016 at 10:31:59PM +0800, Marek Lindner wrote:
> > The ELP interval and throughput override interface settings are
> > initialized
> > with default settings on every time an interface is added to a mesh.
> > This patch prevents this behavior by moving the configuration init to the
> > interface detection routine which runs only once per interface.
> >
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> 
> Acked-by: Antonio Quartulli <a@unstable.cc>

Applied in revision 71e957c.

Cheers,
Marek

--nextPart12835150.4iWiOO02TP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMk88AAoJEFNVTo/uthzAW+gIAJuEk2qC/4bfN/xG5z+ywsmL
vJ0R1orAo/DyHJmS2ECOKzZ91+naVyD3K5n7pLiFm2XM1g0sYWgXx9Da6ijSqAXE
B3n6EFQim04ddT5K9KqnYrSQh+axQJI8175fw+BC16WQCC9MSD/2kco9TAmJasQq
aK6EfE7EqHUUYnaIQ9RnN1FWA6moTz6jZsrxrhvRzL9Bgylyg9nPYVeJijCoLZH1
EbixctyyM3K3Hj43eJ/ocy2IkC5w2jKmS5WWrQjltJj+J4GCORRBr/miXLKk+Jql
DHaH5XZ75ghFXUJ4olm0smgibYDMSpMu6yB3Q5T5VPF5g5o4vsbQgOdLTqmzHd0=
=kT+r
-----END PGP SIGNATURE-----

--nextPart12835150.4iWiOO02TP--

