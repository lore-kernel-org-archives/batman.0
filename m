Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 05 Mar 2018 07:32:35 +0100
Message-ID: <2065896.eJjkvJvhLt@sven-edge>
In-Reply-To: <0272f809d25b41fcab4ec5c4b66014f5e341d424.1516792897.git.mschiffer@universe-factory.net>
References: <0272f809d25b41fcab4ec5c4b66014f5e341d424.1516792897.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1715139.anJIEOCtbX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH RFC] batman-adv: always assume 2-byte
 packet alignment
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

--nextPart1715139.anJIEOCtbX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 24. Januar 2018 12:21:37 CET Matthias Schiffer wrote:
> NIC drivers generally try to ensure that the "network header" is aligned
> to a 4-byte boundary. This is not always possible: When Ethernet frames are
> encapsulated in other packets with 4-byte aligned headers, the inner
> Ethernet header will have 4-byte alignment, and in consequence, the inner
> network header is aligned to 2, but not to 4 bytes.
> 
> Most parts of batman-adv only care about 2-byte alignment; in particular,
> no unaligned accesses occur in performance-critical paths that handle
> actual payload data. This is not true for OGM handling: the seqno and crc
> fields are accessed as 32-bit values. To avoid these unaligned accesses,
> this patch reduces the expected packet alignment to 2 bytes for all of
> batadv's packet types.
> 
> As no unaligned accesses existed on the performance-critical paths anyways,
> this chance does have any (positive or negative) effect on performance, but
> it still makes sense to avoid these accesses to prevent log noise when
> examining other unaligned accesses in the kernel while batman-adv is
> active.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  include/uapi/linux/batadv_packet.h | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

As discussed earlier, this was applied as 0509fc0c128b [1] after David Miller 
pulled it in net-next.

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/0509fc0c128ba2891770305c57c9b6a3a61ea7bd

--nextPart1715139.anJIEOCtbX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqc5IMACgkQXYcKB8Em
e0Y0JBAAo9aOg7HemG056p0LAdE+VdT9MK/kW6UGWNi2915/qyYHcHFmjIfAj+Yk
KY3l3AXNJrQTPp+X+JzvM9tC+ykXA9l0ls8y8OcnpTkUU/Kuib1uFOAd7xOhL4DT
kXF7muxEoOOY7xlyu9+ccH1wTNEF+D9JvRfJZDbfgGwW7dQGJOdLeMlGcOXtuuBL
sN4nCSt47DWJQWIAQ9sUJNyMBgD7Rm2dHQQsbLsgh8Ino82cxPf6EHSg98ObKudY
IpsaDh5OwNz5s69Kz3/Q37crFd5nnzdRyQrfV280znb2Bu5zPmlFItb5Xz3UR1rP
bzZs7cqMNjcpzEZFdVoHmLsELDypxhQ0sqeoeEMixD5NQMNRIDGyq1EFZ/ahK4IP
IM3oQCb1mReR13H0nh0MKHMRxfrvPn2fa2NXFUzm/iF7c7/hSr2ZL+Hn1WcbUhtB
d5YsiP5Iy9J9yl2jYgKbhzo9dnu78S67g+uuvlbRsH821dlEWfElf8GW8cSARzWZ
ddKynto9LxFFsXWHRlxmbht75y3D5qQLmuZQDWpITpw5eFHooaFWMgfrrxPAzWMl
9MRdW9kuu1H4RbWbdGHQBvwXkg471eZZXR3oCl1Fltos4d3k6KIMVCHdxPemv1e5
x1Ol1b0zUSHq4YcOFuCYRf2wlNrAfHDp5Pft5eqJubr3Sa8SkFg=
=Agjf
-----END PGP SIGNATURE-----

--nextPart1715139.anJIEOCtbX--

