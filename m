Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 3 Jun 2010 01:23:11 +0200
References: <1275509418.23599.42.camel@Joe-Laptop.home>
In-Reply-To: <1275509418.23599.42.camel@Joe-Laptop.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2454656.PmTjFHm0mn";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006030123.25027.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] drivers/staging/batman-adv: Convert
	MAC_FMT to %pM
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: devel <devel@driverdev.osuosl.org>, b.a.t.m.a.n@lists.open-mesh.net, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Joe Perches <joe@perches.com>, Marek Lindner <lindner_marek@yahoo.de>

--nextPart2454656.PmTjFHm0mn
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Joe Perches wrote:
> Remove the last uses of MAC_FMT
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/staging/batman-adv/main.c              |    3 +-
>  drivers/staging/batman-adv/translation-table.c |   25
> ++++------------------- 2 files changed, 6 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/staging/batman-adv/main.c
> b/drivers/staging/batman-adv/main.c index 74c70d5..72851cd 100644
> --- a/drivers/staging/batman-adv/main.c
> +++ b/drivers/staging/batman-adv/main.c
> @@ -226,8 +226,7 @@ void dec_module_count(void)
>=20
>  int addr_to_string(char *buff, uint8_t *addr)
>  {
> -	return sprintf(buff, MAC_FMT,
> -		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
> +	return sprintf(buff, "%pM", addr);
>  }
[...]

Thanks for your patch.

We must currently support older kernels which doesn't support %pM. Thats wh=
y=20
we have an extra wrapper for printk in the out-of-kernel module. The same=20
would have to be done for sprintf as well. Most of the developers are=20
currently attending the Wireless Battle Mesh v3 - so the processing of that=
=20
patch is delayed a little bit.

The same problem arises with your patch "Use (pr|netdev)_<level> macro help=
er"=20
(which seems to be added in 2.6.34). But I think we could add a wrapper for=
=20
older kernels easily - but as mentioned before this is probably postponed=20
until next week or so.

You've also changed the output. So you may partly broke batctl too (have to=
=20
check that first).

Best regards,
	Sven

--nextPart2454656.PmTjFHm0mn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMBufgAAoJEF2HCgfBJntGzcQP/RLrsw4qFAPlm/k4awUVVu5j
mJe43dBmEwxpdU8tp1RwfUSBCn+EKLcSx74IRnZVi2JY5cj/hLS3DqPZ2gjEJEOB
N/7zWz8NCvugaRIkIFGkgfX4lRV+mbWoqxusYaFSQ8ngkM/n1kLNC/gjsz/o8cCE
EM8vCZTWTplCiE8e48CHVO7TwAGhCho33SPBx6jwkhtVpvGRLYrscMxV57/Oz8xf
I+/h/3S2IImQbNvL+HzV0DgTbtZIjD6riEVE2XOktekq4j2m+FuTDEZT3Ksg+Wxu
LMpbr3ZNT9g/CE1mbsErTeYVziWcY72y7yxQcRDdhMvAuew70nQY9PrXy1B+YYix
zNuWI2AChDDv0ar5QVNiiOfJV4uHbKjGjRmkLepes0Ev2hxQnyXEUksjWCZuIEmw
mGqFfodfCysNmnBXYK5l9GEjjGkU7zMrIyWD+zNI83MSSMPZVx53kbEvFKIYvbIB
ib2HDAY8ek0O8mApL0pb/qhekQLIQUwTcHqvbTgIwr47lWagzM9nxaxPtONGQg8b
Z1TBETh6+xJxF8s/W2Mv01jn2d2X5Yg2QumhhYVwgLhE/bx38QuOfGeM5+v9AqYv
58p9PvMOqtoGOSlrpuSL48piaXhc2S5DktThLzpFFvr2F50TuIjax0+j0tMnlWs1
c+TrrlLd5bygFdwm98bj
=ZY5k
-----END PGP SIGNATURE-----

--nextPart2454656.PmTjFHm0mn--
