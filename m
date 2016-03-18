Return-Path: <mschiffer@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <56EAE3B8.3050808@universe-factory.net> <4945319.BvQuBs3oU8@sven-edge>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <56EBEC41.4090404@universe-factory.net>
Date: Fri, 18 Mar 2016 12:53:37 +0100
MIME-Version: 1.0
In-Reply-To: <4945319.BvQuBs3oU8@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9oQ6OoixASLNreQ6Ob9lGvIQOrK0rJqP5"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9oQ6OoixASLNreQ6Ob9lGvIQOrK0rJqP5
Content-Type: multipart/mixed; boundary="AdO31G2ddBGJP17KNEnqjDVS1VvnxnSSi"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <56EBEC41.4090404@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <56EAE3B8.3050808@universe-factory.net> <4945319.BvQuBs3oU8@sven-edge>
In-Reply-To: <4945319.BvQuBs3oU8@sven-edge>

--AdO31G2ddBGJP17KNEnqjDVS1VvnxnSSi
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/18/2016 08:09 AM, Sven Eckelmann wrote:
> On Thursday 17 March 2016 18:04:56 Matthias Schiffer wrote:
>> And here is the new version of the PoC userspace tool.
>> Build with:
>>
>> gcc -o batnl batnl.c $$(pkg-config --cflags --libs libnl-1) -Wall
>=20
> Thanks for the patches.
>=20
> I've only looked at the test querier for a second and I am a little bit=
=20
> confused that you access things like attrs[BATADV_ATTR_ALGO_NAME] witho=
ut=20
> checking if this is available or that the received message is valid (ac=
cording=20
> to the nla_parse policy).
>=20
> I know that this is only a PoC but wanted to mention it in case somebod=
y wants=20
> to use it as reference for a batctl/alfred implementation.
>=20
> I like that the netlink interface doesn't introduce complex structs at =
the=20
> moment (but I have to think a little bit about it). The unnamed enums f=
reak me=20
> out a little bit (names would be nice so it is easier to write kernel-d=
oc for=20
> it).
>=20
> I just ran the build_test stuff through your branch so you get an early=
=20
> feedback about some common problems. See the attached mail (the unused =
symbols=20
> seem to be only symptoms of the build failures with old kernels < 3.12)=
=2E
>=20
> Kind regards,
> 	Sven
>=20

Hi,
regarding the first issue: I guess I should just add validation, as doing=

so is simple and can only improve robustness. One line of thought that
seems to be common when dealing with such ABIs is that the kernel would
break its ABI contract by sending invalid messages, and that userspace
behaviour would be unspecified anyways if the kernel misbehaves.

I guess we can just give the enums names. Looking through the other UAPI
files, some enums have names, others don't.

Thanks for the build testing, I haven't put too much thought into the
compat issues yet. The genl_register_family_with_ops error should be easy=

to fix, the struct netlink_skb_parms differences might be more problemati=
c.

Regards,
Matthias


--AdO31G2ddBGJP17KNEnqjDVS1VvnxnSSi--

--9oQ6OoixASLNreQ6Ob9lGvIQOrK0rJqP5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW6+xBAAoJEBbvP2TLIB2coaQP/1NGHTDbNmyyq7PiYfizm1vm
9BZ/KbY0O7GNUQ8rpkgM7KLfR7+1UXzr/KIGWlyezV9lPZxKcIXjSiVmapUcPHPR
fnm1mmL/powPstbArALXQt5TvYB5g/0Gu7Pz9/CJYxryM2mYPEkHNqLN41kml2K2
TsPVQkr6tVZdV3R44iDFVNb1e7gtzVxXh7Z6gn4NFBlnewqoVzt71/MncDpQRZwF
1wniQA6S/fVzM6CgRlF+20bJxXAihuUC5gD7HgBosdmeYwvbzJrsdPk6eYTcLDRx
7Ku0zWPMbU+incmLKM38AMGQyW4d+vPVXl3zmob7g4ZiodjGe3NijoFmFYJUmrgX
rEsvwgtJxHv3RW9Gx3pb+JUIb5eRVMztaI3reQ7KYjtO7kT4b33DZPVV/8EPFF1d
ErB1ZhG9lDjP/V3dyv1/hbDvJbm4ZUCD59kYRvKP750dpfXAqkAYpiQz/MI97O/l
s0NzOhhTG56KQOVpMAjAD0Zv0B+cC7R7aoxsKT73aztNrPRr5lr4zA7dmGRIEKin
eJLb8/c955H5mB0F6UYxbdUjxvnEC9qYMyXSJS66EjF6yvNzGYxqlx41UjRLXDY4
rMZvyD+RWcTh990+TrZOi3ej+u1nSQU1AZZYnVPvBP8HdpGBW3F3gcxXFzsku4dW
uoTXTktgNZj5FPxTKJ7R
=JRdI
-----END PGP SIGNATURE-----

--9oQ6OoixASLNreQ6Ob9lGvIQOrK0rJqP5--
