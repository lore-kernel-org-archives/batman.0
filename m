Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:34:08 +0800
Message-ID: <3846807.JRoIHB1LLU@voltaire>
In-Reply-To: <1468597173-25378-12-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-12-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1801617.Ck4PnC0poU";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 12/18] batman-adv: Place kref_get for
	gw_node near use
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

--nextPart1801617.Ck4PnC0poU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:27 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/gateway_client.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied in revision b7981d4.

Thanks,
Marek

--nextPart1801617.Ck4PnC0poU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjeYAAAoJEFNVTo/uthzA2CYH/3EBKpgyei8hfyof/X1y+pV5
3U9fLWCnKDrEGvVsfj3+9YPXL3FbxtZB1Iof7JLfm1L3U25CMyjikeij5HnZTi+Q
fNp7C/AMUFx/4UpM/UNDXB1Pmp2xiYFPfeWvTLQoINPlPmT6fqJjzVG/PUprw8sV
6RdynQ+/U/c++24ejypkN22iInRAUpQk4713eYl3JxmMLQGVUybOOsFszn/YSw7z
YXlF0kVl+bHymMRc2e4C2XcqWC7XZrx293hy1FtzIISSu2/e53YYkTWA1z2X8P/b
hRPNvHYB0nGn07ANBPGBMjdN3kADBdTB6qgm0QWiYq5mUox649gNfkrGdrkjbpY=
=3KlF
-----END PGP SIGNATURE-----

--nextPart1801617.Ck4PnC0poU--

