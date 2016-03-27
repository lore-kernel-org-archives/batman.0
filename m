Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Mar 2016 14:25:21 +0800
Message-ID: <1494942.vC5umbTYHR@voltaire>
In-Reply-To: <5526455.7mZMx5I6Az@sven-edge>
References: <1458470396-12067-1-git-send-email-mareklindner@neomailbox.ch>
 <5526455.7mZMx5I6Az@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1676688.aAdq8nqxPX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: replace ethertype variable
	with ETH_P_BATMAN for readability
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

--nextPart1676688.aAdq8nqxPX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 20, 2016 12:08:24 Sven Eckelmann wrote:
> On Sunday 20 March 2016 18:39:56 Marek Lindner wrote:
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> > ---
> >
> >  net/batman-adv/soft-interface.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Sven Eckelmann <sven@narfation.org>

Applied in revision ef38843.

Regards,
Marek

--nextPart1676688.aAdq8nqxPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW93zRAAoJEFNVTo/uthzAEuAH/1rRzO7vVRntlRDPOr0dD6am
TCxkq1FSlBp9dwzVDbbqvo/dRQunBvuVHvXiOdnQ6jnJ1FJ7HVZcHWCiGTfOsvUU
/FKb3uPxIB12ZkYHvl7cStOSgfmMMmXSQG5CQQnMLyZOuyoIGlngI2qbL9d/uQwB
REw4S6wtAlUFiPgt8FpD0r3yiFCrh2prKjXT8Znj9pX3QWvoxQYiXwmg1EP5jRyv
oDb5zomGAjLiX8KZyOhZshe4EHMg2ZCTjExWdR3aOdYmZCZD7TtaCK1C9BOcF67Z
y3Cna1xpZyForq/xluux5iuUlZFd/9ufgfFkzPwszlrKaC9tkuASYmjs7vIe45w=
=g+g1
-----END PGP SIGNATURE-----

--nextPart1676688.aAdq8nqxPX--

