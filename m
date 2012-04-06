Return-Path: <ordex@autistici.org>
Date: Fri, 6 Apr 2012 08:43:45 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120406064335.GA25835@ritirata.org>
References: <CAE_oyXcpynmW750th7OVgA8xmVTDyghxj4xW3k2xsnNtjxrGnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <CAE_oyXcpynmW750th7OVgA8xmVTDyghxj4xW3k2xsnNtjxrGnQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] - remote access
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


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2012 at 10:44:55 -0400, xjodoin@gmail.com wrote:
> I searched on the wiki and I didn't find. =C2=A0How I can have remote
> access on batman-adv mesh node.


Hello Xavier,
thank you for contacting us. Actually batman-adv is a layer 2 protocol and
doesn't know anything about remote access or stuff like that. What you can =
do is
to set up a service that allows you to remotely access the node (e.g. ssh
server).

Batman-adv cannot do anything for this purpose, it only provides link-wide
connectivity in the mesh.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPfpCgAAoJEFMQTLzJFOZFqxQIAKSGWmwTrgorjPY9NPZy8OnE
NsRFbyE9ScRjb1KFKIs/BWsFuy1LMeNDiYKqiMAlAajVHGg/3qow5uhUktZrXs/q
NWAQra+fULVfQGxror2WTrWjT5zuwD9BKtwQ+FsmR5N78MMRd8sin76xAdunWMlc
1V+u6Ljxsvot0sYOUdNZOVx+QfR04qZXVagO82DfryjqU/AeYZJe3cBh2PNAywLf
32GWlZl5KJ5d6ZuMIrAyWUoZsxMbJ9KpnuPdLCY8k5Iw/l993nmPMtVfc/foT2+7
u11AeDpuloMtbIIAy8I1ctBK/PEEkGvhu/fGfVXCZ2txnmeDiaTKGwks/NlJ4K4=
=s52Y
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
