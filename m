Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Nov 2014 13:24:42 +0800
Message-ID: <3747289.rgQC44iOAt@diderot>
In-Reply-To: <1415815109-17111-1-git-send-email-sven@narfation.org>
References: <1415815109-17111-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart37267149.moHsLJmpGJ";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batctl: Fix crash when parsing
	unknown TVLVs
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


--nextPart37267149.moHsLJmpGJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 12 November 2014 18:58:25 Sven Eckelmann wrote:
> batctl tcpdump has an array with all known TVLVs and versions. The correct
> parser for the TVLV is chosen by getting the pointer from the address
> calculated by version and type. Unfortunately, the version and type was
> never validated to ensure that not an unknown TVLV (like mcast) was
> received.
> 
> This missing validation makes it possible to crash batctl by injecting
> packets with an unknown type and/or version. batctl will try to get the
> parser, fetch a NULL pointer or random data and then try to dereferenced
> it. This is usually handled by the operating system with a segfault. But
> this might be exploitable in rare situations.
> 
> An approach to handle this problem is by combining the simple selection step
> with the validation step. Only valid version+type will return a parser
> function pointer and the requesting function will only call the parser
> function pointer when it got one.
> 
> This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c28ef
> ("batctl: tcpdump - parse TVLV containers").
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  tcpdump.c | 67
> ++++++++++++++++++++++++++++++++++++++++++++++++++------------- 1 file
> changed, 53 insertions(+), 14 deletions(-)

Applied in revision 140882b.

Thanks,
Marek

--nextPart37267149.moHsLJmpGJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUaDUlAAoJEFNVTo/uthzArXEH/iBz4oYpv1tDoargjPJCAGoT
qsUNplQA/iB97e+/oqACPfTuVXsMK655IllySnoynhIszO5DyaLgDIEEfTnUofh8
zf+tZVRceyVL85dwSUXvQkVKhoCUPthMC5l7PUWUouNOmcZxpfnRvjF5w3Ox81d2
GC1mRokTAasB0up3MJGsUT31EbA4OTqBxsCAZGDokWsL+uiDuhIBRPaVTKGV6D+f
c8M1NwQFpSXxCB+bS7Id2gjNZj0GJbjSsUXUxh8Rd/jfghMjyJGiUGgfBldybHwG
Fgm6dATQQSIhkGtnHm8EVDGRvpUFWrgYrbJz0Ad+/80TlZxxusZnDfKq+WbH/sA=
=621d
-----END PGP SIGNATURE-----

--nextPart37267149.moHsLJmpGJ--

