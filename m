Return-Path: <ordex@autistici.org>
Date: Wed, 20 Feb 2013 15:40:49 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130220144025.GP3523@ritirata.org>
References: <1361112184-9927-1-git-send-email-ordex@autistici.org>
 <20130218234904.GA24241@pandem0nium>
 <201302190908.44891.lindner_marek@yahoo.de>
 <20130219214340.GA29174@pandem0nium>
 <20130220132625.GL3523@ritirata.org>
 <20130220141413.GA1058@pandem0nium>
 <20130220142727.GO3523@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oN4OvwWIcd1E23D1"
Content-Disposition: inline
In-Reply-To: <20130220142727.GO3523@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat support for the
 new netlink ops
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


--oN4OvwWIcd1E23D1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2013 at 03:27:27PM +0100, Antonio Quartulli wrote:
>=20
> Nothing on my side.
> Thanks again :)

I just realised that the ioctl commands this code is handling are for a bri=
dge
interface. Since batman-adv does not have its own set of ioctls, then the
ndo_do_ioctl() callback should simply return EOPNOTSUPP.

I'm going to send v2. This will not affect any tested behaviour.

Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--oN4OvwWIcd1E23D1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRJOBxAAoJEADl0hg6qKeO6kgQAKN/NXelivyGWSL5gG+qeemb
KoKWiJMofJkGCh/PQY8CJ6WtuHHHWdbxaO3eTvMq2GX+TDA3RNc8V+ZYKT/zEt+e
0Wuyh0c4qQXQ6UksHsBV2Rm0OHS97JYHpvc9iIvsQWLo5sn0ZClgETADx0qTxrgw
C+DYgJnFBHWqCJeOJDMf+0l5IFyU4+iFTX244CDDoKYJZ/CkFJTwqPpTyywdeqMH
ffc2jDzqOxBhCaCzlY+Uv8NA93zVMm9YsTXV4E+qMcZqH93lO3T5RiQU+05fRvmu
E14H6hdojsy5Xl83cgVyLF+P4lCBrZ+/qb8cT9pDookNQF8Z2oojCUd55vNwlE7y
Yxa/VZyzd0XK1lRAGt7CUGGMvo7mTnUDOU9iAGwhWaosISeIFbTS6O12d50HAW4r
oRGckK2exnl/TBsT5KmUZt7UVypghb2iwtvpEwPGRIMfounQeBsG9FNL2M22RwUM
o7XO1ZT9EkTzQhROABmXUCm0ZAqDl7nPUSFsSOs25kCW39nMghdHdLlh4Z9ypoge
dFJhoqHcRDYsc6o+yiX2Zxkjd6flXfFLWek0M8jne+qZ0+o4opUN3GZMUDM0iEOK
/GTsaiwKQ/1cVzs1pVaeLmtakj8aK3JSqc6pWXX3kJ5tXNmwKX3YSLcdrzby90P2
SaHjPedTUEiy5/NXPK/W
=jpk4
-----END PGP SIGNATURE-----

--oN4OvwWIcd1E23D1--
