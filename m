Return-Path: <a@unstable.cc>
Date: Fri, 8 Jul 2016 08:33:02 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160708003302.GK5978@prodigo.lan>
References: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
 <1467741697-8811-2-git-send-email-linus.luessing@c0d3.blue>
 <20160707092436.GH5978@prodigo.lan> <20160707101442.GC7076@otheros>
 <20160707134052.GD7076@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x9uCfsizvaabZDbV"
Content-Disposition: inline
In-Reply-To: <20160707134052.GD7076@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Snoop DHCPACKs for DAT
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


--x9uCfsizvaabZDbV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 07, 2016 at 03:40:52PM +0200, Linus L=FCssing wrote:
> On Thu, Jul 07, 2016 at 12:14:42PM +0200, Linus L=FCssing wrote:
> > Hi Antonio,
> >=20
> > > have you tried applying this patch on one of your servers and measure=
 the local
> > > effect? (i.e. if the number of BRD ARP req is reduced or not?)
> >=20
> > I had queried Martin Weinelt just yesterday, they will test it on
> > a 500 nodes compat-v15 setup soon :).
>=20
> Unfortunately, looks like this patch has no effect regarding the
> ARP Request overhead. According to batctl log, DHCPACKs are
> snooped, but still 84.3% of all ARP Requests come from the three
> DHCP servers / gateways.
>=20
> These ARP Requests come encapsulated in a batman-adv broadcast
> packet type.
>=20
> Hm, anyone having another idea what might still be causing these
> ARP Requests?

have you tried enabling DAT debug and observing step by step what happens ?=
 You
could try to study a simple case: i.e. an unknown client that comes and
connects for the first time..you can save the full log somewhere and then w=
e can
all have a look (knowing the MAC address of this client)

Cheers,

--=20
Antonio Quartulli

--x9uCfsizvaabZDbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXfvS+AAoJEJ4aZjxxc6bKeZMP/A2FKKymligajueL08K5lLtL
kBLIQWgWmUBtpK3a9kiBCz+OU0w7AS+j7htuUq9sadunwRgtG3BbV53xF3qshH7c
xaLw00LJVoMOeuQEX1++8l4m2GcZ/CcbKWH/z0+y+G0r49YBmxnWAqlH0wD6KVbN
997VgAs7jExKM0qoPIBXg+x+X+dx3zhPLrc/DDMVKKuZSaot0YClEhjdEUNOAdkJ
bjZ5t7TH2RAdMg962J0241HwT4irFXp7W0bGPL6v0rPsdw73zdhmtnS6IvNZWmjo
P718J/W0ODvSwltTwy41APMKIWT/x4aDstzvqVe2RB0vmdvV0B6tricr0eNql0tz
f0SJqqXd0M+QmFXNtsHJPU0OJh9odfx3vibi2YUhKJ9K60xyjMpuXK7LpbxEKGLJ
0x56opBpKTz9zx1mTGGtUIP32UXptUQKjl77zR00lYpO2ayy2TryB8yWK5VmYYcZ
iyAeHKo0GQs69Z/bldr6Mog7AX1il2xDNcDE32aoGoQK89g1ARt2YnfCVWQHF9a8
SH66bBnhqlvHJmZ5yFnkKlGXDO+qF/jyPjxig7h779r8CAeBT5QzZE4K7quTQkkF
7HDFLk9vNvcS1uZK1/i5s53IbteZ/ls3XSgx+EXX4AcHGbLOjItR+4nVzj2voxQf
Gkx1u1iu8yYmAPFR+rAi
=GG6k
-----END PGP SIGNATURE-----

--x9uCfsizvaabZDbV--
