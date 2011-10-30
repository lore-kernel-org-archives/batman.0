Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Oct 2011 16:36:00 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111030153600.GA3234@pandem0nium>
References: <1850275.SO2QzbpOTm@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <1850275.SO2QzbpOTm@sven-laptop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] Weird TTL for ICMP packets
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


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sven,

although looking a little bit confusing, this seems to be correct. The TTL
field is used to transport the kernel modules compat version when it differs
=66rom the one used in batctl.

Compare the batctl code (ping.c:284):
               switch (icmp_packet_in.msg_type) {
[...]
               case PARAMETER_PROBLEM:
                        printf("Error - the batman adv kernel module versio=
n (%d) differs from ours (%d)\n",
                                        icmp_packet_in.ttl, COMPAT_VERSION);
                        printf("Please make sure to compatible versions!\n"=
);
                        goto out;
[...]

However, I guess an explaining comment in the kernel code would not be wron=
g ...

Cheers
	Simon


On Sun, Oct 30, 2011 at 02:31:55PM +0100, Sven Eckelmann wrote:
> Hi,
>=20
> just looked through some ICMP code in icmp_socket.c and found a little bi=
t=20
> weird TTL:
>=20
> 218         if (icmp_packet->version !=3D COMPAT_VERSION) {              =
                                                                       =20
> 219                 icmp_packet->msg_type =3D PARAMETER_PROBLEM;         =
                                                                       =20
> 220                 icmp_packet->ttl =3D COMPAT_VERSION;                 =
                                                                       =20
> 221                 bat_socket_add_packet(socket_client, icmp_packet,=20
> packet_len);
> 222                 goto free_skb;                                       =
                                                                     =20
> 223         }
>=20
> It was introduced by dba95eb270ff9674326865a20d25921c69c04d6c. My guess i=
s=20
> that TTL should be used.
>=20
> Kind regards,
> 	Sven



--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6tbuAACgkQrzg/fFk7axbNWgCcCqfpogssYx3sk1Jo2z7vDmJd
6/cAoIoqK/useBJ+c2MkaBNbUzbYz99y
=Jo5q
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
