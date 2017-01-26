Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 26 Jan 2017 09:02:42 +0100
Message-ID: <2386493.UlzfeklEWr@bentobox>
In-Reply-To: <1485395221-3515-1-git-send-email-jhaws@sdl.usu.edu>
References: <1485395221-3515-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3281262.yXyEBaV3rQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5] alfred: IPv4 multicast distribution
	support.
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

--nextPart3281262.yXyEBaV3rQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 25. Januar 2017 18:47:01 CET Jonathan Haws wrote:
> Enabled via -4 expert option where multicast group address is specified.
> This option will disable IPv6 communication and is intended for use in
> networks which do not support IPv6 addressing.
> 
> When this option is enabled, all IPv6 communication is disabled. Combining
> IPv4 and IPv6 alfred nodes is unsupported.
> 
> Hardware address handling done by submitting queries to the local ARP
> cache rather than forcing an ARP request.
> 
> Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
> ---
>  README         |   4 +-
>  alfred.h       |  23 ++++++---
>  batadv_query.c |  50 +++++++++++-------
>  batadv_query.h |   6 ++-
>  client.c       |   2 +-
>  main.c         |  10 +++-
>  man/alfred.8   |   5 ++
>  netsock.c      | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  recv.c         |  63 ++++++++++++++++-------
>  send.c         |  48 +++++++++++-------
>  server.c       |   8 +--
>  unix_sock.c    |   2 +-
>  util.c         |  30 +++++++++++
>  13 files changed, 328 insertions(+), 81 deletions(-)

Reviewed-by: Sven Eckelmann <sven@narfation.org>

--nextPart3281262.yXyEBaV3rQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliJrSIACgkQXYcKB8Em
e0a1kg/8CiFZzcohqERrImQfZnM8VVshjbmkyb3Kb8J24z2IZf7qVsAClgG7znuv
zrV7LDgk7CupevY+MzZM+PupdX1mFBk1uRqYZ18M7l6t87NMd41QNZYZQr7cjLz4
g5PiGWQOGQMLpeVFZkGUnhQ78psIRdBXQ1DyODAv6zySXFmTDbo7RdXvtPYUpr3I
9R1HGLg2zLRazVklwPyiKvguhCM2uGdVjM6UVzCgKfcHi49XmrgRPeXfBjwHqjf6
IFyEJ4/H7H4XxLuh6lahYv8OsLKWetxNgilgmbWUjj/x7m79er+ovhNYAqrnr78/
xgnrqpc5ZLThh3tEcYZlyfVGklbfGRu5PZp3wpORrJoKiW40GLa+pVrbalHLvGbt
XWreGKtvNdVo5MNxJ5qz0A2vX4rtkt4x+nc47IUk/h4IS7dgszBiQXdzfxzj5t+l
4bHTS6p5wnf014+VGlUswcJZrEJDrjyyfg8STE12/SLK2QGeD80vYmlUKbNeTmDp
zt3wfHICfROMnF914mSXEF0Xz7Z4PFi5b++WUHhgnXrh8FhY8GkdR+LpDfYJ3jUp
XYOC5kdaBlVePy3rhcabUGI2TNs1gxwyjpS4pim5HpIzD3w84wCSPZ68MN7e1uMt
UnYVv34Zye3FTFSfIhNO8vYQanEbDyyoVtcKxkFrhwTmGYlkJoo=
=4VG+
-----END PGP SIGNATURE-----

--nextPart3281262.yXyEBaV3rQ--

