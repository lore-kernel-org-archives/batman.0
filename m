Return-Path: <ordex@autistici.org>
Date: Sun, 26 May 2013 22:23:30 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130526202330.GP1679@ritirata.org>
References: <1369307262-21901-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20130525210748.GA11731@Linus-Debian>
 <20130525214219.GK1679@ritirata.org>
 <20130526151443.GA27074@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cnBsrynPgIOyCJkL"
Content-Disposition: inline
In-Reply-To: <20130526151443.GA27074@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: forward late OGMs from
 best next hop
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


--cnBsrynPgIOyCJkL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey guys,

On Sun, May 26, 2013 at 05:14:43PM +0200, Simon Wunderlich wrote:
[cut...]

>=20
> Regarding your suggestion to forward multiple packets with the same seqno=
, but
> better TQ: We currently would ignore them in A for beeing a duplicate. If=
 we were
> to change that, we would have to change the TQ ring buffer as well. Howev=
er this ring
> buffer currently has no specific order, so it's not so easy to update a s=
pecific value
> in this ring buffer because we don't know which TQ value belongs to which=
 seqno.
> If packets arrive out of order, they will be saved in the ring buffer in =
the
> order they come in, regardless of the seqno. Have a look at batadv_iv_ogm=
_orig_update(),
> maybe you can find a decent solution for that. :)
>=20

Honestly, I think that we should avoid adding features to batman iv any lon=
ger
(this is my point of view) and rather concentrate the effort in pushing them
into batman v (which is going to come soonish[tm]).

Therefore, if you think there is something which we can do better, I'd pref=
er to
push such improvement into the new version of the protocol, which is going =
to be
"simpler" (to some extends) and since it is still under development it woul=
d be
easier to change/improve/modify.

batman iv already has many "patches and corner cases" which I think is bett=
er to
do not change too much to avoid introducing some new nice bugs :)


these were just my 2 cents


Cheers!


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--cnBsrynPgIOyCJkL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRom9CAAoJEADl0hg6qKeOhFsP/1x2deeRDw5/GbGNXtSS3yEl
5qij9ijS+vz1jeQLqgPJpWdGufz6Z7fGm3nk15SPHhE9bO1fDcIsL/vseORA2Wha
TTuWS/lgnWmB6IbHIbj5bjEGYuxd4DROr4mddqZ3nX+3Rvc24IgrU8lPzXkXbB2U
ByJ2GDdnTxqxo+dQGftTb/O9QH0/4Zi1wvV/mRE9vNWnP2wJ+9n5QHuK02BUo3++
6jCpwB1CkuuzwW28z5AQq9uweNOiEp3Cq3w3+o6/Ulh9RK3g+G+vBD4bHN3KWjNN
K3O0zlTP+w+AiZZRKtrYrb4wEyxahFLW/P9KM+bif1+UVbs1aP2M+HZM+RcVcU53
5aXuvKUQgkgEUs83KpN86PM5CKuqdhVpKaju2AWRGoD1Mu7qw3maq7Qp2pUjeXKy
IlIKceBLazen4GmYRQ3YLrtEq0VEJthXGZexxqkceS4xR0EyYDYqpetyrjhbvebJ
jDd61ksg52D7temOOZz1qCoFopgN55AE8U/Aj6vtNYJr/5LaVhToryUphgfl7bA6
1JCkFb1ZYG+VEpAOn3AryCpwgB95cWdcAtoaPV+nLCujZY84ns3lPOYYbEl14bh+
vPoeM7ek6SmXFtyBbQJqx70KVCruECHOTBtd86dQUMTWjplyllpOsl1pewirSezG
WocqLtIfwiEKTJwCtMR8
=FzLK
-----END PGP SIGNATURE-----

--cnBsrynPgIOyCJkL--
