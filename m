Return-Path: <antonio@meshcoding.com>
Date: Tue, 17 Sep 2013 17:51:20 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130917155120.GD3053@neomailbox.net>
References: <1379419694-12758-1-git-send-email-marco.dallato@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <1379419694-12758-1-git-send-email-marco.dallato@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFCv2] batctl tcpdump: add IPv6 support to
 tcpdump parser
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


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2013 at 02:08:14PM +0200, Marco Dalla Torre wrote:
> +	switch (iphdr->ip6_nxt) {
> +	case IPPROTO_ICMPV6:
> +		LEN_CHECK(
> +			(size_t)buff_len - (size_t)(sizeof(struct ip6_hdr)),
> +			sizeof(struct icmp6_hdr),
> +			"ICMPv6");
> +		icmphdr =3D (struct icmp6_hdr *)(packet_buff +
> +					       sizeof(struct ip6_hdr));
> +		inet_ntop(AF_INET6, &(iphdr->ip6_src), nd_ipv6_addr, 40);
> +		printf("IPv6 %s > ", nd_ipv6_addr);
> +		switch (icmphdr->icmp6_type) {
> +		case ICMP6_DST_UNREACH:
> +			if ((size_t)(buff_len) < IPV6_MIN_MTU) {
> +				fprintf(stderr,
> +					"Warning - dropping received 'ICMPv6 destination unreached' packet =
as it is bigger than maximum allowed size (%u): %zu\n",
> +					IPV6_MIN_MTU, (size_t)(buff_len));

Is the message wrong? should it be the other way around? "packet is smaller=
 than
minimum size" ? And why should _only_ this ICMP packet be bigger of IPV6_MI=
N_MTU
?

Cheers,

--=20
Antonio Quartulli

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSOHp4AAoJEADl0hg6qKeOdmgQAMUJpTzd3bF9IB6PGP6QRi9i
8lCdypdlRF+jRMXQjCHYevjzLMc94GBvnE5tKbJ4OAZUK9RLNvR3v5yh0v+X8x3T
w3oJaxaxpq72Slqs8+9JNGWBIouz7AlEXSN8wRCkQzlw0uNV9eDa/JCkuAJBKETI
gD4DctT/1b7IurxXscOdXoktpMSSudDD8/Eq/QeEYO7DeGoG88e3zrC2b3A8UNvx
olo1gqKspMVBLIy//5Ohzn6HzgNupGT9jzEYVJwTvUWBvc7Y85BMmh5No8hXEi/J
JMylx9XKCTtTaxOKDoO7bZ6dN1aJyX5YgDfX6fwRbgWmp4nqtGcaaFcER5O+8o3y
/H1M/LcrWVuoDa48R+x4/lLp+QUNJcDI/5lG+oM3BSfLXg801nCxJ7GjH9H++J0I
lqQksYq7XbKvay2vQFybyOQE+xyEEN977LqIdAwTgA+6mF5yDCBQgUdRBCZSiZN2
muW6VxQvHG1HFZw+o5i1JGCTQH3hBZj6cOFsFDr0Rbwtiyc3DFdFxll06AP1aB2z
qD/TRwD3RV873aPqnPXTXxQ60nX3F5gjP96Xbm9FiLxvpfW1P/hmo1o5vBDkhh+9
Or9tuxuEAm+LquLnU3X+kmpZsN+V171KPeQbse4vZ0te5DzMWUZHoWqqt2A/gtzu
YVmwcXGLR4rbuPmKql1e
=p1ki
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
