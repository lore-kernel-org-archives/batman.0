Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 01 Nov 2014 21:59:41 +0800
Message-ID: <6288964.lM668JhyGs@diderot>
In-Reply-To: <1408547097-23491-1-git-send-email-antonio@meshcoding.com>
References: <1408547097-23491-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2510758.uRVFHmiyIM";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batctl: tcpdump - parse TVLV containers
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart2510758.uRVFHmiyIM
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday 20 August 2014 17:04:57 Antonio Quartulli wrote:
> @@ -494,14 +632,32 @@ static void dump_batman_iv_ogm(unsigned char
> *packet_buff, ssize_t buff_len, int printf("BAT %s: ",
>                get_name_by_macaddr((struct ether_addr
> *)batman_ogm_packet->orig, read_opt));=20
> -       printf("OGM IV via neigh %s, seq %u, tq %3d, ttl %2d, v %d, f=
lags
> [%c%c%c], length %zu\n", +       tvlv_len =3D
> ntohs(batman_ogm_packet->tvlv_len);
> +       printf("OGM IV via neigh %s, seq %u, tq %3d, ttl %2d, v %d, f=
lags
> [%c%c%c], length %zu, tvlv_len %zu\n", get_name_by_macaddr((struct
> ether_addr *)ether_header->ether_shost, read_opt),
> ntohl(batman_ogm_packet->seqno), batman_ogm_packet->tq,
> batman_ogm_packet->ttl, batman_ogm_packet->version,
> (batman_ogm_packet->flags & BATADV_NOT_BEST_NEXT_HOP ? 'N' : '.'),
> (batman_ogm_packet->flags & BATADV_DIRECTLINK ? 'D' : '.'),
> (batman_ogm_packet->flags & BATADV_PRIMARIES_FIRST_HOP ? 'F' : '.'),
> -              (size_t)buff_len - sizeof(struct ether_header));
> +              check_len, tvlv_len);
> +
> +       check_len -=3D sizeof(struct batadv_ogm_packet);
> +       LEN_CHECK(check_len, tvlv_len, "BAT OGM TVLV (containers)");

    CC tcpdump.o
tcpdump.c: In function =E2=80=98dump_batman_iv_ogm=E2=80=99:
tcpdump.c:59:24: warning: comparison between signed and unsigned intege=
r=20
expressions [-Wsign-compare]
 if ((size_t)(buff_len) < (check_len)) { \
                        ^
tcpdump.c:646:2: note: in expansion of macro =E2=80=98LEN_CHECK=E2=80=99=

  LEN_CHECK(check_len, tvlv_len, "BAT OGM TVLV (containers)");
  ^

Cheers,
Marek


--nextPart2510758.uRVFHmiyIM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUVOdRAAoJEFNVTo/uthzAX4IH/j0z8km50tcEHd6Se+XWKvmc
rzWDWjJ0gSdNfA/pfuydjxgVPZAkz9ACuvOrVnKq8a80S/Xm8vJcV9VsxdI8Lpdk
A924Q9RvpZ6fkLrqmJ1C3Jor/eog2ZnWfMil3g7g5yf7J/XL5UvTygU8LPKHMkb4
6RDRjWdMsz64R4hxLUurkr7PYB+1BEAJ7QoA6HY1lOsDNzRiOTvx7C6mKevVVFqY
JauNRiSqs3cxcj7/V4xrdyaSo2f2e62IslLogK2qalumVs9/mV+ZFvKut0I7KR4/
ez2wkDtu4ZYyX8HtfJDra/osCZ5FQggAp21XywfVhvmysdfEBen2h5RZvz9kk2c=
=sgSS
-----END PGP SIGNATURE-----

--nextPart2510758.uRVFHmiyIM--

