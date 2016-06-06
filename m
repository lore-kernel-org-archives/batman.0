Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 06 Jun 2016 23:46:08 +0800
Message-ID: <1902724.Bv5SF6Mgqj@voltaire>
In-Reply-To: <20160606154402.GM13158@prodigo>
References: <1464439110-3113-1-git-send-email-sven@narfation.org>
 <20160606154402.GM13158@prodigo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2401882.Gt4OllkToA";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Clean up untagged vlan
	when destroying via rtnl-link
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

--nextPart2401882.Gt4OllkToA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 06, 2016 23:44:02 Antonio Quartulli wrote:
> On Sat, May 28, 2016 at 02:38:26PM +0200, Sven Eckelmann wrote:
> > The untagged vlan object is only destroyed when the interface is removed
> > via the legacy sysfs interface. But it also has to be destroyed when the
> > standard rtnl-link interface is used.
> >
> > 
> >
> > Fixes: 952cebb57518 ("batman-adv: add per VLAN interface attribute
> > framework") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > Cc: Antonio Quartulli <a@unstable.cc>
> 
> Acked-by: Antonio Quartulli <a@unstable.cc>

Applied in revision e721749.

Thanks,
Marek

--nextPart2401882.Gt4OllkToA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXVZrAAAoJEFNVTo/uthzA8esIAJL8LLHodHaCgo3P5+PIxa+O
5G2to80ReMsDaFYt5saKBEFzIms056m22bMj3w9fDYru45uCH2vD46bPcHn3QvAj
Lv7KJ/1ErH/oW4VpKMDd4gf/Qr6Dm/cI24CdhIGQUNPqMIaQ8ycXpEvo8aG/ygFi
/UtbS01jpyNb0+vXrJfMorQdM9/SPe0JqofITKqK+ugh8Tq5sBI8JcLkOvDPdSt4
uHVtgWuIs4J/H+h5RHKbXgbiUPFT8+sOo+3quxhe2sP0ijvuzPMc8YGmxst/qYOE
m8C5l5jID9WrSoS8TZ7U5jWJx+0lIY/oc3wVT0XTjKd5UfJErhq6GWBSMuhuQI8=
=P6XQ
-----END PGP SIGNATURE-----

--nextPart2401882.Gt4OllkToA--

