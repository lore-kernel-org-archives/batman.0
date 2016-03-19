Return-Path: <a@unstable.cc>
Date: Sat, 19 Mar 2016 16:49:34 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160319084934.GD9971@prodigo.lan>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <1648365.zDTnRIsh0N@bentobox> <56EBEDF6.50704@universe-factory.net>
 <2088697.nI9sVi8cPN@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <2088697.nI9sVi8cPN@bentobox>
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


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2016 at 01:04:50PM +0100, Sven Eckelmann wrote:
> On Friday 18 March 2016 13:00:54 Matthias Schiffer wrote:
> [...]
> > > What about the "socket" file?
> [...]
> >=20
> > Ah, I forgot about that one because it is very different from the other=
s.
> >=20
> > I think it should be possible to convert "socket" as well by wrapping t=
he
> > BATADV_ICMP packets in netlink packets. Or maybe it would be possible to
> > drop that altogether and just do ping/traceroute in userspace with
> > AF_PACKET or similar?
>=20
> The latter could be problematic for TP meter implementation [1,2,3,4,5].
> Antonio, do you have an opinion about that?

Personally I wouldn't mind doing ping/traceroute 100% in userspace.

The TP meter itself does not require to exchange real packets between user =
and
kernel space, but only requires the availability of a command to start and =
stop
a measurement session. I believe these could be implemented as yet another
netlink command/message type.

Cheers,

--=20
Antonio Quartulli

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7RKeAAoJENpFlCjNi1MR9mAP/1C1xHQtmRZnpn4ppLXn0m/l
FKhZ96l+HvCY84BGtO3S/cYbZKskJ8RQeFVT6Mt2pkSDImeBnOl7NWHRbtJfH3Z1
IYx5KhB5mDu3JST9tCoxmk7RziFVQgokHj8RB90P2v/LH8ucUNIM6SwsH9svsvmI
zavlsTusSsgjePVkW9Jpoo+0RbqQF+wEMsExdzxiwcXmgkd6ZyxncZPXDHAxtW65
OTGd2lMSoFzfBmzpLy6plRn+fwOijTwU7u6powdosw3OXdNdrI23RZYbrQ4FCSRx
OEX+wirfuaehwNmvvQLbI25aT5edlbvd3tbGZ8GtrDolUM6bzXQyAavEito1BUhm
/uNH3mbSS3cIHbEWUVsg5rEZtoxNo9uS0mLTX8MnZDWlfR6/1I2De2lwsUQ1J9Qm
NM/0l0ShbtIZU0u1u5ahJAr9wy2gt2ccw+e3L9vb+B58pl4VBje6FoVbFipL6jCg
MB4TPNKIDPGIVWnwKWH5KkKak5n9o1P2sIMYjfRmoWl3xJ1y7iWg0rybqxdSGjMZ
tNYFfLa+BeHlthxgAFxUQ3897QnRtuwQx7cPjtlq1s8wvNlrdZRdDmDqCkvo66Ri
n6kWb8YfKVgIgIKlJudkwILgQSE5Uc9BhN7f2BWinZrwZ0FHzaDJlQ04pqvTe2hs
tF/Jk03umiC6sTGFHFCG
=3umv
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
