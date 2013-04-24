Return-Path: <ordex@autistici.org>
Date: Wed, 24 Apr 2013 12:55:05 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130424105505.GD16603@ritirata.org>
References: <5176EEE1.40403@wirelesspt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <5176EEE1.40403@wirelesspt.net>
Subject: Re: [B.A.T.M.A.N.] Batman-adv and adroid as mesh client
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi cmsv

On Tue, Apr 23, 2013 at 04:28:17PM -0400, cmsv wrote:
> I have a growing number of users on my mesh that use android and i am
> now looking at supporting it more and better.
> As i do some re-search i see some articles like these:
>=20
> http://www.geek.com/mobile/batman-wants-to-break-android-free-from-wifi-1=
539651/
>=20
> https://blog.itu.dk/SPVC-E2010/files/2011/08/13adhocandroid.pdf
>=20
> https://www.networkworld.com/community/blog/android-phones-are-connecting=
-without-carrier-networks
>=20
> http://allaboutandroidphone.blogspot.ca/2013/02/project-batman-use-of-ad-=
hoc-network.html
>=20
> My questions are:
> Are here any ideas to have batman-adv working with android ?

we support batman-adv in the linux kernel. As far as I know you can "simply"
compile the batman-adv module for the Android kernel and it should work. I
remember of somebody which did it.

However we do not directly work on that.

> Is anyone using android in this stype of scenario ?
>=20

But why do you want to use batman-adv on the Android devices themselves? th=
is
kind of applications are not really energy-friendly and a normal user would=
 not
probably like to drain his battery for no reason (imagine an Android phone
working as router for traffic going to other nodes..).

What I usually do is to use whatever smartphone as a normal non-mesh client,
meaning that I simply connect the phone to a node acting as AP.
This is the common scenario which is also explained in the wiki.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRd7oJAAoJEADl0hg6qKeOoksP/1WtN54n7+bdjkXNYFmp1Eo9
+as+NxzwyHhzkTgv0OxxRJVm/7r0YvLPCJ7VNWR3wDXLGskZVOD+j4zj/Fnn5uKZ
Ob9fG1fOhPWWcp5yvrS4L/TQlm5OeLRawBdLEfmVuwMuelOqutCXEB/UvCOO6LFx
IkWQiPxVAky1tdnf8jfzM0jGNLzVv5fZX3mnf4un7lssIw9M+EWKmGi1k2hi0tHt
LwxI4Op8GelMbMQFXWS4H4j6Lq2c5Wc6Lyeu3HcDTTkL+UWM23rQKglcS9Fq0bo7
aNX+ZruodJ+YXnpI0/JYVFIqqu9yiv6UzfM1CTnBr/DtlPfvTP0LHE/lnJ5pRaN0
AbxZgWq0HysfqdoTgoz8lrThp9NJmNqD5yZbO0Zog1QqsxOLIQpJWncYRCBYjTwb
wyYqDZaXuylVH6ZaHGe5GFOh5FBZQLcW8QxTum2o3igBWR1zCX/p0rWHVO8fGW2O
BkWzxNiiSCpJE1Xej+gguB7/F1A/jfsA3Pl62XvCfbAWGTcDAT2y3rSM/JW2rc6B
k6MGKOkujHyz5o1lXWavnfAtoaW/KUFuAVg0LN7Xd4OCn9CFVqo0AJOQx4clkX1F
wYkx6go7fUJ/2MwF8KM1bI8vT35W4nrjmxWGc1GR+mCjBS7zgXcCuu2rrEtUVohN
io26m9vyck9DblMefaKy
=RXF3
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
