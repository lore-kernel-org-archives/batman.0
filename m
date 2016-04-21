Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Apr 2016 18:48:33 +0800
Message-ID: <1712496.Gi9n3BqAUu@voltaire>
In-Reply-To: <20160313152423.GA9674@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <5081672.FTLI5Uv8oX@sven-edge> <20160313152423.GA9674@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1926659.0y1anR2F6Q";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: NETIF_F_NETNS_LOCAL
	feature to prevent netns moves
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

--nextPart1926659.0y1anR2F6Q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 13, 2016 16:24:23 Andrew Lunn wrote:
> On Sun, Mar 13, 2016 at 10:29:21AM +0100, Sven Eckelmann wrote:
> > On Tuesday 01 March 2016 22:19:05 Andrew Lunn wrote:
> > > The batX soft interface should not be moved between network name
> > > spaces. This is similar to bridges, bonds, tunnels, which are not
> > > allowed to move between network namespaces.
> > >
> > > 
> > >
> > > Suggested-by: Daniel Ehlers <danielehlers@mindeye.net>
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > Acked-by: Antonio Quartulli <a@unstable.cc>
> > > ---
> > >
> > >  net/batman-adv/soft-interface.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > 
> >
> > Reviewed-by: Sven Eckelmann <sven@narfation.org>
> >
> > 
> >
> > Andrew, would it be ok for you to apply this patch first while the last 
> > two/three patches are still discussed?
> 
> Sure, no problem. Please take it.

Applied in revision 34199a6.

Thanks,
Marek


--nextPart1926659.0y1anR2F6Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXGLABAAoJEFNVTo/uthzAteoH/jXCw3AQhnSWWelRQuER86B7
4LqYAxm27ySrbcRFbGH375lNl2t2qnRJ3o5jacgWwQI/+VGz2V24cBIJsisLFyIq
a0QmsASL5jnGMe8jtT2edPPZ7N+C3VsAF5Lz2ZWDImJ021Nz2QiU9cZK4WLLxSI7
Cacdka8ycVc2py2RF2vUf5FTQdJhn0Hs0wTn2r+RTOVVKev9NOVzh/tCV3268oU7
lfvXRdodiZCRWvfEwjFcWuKDPQSNcsgPMBezh8i/OQAFiwhYOxzmLzZP/BIvkR+Y
x8fJDIgPKa9H8mYJElExG6iG/A/5BrzYTQyt/aUuwYz9W9TKOXUfJRbQOqgKgy4=
=1dsR
-----END PGP SIGNATURE-----

--nextPart1926659.0y1anR2F6Q--

