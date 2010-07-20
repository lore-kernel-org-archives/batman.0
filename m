Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Jul 2010 09:54:24 +0200
References: <20100719133841.babc9ccb.sfr@canb.auug.org.au>
	<20100719172310.87625ce4.randy.dunlap@oracle.com>
In-Reply-To: <20100719172310.87625ce4.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2108864.q7q34zZLvs";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007200954.25629.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH -next] staging: don't use default
	init_module/cleanup_module function names
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
To: b.a.t.m.a.n@lists.open-mesh.org, Randy Dunlap <randy.dunlap@oracle.com>

--nextPart2108864.q7q34zZLvs
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Randy Dunlap wrote:
> Fromy: Randy Dunlap <randy.dunlap@oracle.com>
>=20
> Fix two staging drivers to use module_init()/module_exit()
> instead of default init_module() and cleanup_module() function names
> so that there are no name conflicts when both are built-in.
>=20
> drivers/staging/dt3155/built-in.o: In function `cleanup_module':
> (.text+0xc0): multiple definition of `cleanup_module'
> drivers/staging/batman-adv/built-in.o:(.text+0x330): first defined here
> drivers/staging/dt3155/built-in.o: In function `init_module':
> (.text+0xe60): multiple definition of `init_module'
> drivers/staging/batman-adv/built-in.o:(.text+0x400): first defined here
>=20
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Scott Smedley <ss@aao.gov.au>
> Cc: Marek  Lindner  <lindner_marek@yahoo.de>
> Cc: Simon  Wunderlich  <siwu@hrz.tu-chemnitz.de>
> Cc:	Andrew Lunn <andrew@lunn.ch>
> Cc:	b.a.t.m.a.n@lists.open-mesh.net
> Cc:	Greg Kroah-Hartman <gregkh@suse.de
> ---

@Randy Dunlap: Thanks a lot for your patch.

The Patch was splitted and added to maint. Can somebody please add it to=20
trunk.

Best regards,
	Sven

--nextPart2108864.q7q34zZLvs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMRVYwAAoJEF2HCgfBJntGR5sP/3EbYBVVpRweNk1+nlrjkj4G
B0wlvxeRE4uBPXLkzR3qK8IQ0cugLM3C0XiHv5IH7qfhiFwuokjiECiDsDqDnsGW
vhFYPSxfFx8TQvfQdSjkpAflbCyo/N5okkxKF1v760LBeoQLq++xRjQ8aS/pyg5m
kLDV38k/pcNn9CoSPHvA22y6YuSHWgbH2CfeHoOcIAA6mzWEsRLYz0/iv00ijPaW
nimGNC+pU2E/Q8gjvYVDtZASXDgfoJDFK++R76rLvDLOEMNebxqApUZGfUcZNBru
J/3zStz+eyt7wDBa+kPgKU5mLTDNxgLvQSx1XDOZ7PUKtQgOzuSCav+kc6KIH9CY
YMyB40d+azwqE8HC/eqhRt1WsT0t7AICeMTzC5qQWafJFZ0h9E60UBOmigpODjXv
8vtOibixy+C9ZE+MQQe4D9SicJBDXffmy0Cw6gV50z9w13HNLS6pM0UpvLdtti49
DDTYcC1X15Pg9YvkkmKyA5L73Sodr1PmEmUVsEA6yta3b2+xWdkSsVlYEN82VVs0
01hyf0TF5mUuM1fVRkN8yS8vkxHjxh4AZcRgAlvWvZRiFi04zdqlp7C06C06EKDf
xaeT/v1C7tpJpCQbw7Sk6yzjrHEIU8huK4ZN12HQWRijYagAy3/S46f9MlG9vtaA
wBtHmcY5IaVHl6qXwD0w
=0QfE
-----END PGP SIGNATURE-----

--nextPart2108864.q7q34zZLvs--
