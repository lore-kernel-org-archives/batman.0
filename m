Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 Jun 2014 22:59:53 +0800
Message-ID: <20061782.ulKJ9MBCko@diderot>
In-Reply-To: <1400933804-9661-6-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
 <1400933804-9661-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3669949.eERVfW5sgg";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/6] batctl: Don't provide uninitialized
	parameter to read_file
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


--nextPart3669949.eERVfW5sgg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 24 May 2014 14:16:44 Sven Eckelmann wrote:
> The debug table function uses a parameter to filter out old originator nodes
> when read_file processes the file. The variable is by default not
> initialized and still given to this function. This is bad practice and
> irritates checker tools.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision cc9e48b.

Thanks,
Marek

--nextPart3669949.eERVfW5sgg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTlx1pAAoJEFNVTo/uthzAaZ0H/2aMbpKiEiBOkQuB17qda0yr
WnE8ovfafLfxNZVkEArzmdLp0lfRbNPhPvSbHIsb2rnnPYAjB43ZbDwHAgaFO4lr
wailwgVHZfPN5tPa23qYThNnSmCMdWki8dviPt4cKIsxY3Bw2phxDsDOuCWIGwSP
1MrBwpYB/zvbT4Ih1cVXxgnPDMmDQjCuDSHlnQlxSvL3p8qmq8/J3Hl89jmQugoZ
sKbJyKF5QpsCBomf6pqCT9egRmWaTMP/gTmLay2Ks9NrVWVDqJUEGqUkBKoCKITc
OgnMxhkaKaDyI0TItmokug+Ka3bT59eXdJMP4gQloNkbU40ZOV7IdBb14y4yPE4=
=nI1/
-----END PGP SIGNATURE-----

--nextPart3669949.eERVfW5sgg--

