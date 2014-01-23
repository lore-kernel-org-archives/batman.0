Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 23 Jan 2014 15:28:03 +0800
Message-ID: <5034967.hgA2iMUalq@diderot>
In-Reply-To: <1389037044-27530-1-git-send-email-sven@narfation.org>
References: <6312194.LhI8hzXjyH@bentobox>
 <1389037044-27530-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17841686.y8L8hCRXCM";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batctl: Avoid name clash "rtnl_open"
	with libnl
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart17841686.y8L8hCRXCM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 06 January 2014 20:37:22 Sven Eckelmann wrote:
> libnl is used in Debian to avoid code duplication which should be avoided to
> reduce maintenance and security risks. This library already provides a
> function called rtnl_open and therefore has a name clash with the self
> defined function.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  functions.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied in revision f8eb19d.

Thanks,
Marek

--nextPart17841686.y8L8hCRXCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS4MSHAAoJEFNVTo/uthzAo2EH/2cRy0WnYvcaZixD7wVEM+hh
B6cPU9nwQOnsPCzXIG0bTXaVb95QYb/wAAbbNXLigwhCOq0Kijr27fg1K16Ph7oK
hGhT6LGayeD0bifYh+73lZBXW9+AgRhz42jrISDMV8llChIvh1AlE277g6hHnqg4
V+cMNkW+esIfHH3NxP8gEGS/1nqR/Wq+QoWMWSGhVpsU3z3sLKmoE3g2OYHfmscP
Jh/Un9UjpqHni0hrdhA34g8pxC2mgpbhdSDTtFSEVPPOfztgfz8zEX/G6ObEJ9em
JQ7EoFLwCyk8MCiWtSo2ekSxx2XlF+s0/GSw8GJqm/lAYnlJGnSFw2Q9oSpWgh4=
=loCJ
-----END PGP SIGNATURE-----

--nextPart17841686.y8L8hCRXCM--

