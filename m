Return-Path: <ordex@autistici.org>
Date: Wed, 8 Feb 2012 16:13:18 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120208151317.GD21844@ritirata.org>
References: <73D963E8-129F-4DA1-B521-38640393D3CE@solvare.se>
	<20120208132637.GA21844@ritirata.org>
	<E6C194B0-C542-457D-98AB-A7860E22DE84@solvare.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <E6C194B0-C542-457D-98AB-A7860E22DE84@solvare.se>
Subject: Re: [B.A.T.M.A.N.] multi path TCP
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


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Christian and thank you for your explanation,

On Wed, Feb 08, 2012 at 03:53:22PM +0100, Christian Huldt wrote:
>=20
> 8 feb 2012 kl. 14:26 skrev Antonio Quartulli:
>=20
> > Hello Christian,
> >=20
> > On Wed, Feb 08, 2012 at 12:29:52PM +0100, Christian Huldt wrote:
> >> As a complete newbie to batman, please excuse if this question is unus=
ually stupid, but I just got home after getting update on the mptcp kernel =
module http://mptcp.info.ucl.ac.be/ and it seems to me that running mptcp o=
ver a batman mesh could potentially be quite nice. It that correct or am I =
just being ignorant?
> >>=20
> >=20
> > Before answering your question, I would like to read and understand a
> > bit more about mptcp, but actually I couldn't find any resource explain=
ing the
> > concept behind it an how it is supposed to work. The only document I've=
 been
> > able to find is S=C3=A9bastien's Thesis...but I would rather prefer a l=
ighter reading
> > first :-)
> >=20
> >=20
> > Anyway, is it somehow similar to ip multihoming with load balancing?
>=20
> I am unfortunately not able to say whether that is the case (yet=E2=80=A6=
), I saw a demo and (think I) understood at least parts of the talk.
> This is my limited understanding:
> This implementation of mptcp works by creating a virtual interface bound =
to two (or more?) interfaces and traffic over that virtual interface is by =
the mptcp layer sent packet by packet to one of the bound interfaces.  - I =
am assuming that it is using the tcp acks to optimize which interface gets =
more packets -=20
>=20

It sounds like "bonding at the TCP layer" (let me pass the term).


> The receiving host has to be mptcp capable as well in order to bring the =
two (or more?) connections together to one.
>=20
> One of the benefits is that except for the two hosts talking, no one need=
s to be aware of the "multi path nature" as it is just two normal tcp conne=
ctions.
>=20
> I think that it could be useful (or mayhem) in a mesh network though I wo=
uld believe that where will be complications.

Well, assuming you know how batman handles clients, the only way to exploit=
 such
"multi-path TCP" is to connect the two (or more) involved interfaces of the=
 client to two
(or more) different nodes. If not, all the packets will follow the same pat=
h in the mesh
network anyway.

By the way, I'd say that from the batman-adv point of view using mptcp is t=
he
same as ethernet bonding. (Please correct me if I made any mistakes)


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPMpENAAoJEFMQTLzJFOZFNb4H/382AAVFOcHkRKGlJisErUU+
0TPWZ5gZJvLPFApHb+g5bgveYc7UoOyB65PaNbDE0+Jpsh38QUIJ1tlD302zX0gk
FXRo3aaHpxHNZKtj76DN2ROcUumiQlVuR4/hrCAGAO7u0EU9TTYKQURvNRxJEFCN
TABisau7K9w0zo9tRbRCiprLpOfJXFj1t+LIeXOOv7WIygSNy3XVd5UYisAjsVDs
nFD5YFuX3B4lA/j8HeYc0K1RZ5uMpEcpZHemVQETTJBaQH4Sf1xdaeEE6ZBo78tR
RUxOkk4WdtR645Bc2EGUiZNk+GYl0sqWRR71ohH39tR9rL3kQCm5Ezp2NccXdbw=
=HaX8
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
