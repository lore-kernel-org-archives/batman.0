Return-Path: <linus.luessing@web.de>
Date: Thu, 4 Mar 2010 01:26:20 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100304002620.GC24284@Linus-Debian>
References: <201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch> <20100211094659.GH2900@lunn.ch>
	<20100211100156.GI2900@lunn.ch>
	<20100228163428.GA15370@pandem0nium>
	<20100301055955.GC15286@lunn.ch>
	<20100301165706.GA11578@pandem0nium> <20100302064308.GA733@lunn.ch>
	<20100302211324.GA15885@pandem0nium>
	<20100302214349.GB4436@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
In-Reply-To: <20100302214349.GB4436@Linus-Debian>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] slowpath warning
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I've been running 3 qemu x86 instances with Debian stable here
(2.6.26 kernel) as well as 3 Atheros ap61 / mips based routers with
OpenWRT (rev. 19468, 2.6.30.10 kernel) for 22 hours. None of them
crashed with Andrew's patch... so, sorry, still can't reproduce the
bug you're talking about.

Cheers, Linus

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLjv4sAAoJEBKw7u43QNpf0uQQALfQM6DUFNKSmiea2q3wjQr8
lwHQdHCYwwVfwfmH98r3/G1v9kRiXagE1+1/SNDAgjKPl6ezfrkGB0w9yozDxJNn
Oo1AeQUzqg+C+0Nd22nizcN/hYS6yubRD17jr1vNfBUeu/ych9ReCdXh704jPBPx
5I3jiiXNEoiNICG86G2ef4w+vIY6aFBaDq4V62jisVLlNpCe3ePY6zL0wpJ+qXdY
v1Nh0RWn7m2lCPKXp5OhloUSq/qaPUzhBx2chtRe54L+D5sjrFpxpJlqlpJ0A9/D
gydwxvpZI5nBH4oKICaaoHVXibV/lBZycGFfr0jnupIps8yA2W3fCAk+GqL59KJT
MAVSeIzri1lWHM1bp36zNJR9gCsRMJuRPqfRlw9d7UnZVLvQQ5AfzRXEo9xCNpd0
vip39/+m6kRJX4/2dkwnpwzc3ietfZ+yWn43SsvrLM82xrx1eIth0+r/+SzmwoxE
xZlD4aqWzl7D5q/3GsBZ8DQ1A8OCbqL43QFuGvE4zekOf3O7KQf1XLtdEzPDTlJt
4v/cx+luPDJ3gdahnUIbE7eQTAgpY+6+2z4iUrkHuhi/uWGTsHdONfCG5jZ3XX4o
b8q8VrPtxqIrQI2ZBSBu0FOrdllmbKrCXFRunnUvFddYr+rtWDSmPBGq9soGEFcL
1U/qE28JTwde8ga6Iidr
=t4sH
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
