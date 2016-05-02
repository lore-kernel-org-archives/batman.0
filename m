Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 02 May 2016 22:04:13 +0800
Message-ID: <2815997.TuhcixZTPn@voltaire>
In-Reply-To: <1460626198-31226-2-git-send-email-a@unstable.cc>
References: <1460626198-31226-1-git-send-email-a@unstable.cc>
 <1460626198-31226-2-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5156062.yDRVlJV2bR";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: tcpdump - use proper format
	string when printing help message
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

--nextPart5156062.yDRVlJV2bR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, April 14, 2016 17:29:58 Antonio Quartulli wrote:
> +       fprintf(stderr, " \t\t%3lu - batman ogm packets\n",
> DUMP_TYPE_BATOGM); +       fprintf(stderr, " \t\t%3lu - batman ogmv2
> packets\n", DUMP_TYPE_BATOGM2); +       fprintf(stderr, " \t\t%3lu - =
batman
> elp packets\n", DUMP_TYPE_BATELP); +       fprintf(stderr, " \t\t%3lu=
 -
> batman icmp packets\n", DUMP_TYPE_BATICMP); +       fprintf(stderr, "=

> \t\t%3lu - batman unicast packets\n", DUMP_TYPE_BATUCAST);
> +       fprintf(stderr, " \t\t%3lu - batman broadcast packets\n",
> DUMP_TYPE_BATBCAST); +       fprintf(stderr, " \t\t%3lu - batman frag=
mented
> packets\n", DUMP_TYPE_BATFRAG); +       fprintf(stderr, " \t\t%3lu - =
batman
> unicast tvlv packets\n", DUMP_TYPE_BATUTVLV); +       fprintf(stderr,=
 "
> \t\t%3lu - non batman packets\n", DUMP_TYPE_NONBAT);
> +       fprintf(stderr, " \t\t%3lu - batman ogm & non batman packets\=
n",
> DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);

$ make
    CC tcpdump.o
tcpdump.c: In function =E2=80=98tcpdump_usage=E2=80=99:
tcpdump.c:86:18: warning: format =E2=80=98%lu=E2=80=99 expects argument=
 of type =E2=80=98long unsigned=20
int=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99 [-Wformat=3D=
]
  fprintf(stderr, " \t\t%3lu - batman ogm packets\n", DUMP_TYPE_BATOGM)=
;
                  ^
tcpdump.c:87:18: warning: format =E2=80=98%lu=E2=80=99 expects argument=
 of type =E2=80=98long unsigned=20
int=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99 [-Wformat=3D=
]
  fprintf(stderr, " \t\t%3lu - batman ogmv2 packets\n", DUMP_TYPE_BATOG=
M2);
                  ^
tcpdump.c:88:18: warning: format =E2=80=98%lu=E2=80=99 expects argument=
 of type =E2=80=98long unsigned=20
int=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99 [-Wformat=3D=
]
  fprintf(stderr, " \t\t%3lu - batman elp packets\n", DUMP_TYPE_BATELP)=
;
                  ^
tcpdump.c:89:18: warning: format =E2=80=98%lu=E2=80=99 expects argument=
 of type =E2=80=98long unsigned=20
int=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99 [-Wformat=3D=
]
  fprintf(stderr, " \t\t%3lu - batman icmp packets\n", DUMP_TYPE_BATICM=
P);
                  ^
tcpdump.c:90:18: warning: format =E2=80=98%lu=E2=80=99 expects argument=
 of type =E2=80=98long unsigned=20
int=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99 [-Wformat=3D=
]
  fprintf(stderr, " \t\t%3lu - batman unicast packets\n", DUMP_TYPE_BAT=
UCAST);
                  ^
tcpdump.c:91:18: warning: format =E2=80=98%lu=E2=80=99 expects argument=
 of type =E2=80=98long unsigned=20
int=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99 [-Wformat=3D=
]
  fprintf(stderr, " \t\t%3lu - batman broadcast packets\n",=20
DUMP_TYPE_BATBCAST);
                  ^
tcpdump.c:92:18: warning: format =E2=80=98%lu=E2=80=99 expects argument=
 of type =E2=80=98long unsigned=20
int=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99 [-Wformat=3D=
]
  fprintf(stderr, " \t\t%3lu - batman fragmented packets\n",=20
DUMP_TYPE_BATFRAG);
                  ^
tcpdump.c:93:18: warning: format =E2=80=98%lu=E2=80=99 expects argument=
 of type =E2=80=98long unsigned=20
int=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99 [-Wformat=3D=
]
  fprintf(stderr, " \t\t%3lu - batman unicast tvlv packets\n",=20
DUMP_TYPE_BATUTVLV);
                  ^
tcpdump.c:94:18: warning: format =E2=80=98%lu=E2=80=99 expects argument=
 of type =E2=80=98long unsigned=20
int=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99 [-Wformat=3D=
]
  fprintf(stderr, " \t\t%3lu - non batman packets\n", DUMP_TYPE_NONBAT)=
;
                  ^
tcpdump.c:95:18: warning: format =E2=80=98%lu=E2=80=99 expects argument=
 of type =E2=80=98long unsigned=20
int=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99 [-Wformat=3D=
]
  fprintf(stderr, " \t\t%3lu - batman ogm & non batman packets\n",=20
DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
                  ^

Cheers,
Marek

--nextPart5156062.yDRVlJV2bR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXJ15dAAoJEFNVTo/uthzAHxUIAJ2KKJW0UCE0wGscslkqkrlV
1CwepyS4fYnh/dsqwCe56pV/Dzy5GGjKv/bWgEx7CmpshhGJxXp816bDU7nFCZUF
So13phoJHyCRvI+BgCslcc93ayR/y3SjMt3nrAZLzAJV1kolxys2rCyWamuTKw5w
R6Ei6skTwHv0DHm53vVj4FQVgeXh8bJLPmYgkbm+iSLMSd1nPF67e7l2ye/daOyZ
jqsY2cQRgu8B5Ag7pxeWXyss/YbZFf6xV3hn8hmQe1vV5NggjSc0uq7qRzhOpvRt
ssnVQd4V5zbXABd86qnIe+q8SVFIXSlgKGXfSGX9IC5VAXE8U9nmRM4j8cHxazk=
=YBHf
-----END PGP SIGNATURE-----

--nextPart5156062.yDRVlJV2bR--

