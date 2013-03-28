Return-Path: <ordex@autistici.org>
Date: Thu, 28 Mar 2013 14:36:25 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130328133625.GG5152@ritirata.org>
References: <CAHQ_bgjaBemwFJA4JH2c9+R9MS58BPAFt8z-6fEX5DOciYBsQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline
In-Reply-To: <CAHQ_bgjaBemwFJA4JH2c9+R9MS58BPAFt8z-6fEX5DOciYBsQQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] MAC address for BAT0 Intefrace
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


--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2013 at 02:45:23PM +0530, ajeet singh wrote:
> Hello All,
>=20
> I saw in the batman-adv code that random MAC address is being assigned
> to BAT0 Interface.
> I need some clarification regarding this.
>=20
>=20
> I have tested the following tests,
> Test Scenarios:
>         Batman_Node_ A (192.0.0.1) ----------------------
> Batman_Node_B (192.0.0.2)
>=20
> Test 1: First, I used batman code without any change. I used
> eth_hw_addr_random () for BAT0 MAC assignment.
>     Result: I am able to ping from node A to Node B
>=20
>=20
> Test 2: I commented =E2=80=9Ceth_hw_addr_random ()=E2=80=9D and assigned =
MAC address
> of primary interface to BAT0 interface at both nodes. Now, we have
> same MAC for primary interface and BAT0 at both nodes.
>      Result: I am able to ping from node A to Node B
>=20
> As you guys have assigned the random MAC to BAT0 interface, I wanted
> to know that what would be potential problems if we assign the MAC
> addresses of primary interface to the bat0 interface.

Hello Ajeet,

personally I think that using the primary_if mac address for bat0 might lea=
d to
mac collisions whenever a user removes the primary_if from bat0 and add it =
to
bat1 (for example). What would you do? whatever your answer is, using a ran=
dom
mac address is probably the cleanest way to address any possible issue like
that.

Any user which prefer to set a particular address to bat0 can easily change=
 it
using ifconfig or macchanger (no need to change the source code).

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRVEdZAAoJEADl0hg6qKeOdcEP/jb7UN08kpNyTzySv3ZpSjDL
WAvs2r5bqXtxWdkKnM9QdOBcClWg1+vN8oo64HjgBn6hNehFjUQW8qYuvV/ZcCmN
eKDtdegNLBRdQJ7rDvpquTzUb17K6iPZJAQMK0FTTDZdfXHmTbH5J7TufTmxahDl
+WwOBmt9ctS18RgXndlu9O1kewpRSmVADq6J0rb/KFm02RBn8iJyvQE25c89efMq
ZGqPfLhRngK6ZhJmxBnRmUIIuDZyff/XdsdgirY5h1JS8YgrNmimOwUjlWaIuOvM
z4yxv4Yw6QdEZPyn7ZC6uvlcbdd8AsCid9XdugkCnjWHfM/rbnNSsUY1M5vuIc1Y
3a4J/YzLde8AmTwLxW5/KN1kj84rGZQjVQLI45NaCGAKIgmri+XCuHmjYVp6SnkM
PBV27RR18Ta5HG5geJRe+BnVx97SVOWXRkDwEjFit0ZV4uHCd3vz+WkZ7IqL4Vog
u1GvPC+SDPKQypNwNen33+gjZN7eJnNQpm8g2C7jF1PG0hilKVXi3QKz67+WbB17
uKmZUqMuhVKegozouEZ3Yv+iDrDa13Sd1S8/P/Vo/iVZN4LGfB7pPJx7lvNiscu/
iYrTqTAULekudJcV2pyVBNRDNolDvjuMpLtviHsT/2R+CkoGPb7KdqU36+OgvmwC
Angvt4TmobfJY4bjF8bP
=h+Nt
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--
