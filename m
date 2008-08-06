Date: Wed, 6 Aug 2008 10:10:05 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20080806081005.GA19065@pandem0nium>
References: <7itzdzzero.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <7itzdzzero.fsf@lanthane.pps.jussieu.fr>
Subject: [B.A.T.M.A.N.] Re: A few comments on the BATMAN routing protocol
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Cc: b.a.t.m.a.n@open-mesh.net, olsr-users@lists.olsr.org, babel-users@lists.alioth.debian.org, Roman Steiner <roman@steinerweb.at>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Juliusz,

thanks for your comments. As already pointed out, some of the problems
have already been adressed in further development and are already
solved in batman-0.3 which implements BATMAN IV. I'll discuss only one
thing that was not pointed out yet.

I'm forwarding this mail to olsr and babel because you did so too, but
would like to invite everyone who reads this to join the discussion on
b.a.t.m.a.n@open-mesh.net (there is no need to scatter the discussion on
various mailinglists).

@marek, @elektra: please also forward your answers to the batman-ml.

On Tue, Aug 05, 2008 at 05:02:19PM +0200, Juliusz Chroboczek wrote:
=20
> 2. Persistent loops
> -------------------
>=20
> BATMAN does not contain any loop avoidance mechanisms, nor any for
> loop detection.  Because of that, BATMAN will cause routing loops in
> some cases which will last up to PURGE_TIMEOUT seconds (256 seconds by
> default).
>=20
> Indeed, consider the following topology:
>=20
>                 A
>              l1/|
>               / |
>              S  |l3
>               \ |
>              l2\|
>                 B
>=20
> Suppose also that l2 is a very lossy link, so that B has selected A as
> its next hop for S.
>=20
> S crashes, and A switches to B as its next hop for S.  At this point,
> B is still using A as its next hop, so we have a temporary routing loop.

That is wrong. Why should A switch its route to B? S is dead, so it
won't emit OGMs. Without receiving OGMs from S, A will not reconsider
it's routes to S. Routes are only updated when an OGM from S is
received. So the routes will be frozen with the last received
OGM of S, and the routing loop you describe will not occur.

This is different from protocols like RIP, where information B would=20
probably send information about S after S' death. This will not happen=20
in BATMAN.=20

>=20
> After one window time, both A and B are performing opportunistic
> routing (Section 6.3.1 of the draft) and hence form a routing loop.
> I may be missing something, but as far as I can tell, the loop will
> only be eliminated after a PURGE_TIMEOUT.
>=20
> Due to the convergence issues outlined in point (1) above, BATMAN
> needs the opportunistic routing mechanism.  However, even in the
> absence of opportunistic routing, transient loop will arise for up to
> one window time.

Could you construct an example for a transient loop?

best regards,
	Simon

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFImVxdrzg/fFk7axYRAkY7AKCP0UewslZCBlIxasZ9TXTWnUCSXACgwJfe
yKbfKu/wys0OH8VO3Kp/UTc=
=Z9oA
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
