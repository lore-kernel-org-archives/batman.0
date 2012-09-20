Return-Path: <ordex@autistici.org>
Date: Thu, 20 Sep 2012 20:10:01 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120920181001.GE29329@ritirata.org>
References: <CANMkaozByUVfK9h_UAY08UDCZd6xJWg7NqPpCTWJfsyaBnEJEA@mail.gmail.com>
 <1860743.fUGhpHrPxd@bentobox> <20120920114250.GA29329@ritirata.org>
 <CANMkaoyhATZnFpRTDQXPFUOyPXnVOzTHgr5O1+UwZgmYZ9tvYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <CANMkaoyhATZnFpRTDQXPFUOyPXnVOzTHgr5O1+UwZgmYZ9tvYA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Fix change mac address of
 soft iface.
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


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2012 at 02:56:13PM +0200, Def wrote:
> Into function interface_set_mac_addr, the function tt_local_add was
> invoked before updating dev->dev_addr. The new MAC address was not
> tagged as NoPurge.
>=20
> Signed-off-by: Def <def@laposte.net>

Acked by: Antonio Quartulli <ordex@autistici.org>


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlBbW/kACgkQpGgxIkP9cwdR7wCfeybsg+k/MTfbU26O0xBaqvwq
3m4An1ONRhdR2yfzcjWIfKaS8XKvomIB
=xYYv
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
