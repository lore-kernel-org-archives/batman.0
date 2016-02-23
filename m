Return-Path: <a@unstable.cc>
Date: Tue, 23 Feb 2016 13:07:50 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160223050750.GP5584@prodigo.lan>
References: <1455634888-29400-1-git-send-email-a@unstable.cc>
 <20160219.153718.442738962662787470.davem@davemloft.net>
 <20160220052840.GF5584@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X78YbkCBd9ye7Cvs"
Content-Disposition: inline
In-Reply-To: <20160220052840.GF5584@prodigo.lan>
Subject: Re: [B.A.T.M.A.N.] pull request [net]: batman-adv 20160216
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org


--X78YbkCBd9ye7Cvs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2016 at 01:28:40PM +0800, Antonio Quartulli wrote:
> On Fri, Feb 19, 2016 at 03:37:18PM -0500, David Miller wrote:
> > And thanks for the heads up about the potential merge issues, I'll watch
> > for that.
> >=20
>=20
> Hi David,
>=20
> actually I just realized that the patches that will create the conflict
> are not yet in net-next, but they are still pending in my queue.
>=20
> At this point I will wait for you to merge net into net-next first
> (there should be no conflict at that point) and then I will rebase
> my pending patches on top of that.
>=20
>=20
> This should prevent you from dealing with any conflict.

Hi David,

I know this kind of mails steal you some time, but do you have any plan
about merging net into net-next in the next days ?

I have some more new changes coming, but I'd like to send them only after
the merge operation is done to avoid you to deal with some conflicts (as per
above).

Thanks !


--=20
Antonio Quartulli

--X78YbkCBd9ye7Cvs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWy+kmAAoJENpFlCjNi1MRS3gP/1V8gZwSqZu3gtwzZlRejELP
RTuDFGkqRCzZRgEFXrYHFwv27RI8Ez9WV8KywAwIsuge+FlfXqVQ6oyE0h9LltQq
7j3URhdFUgwscjuVk/ahjDrRuKtbJW/bn4X/hKkA8RM3OZ3Y9QsJKJ1bcePjYMVG
NNnrFTLM7ztC14GxlCaLfS/Mk/+UaLisLVtOQypNwhzH6Jpbbw0HY8A09orMmP0Q
acmRc+3gG3iZgMRYd998rVtuZLKjC21ZVohU3Y+/Hma1/j8bJX66kniintgBZaNs
I5amajPBQmtqd62b/q4jtjkIiwXlQ8Z0aRKo4KrPakt5hFmV9zM4cLSTu9NsTQrp
h/MtlJnbwvy6elkYKB7jYYXTdmbqHlUXYBmRTsf+LLkhJFyEGvphSaHzPoVypMOL
0HS8A32auIOQvi/hfecuVJ54F33vYjiBMu6ut3ofMDpBtR44gc0n3Uy8katOUi0A
9CIV2yUutRJPpaSGNNcus0SBU+LDvUU/9UIyfBacA9cd/JfloCHe/BqP5OhLYmg6
89l8NsleyxiINgNxLco+sWOktSAC2GNxLa94yfThEejPYRJjWh9wtPjnL6RqI9BQ
ctjHnzYeeAV0zlhcJfZSUTvxHNjxW2TUN86nsQ4ncmBdctgSYxT6Sz7G/n+KHg4e
NRr3lcFxoN7bTtC3O3EA
=LZP8
-----END PGP SIGNATURE-----

--X78YbkCBd9ye7Cvs--
