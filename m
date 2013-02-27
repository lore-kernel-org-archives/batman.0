Return-Path: <ordex@autistici.org>
Date: Wed, 27 Feb 2013 11:27:51 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130227102751.GY3523@ritirata.org>
References: <1361022160-25693-1-git-send-email-ordex@autistici.org>
 <1361022160-25693-2-git-send-email-ordex@autistici.org>
 <201302271809.49037.lindner_marek@yahoo.de>
 <201302271821.19114.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Zzd9Wh/bp6DhMAqJ"
Content-Disposition: inline
In-Reply-To: <201302271821.19114.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/2] batman-adv: remove interfacing
 enslaving loop private check
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


--Zzd9Wh/bp6DhMAqJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2013 at 06:21:18PM +0800, Marek Lindner wrote:
> On Wednesday, February 27, 2013 18:09:48 Marek Lindner wrote:
> > On Saturday, February 16, 2013 21:42:40 Antonio Quartulli wrote:
> > > Now that the new dev_upper API is used, the private check for enslavi=
ng
> > > loops is not needed anymore as this is performed by the new API itsel=
f.
> >=20
> > Are you sure ? Isn't the following supposed to fail:
> >=20
> > $ batctl if add eth0
> > $ vconfig add bat0 5
> > $ batctl if add bat0.5
> >=20
> > $ batctl if
> >   eth0: active
> >   bat0.5: active
>=20
> Without your patch this is what happens:
>=20
> $ batctl if add eth0
> $ vconfig add bat0 5
> $ batctl if add bat0.5
>   Error - interface type not supported by batman-adv: bat0.5


Are you testing this with < linux-3.9/net-next ?
We need some compat stuff as if we want to remove this check and keep the
behaviour on old kernels.

Cheers,

/me does not think to old kernels :(

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Zzd9Wh/bp6DhMAqJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRLd+nAAoJEADl0hg6qKeO1SQP/jjDQBv18m5BtQsnQsKzlV41
ktU8ZOa8g99juZLuWg3s8s/gEbEB9gKKFUwpyaFR1RcVVPdP0WWFLYSoJZQKs33o
P8NxxEEPkCUyv1SMp45qFvQOaJteWe6M05qYv0gAYo/SqqAg28c2uPP6Erq6y4Nj
ZliVYru3c8gIpKtoaX39rg7iRwx0P3S82pM9KKi2qUGRGphLp50uPQGczlLwvqWu
vlcatptV3Gybq/r1QrSdcDERawCAfM+kg2TkNjvgiyGD1KeLbtbxxeatY9VnZA8C
9mw3YRLzuJ8PfzWHA8o+Kdj8Z9mp9Q+FHXtvRvzGj26b2VOLyH/ww+aJL0lFbsXu
LLJu8Odv4vaE8NCVep/IDhodw7vylIyodHaKgBt9RurhxAu/jOkm/ePsvXIBRZhS
vWtb3GguBbL5RelvzZyrzQ899m4qiLs0WHCuPKBal/S+DqO2qQ39GhwNtiL1h/jN
1DqB2iEFA6TJdVQOsQHqkIzNVybCNiCijSq79gCS9+yxgc5mWB/aZfrcmW1UGRYw
cn5omOlGPbuZdgyJf6rxWDDHWoodShUKvm73GqC4ecseqBH7fjVur1aC1EX3kom7
qvc6b632Zt/WQfGEEz0OVnQthS81tHe5TzaEcGaLiHhqCGBDW23oRYVe+/N6I8ff
2SVsgMoaRrEjhKl9EJ6G
=cdDZ
-----END PGP SIGNATURE-----

--Zzd9Wh/bp6DhMAqJ--
