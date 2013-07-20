Return-Path: <ordex@autistici.org>
Date: Sat, 20 Jul 2013 09:32:47 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130720073247.GS3843@ritirata.org>
References: <68049499-9E98-436A-B86C-DDF8877C22D5@uirevolution.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RlgFhasKO3bfRJ5j"
Content-Disposition: inline
In-Reply-To: <68049499-9E98-436A-B86C-DDF8877C22D5@uirevolution.com>
Subject: Re: [B.A.T.M.A.N.] Location on the network
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


--RlgFhasKO3bfRJ5j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Brani,

On Sat, Jul 20, 2013 at 04:17:10PM +1200, Brani Mead wrote:
> I'm wondering if its theoretically possible to locate a device physically=
 on the network. The nodes may have some notion of distance between eachoth=
er and therefore time, and therefore can compute the fastest route. However=
 can any information be gleaned or added that indicates which direction a n=
ode is in relation to north south east or west on a map?=20
>=20

In the current implementation of batman-adv a node does not have any idea a=
bout its
location and about the direction the message is taking.
This should be somehow handled outside of the module. For example, using the
cellphone, you could get the location using the GPS and then exchange this
information (by means of Alfred?).

> My challenge is to connect a local group of cellphones to a mesh but to a=
lso be able to define which phones are  to the east of a central point whic=
h to the west, north and south.
>=20
> At this point I'm not even sure if its possible.=20
>=20
> Cheers ?
>=20

So what you need has to be implemented outside, batman-adv cannot help with
that.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--RlgFhasKO3bfRJ5j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR6j0fAAoJEADl0hg6qKeO/pkQALRB8iQrWZmab/pOfnhX16Sw
uLKSUrIuquNjP9WugrYp6wj5p2QWrlDqomrjRm9GjD2iZJWT3NJw76NXI6BrL21V
mgDvXjY1y4J/AyAFrnbTSkYJk0iilD4t/CvQ8Sxpu3vajMhCYJawLNUTc8ObJpbL
X+5iAS98HyxCkVQGfkWRPGHR4lQo9EzR97fFjQGxpoZXC2QNKn40HzY1p4ReDmqA
DSv+dA2gHeodpvoWnRf9RyW/57nXz6Ac0db3GRlIwiPt656M8Ed9vXmzikl9/1tC
4L6QbliFb6j1OTKm+mub8kiR5d+ewHjJHa3GnY5RdBTvHscPaRYv9h1Cygzmr9qI
LHmWmjnY5ZMNXjWuiqhmqCa6Y7r4lD4WtF20ll0oYaSffIty/orEgI+Tq6BOqmIo
4xwNV26TJbY4xpVCz3daPHVf8ECEz35nuj4htAJSAGbVzww3qi65RW6fP6V4EOBC
EZKh+MagHaJ2vf9a8PP+/TerIUDZSd2dRU6nr78BVvH3WwhCftRrsTMg24ZXmd54
sK0dIKjRRhmUl/kyguwF06StWVkoPB6Ns/XWNNV0inZE8bHUAXOufhk4W0yYAe2s
nWhXIAf0AadtK+53LwgBlHhxrFvckhBU6Xvb7HyzXHdFjcW+ZEwLfvhZEnbNKada
QLoSwRjkW12zuLALQJQu
=ldr6
-----END PGP SIGNATURE-----

--RlgFhasKO3bfRJ5j--
