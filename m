Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 6 Dec 2011 16:01:34 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111206150134.GA12168@pandem0nium>
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
	<201112051935.06611.lindner_marek@yahoo.de>
	<20111205121342.GD10131@lunn.ch>
	<201112052138.55069.lindner_marek@yahoo.de>
	<20111205142553.GE10131@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20111205142553.GE10131@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] switch routing algorithm at runtime
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


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey there,

On Mon, Dec 05, 2011 at 03:25:53PM +0100, Andrew Lunn wrote:
> > Here comes the chicken & egg problem: We can't have bat0 and its routin=
g=20
> > algorithm selection before we did not add at least one hard-interface.

an alternative we may consider:

We could just write the name of the algorithm in a debugfs file called
"routing_algorithm". It is filled with batmanIV as the default algorithm
to start with, and whatever is written there is used for the next soft inte=
rface
to be created.

This would be backward compatible and changes are only made upon creation o=
f a
soft interface. It would also allow different soft interfaces using differe=
nt
routing algorithms (if someone really needs it). Putting it into debugfs ma=
y be
not the worst idea, as changing routing algorithms is (currently) only done=
 for
debugging purposes anyway.

What do you think?

Cheers
	Simon

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7eLk4ACgkQrzg/fFk7axZjiACglh7ElJ8+QXlSLevz3G3wVLl4
Ym4AnRqyyLAevRQwqvhrrq3TgSARUJgy
=25ir
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
