Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 Jun 2014 22:49:14 +0800
Message-ID: <2703678.tX0ZXICNkm@diderot>
In-Reply-To: <1400933804-9661-3-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
 <1400933804-9661-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1800280.V6z4jec8jo";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/6] batctl: Use strncpy instead of
	strcpy for string copy
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


--nextPart1800280.V6z4jec8jo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 24 May 2014 14:16:41 Sven Eckelmann wrote:
> The data used in strcpy is partially provided by the user. This can be
> larger than the destination buffer and thus overwrite data after the actual
> string buffer. This can easily be avoided by using strncpy.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  debugfs.c | 4 +++-
>  ioctl.c   | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Applied with minor modification in revision a9e88d8.

Thanks,
Marek

--nextPart1800280.V6z4jec8jo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTlxrqAAoJEFNVTo/uthzAuioIALj0CY3P7W0PskPjnrMrQRL6
NnF9P835ekGsuECYj2weEXvbvRzL7IYV1ce7oBWn2Nzy6Y4pDjcjUC/1MnB1FNuJ
irXSNMBE7nca3qY97CzIQkidFk93zIbkgyZUaGtM5UvjVEQRr9Er1G/vb5nUuw2D
enduN3Yt4dbp1vttqQ7CR7UIP1MCvsyfc7kQDHD7KMqyjaalUIgyXicmkiBQYajq
sLdvOu81Rr9nVetbeJVejtSwlCpfjHS1ZiMSKM9BWmyYGupcJ/dwqBJVHVkCank4
MshvFyleVxg38rYTGHCFpbIKJGammLbP8MMRdUWAlRy/5/09UEM6LlcRIyGMRNw=
=vnM/
-----END PGP SIGNATURE-----

--nextPart1800280.V6z4jec8jo--

