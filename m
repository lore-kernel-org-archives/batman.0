Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 26 May 2011 14:45:32 +0200
References: <1306413145-7921-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1306413145-7921-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2021239.dJ3TZHGNoX";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105261445.35168.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: update readme
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart2021239.dJ3TZHGNoX
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Thursday 26 May 2011 14:32:25 Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---

Acked by: Sven Eckelmann <sven@narfation.org>

>  README |   41 ++++++++++++++++++++---------------------
>  1 files changed, 20 insertions(+), 21 deletions(-)
>=20
> diff --git a/README b/README
> index d11c6d3..442f8b6 100644
> --- a/README
> +++ b/README
> @@ -18,8 +18,8 @@ settings.
>  How does it work ?
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> -batctl uses the /dev/batman-adv device provided by the B.A.T.M.A.N.
> advanced -kernel module to inject custom icmp packets into the data flow.
> That's why +batctl uses the debugfs/batman_adv/bat0/socket device provided
> by the B.A.T.M.A.N. +advanced kernel module to inject custom icmp packets
> into the data flow. That's why ping and traceroute work almost like their
> IP based counterparts. Tcpdump was designed because B.A.T.M.A.N. advanced
> encapsulates all traffic within batman packets, so that the normal tcpdump
> would not recognize the packets. @@ -30,8 +30,8 @@ The bat-hosts file
>=20
>  This file is simliar to the /etc/hosts file. You can write one MAC addre=
ss
> and one host name per line. batctl will analyze the file to find the
> matching MAC -address to your provided host name. Host names are much
> easier to remember -than MAC addresses.  ;)
> +address to your provided host name. Host names are much easier to rememb=
er
> than +MAC addresses.  ;)
>=20
>=20
>  batctl ping
> @@ -45,6 +45,7 @@ options:
>           -h print this help
>           -i interval in seconds
>           -t timeout in seconds
> +         -R record route
>=20
>  Example:
>=20
> @@ -95,8 +96,9 @@ options:
>                  4 - batman unicast packets
>                  8 - batman broadcast packets
>                  16 - batman vis packets
> -                32 - non batman packets
> -                33 - batman ogm & non batman packets
> +                32 - batman fragmented packets
> +                64 - non batman packets
> +                65 - batman ogm & non batman packets
>=20
>  Example output for tcpdump:
>=20
> @@ -241,12 +243,12 @@ batctl interface
>=20
>  display or modify the interface settings
>=20
> -Usage: batctl interface|if  [none|interface]
> +Usage: batctl interface|if    [add|del iface(s)]
>=20
>  Example:
>=20
>  $  batctl interface
> -[  active] eth0 fe:fe:00:00:01:01
> +eth0: active
>=20
>  batctl interval
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -270,7 +272,6 @@ Usage: batctl log|l
>  Example:
>=20
>  $ batctl log
> -r)
>  [       400] Received BATMAN packet via NB: fe:fe:00:00:02:01 IF: eth0
> [fe:fe:00:00:01:01] (from OG: fe:fe:00:00:01:01 via prev OG:
> fe:fe:00:00:01:01 seqno 670, tq 245, TTL 49, V 8, IDF 1) [       400] Drop
> packet: originator packet from myself (via neighbour) [       400]
> Received BATMAN packet via NB: fe:fe:00:00:02:01 IF: eth0
> [fe:fe:00:00:01:01] (from OG: fe:fe:00:00:02:01 via prev OG:
> fe:fe:00:00:02:01 seqno 545, tq 255, TTL 50, V 8, IDF 0) @@ -285,15
> +286,14 @@ batctl loglevel
>=20
>  display or modify the log level
>=20
> -Usage: batctl |ll   [level]
> +Usage: batctl loglevel|ll   [level]
>=20
>  Example:
>  $  batctl loglevel
> -[x] critical (0)
> -[x] warnings (1)
> -[x] notices (2)
> -[x] batman (4)
> -[x] routes (8)
> +[x] all debug output disabled (0)
> +[ ] messages related to routing / flooding / broadcasting (1)
> +[ ] messages related to route or hna added / changed / deleted (2)
> +[ ] all debug messages (3)
>=20
>  batctl aggregation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -334,18 +334,17 @@ Globally announced TT entries received via the mesh
> (translation table): * 86:4b:b2:d2:00:00 via fe:fe:00:00:07:01
>   * ca:a1:5b:e5:00:00 via fe:fe:00:00:06:01
>=20
> -batctl vis_server
> +batctl vis_mode
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  display or modify the status of the VIS server
>=20
> -Usage: batctl vis_server|vs  [enabled|disabled]
> +Usage: batctl vis_mode|vm     [mode]
>=20
>  Example:
>=20
> -$ batctl vis_server
> -[x] client mode (server disabled)
> -[ ] server mode (server enabled)
> +$ batctl vis_mode
> +client
>=20
>=20
>  batctl vis_data
> @@ -410,7 +409,7 @@ vis-dot to png
>  --------------
>=20
>  The vis dot output could then further be converted to an image of the
> topology -graph, e.g. with the help of the graphviz-tools. The according
> commands could +graph, e.g. with the help of the graphviz-tools. The
> according commands could then look like this:
>=20
>  $ batctl vis_data dot > /tmp/graph.dot

--nextPart2021239.dJ3TZHGNoX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN3kttAAoJEF2HCgfBJntGGgUQAMsEm9bdRG/DNsA9YlgEO2lp
wMYGPVo1gkCmUVHZI32QMTndm55NZK/2LGnuDYKXolsDBe+YylfyO5KTcGiXx6FK
SCZkNF4FQBg25oaQRYnpZuf5ETV6qtOoUeMdBI2L2z73Zfxm2OiR8qVqdSckkMzT
Lo07zMhA5DfBBg94qFIhi7qvHx4fifZ7my/oVCm+QzakZlpXzU7zw/t9DcPeVp/B
gdlwDTfepr7ptXNmc5oImkobfw45C+V3SKKAw+P3TVlSs3zPy1PV6hovumQYIpT+
SXCYhExaLqHIwuZ47HkGEyRlYVmVUIKiLn2uubO1FFcbEZFWOafVkDPR5Cy9A+LH
j21fIHAUF5wjx86OcdQ0cGm9mQNYKr1F0VYOj9oP1ddz8Dr7BTNEywmPfIM0ALiv
Doc7av2y0B2FegQdh2vVkegBh9aIdJliY+DmUe0zZ+gy1eMu6yArSVRBRqEDRDuQ
P8xwyFCY173DdeON43DDeAYA9Zg+QL/rqKXcVBHIeUK5l6ETF1WM+8qraGjYksGw
KvV6RP8CbxLeRz/DFthQPXIEaW0moRGUOw0LF4sdz0LhsQ8fBl5otFZFzu/uVr62
LdPNGIiRWYN2Kql/+u3btfQXEQR1pwNxnZQCWeByKGW3f1ESEB0UnL5zNAmidVIl
gnXxHX/TmG0rT7YxmKIz
=IP3Q
-----END PGP SIGNATURE-----

--nextPart2021239.dJ3TZHGNoX--
