Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 02 May 2016 21:17:04 +0800
Message-ID: <1683361.EIP8vDbSFE@voltaire>
In-Reply-To: <1460626198-31226-1-git-send-email-a@unstable.cc>
References: <1460626198-31226-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1871749.M50srL4DPq";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batctl: tcpdump - filter OGM and
	OGMv2 packets independently
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
Cc: Antonio Quartulli <a@unstable.cc>, Antonio Quartulli <antonio@open-mesh.com>

--nextPart1871749.M50srL4DPq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, April 14, 2016 17:29:57 Antonio Quartulli wrote:
> for debugging purposes it might be required to dump either OGMs
> or OGM2s only. For this reason it is better to make the tcpdump
> engine more flexible and accept distinct filters for the two
> packet types.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  tcpdump.c | 15 ++++++++-------
>  tcpdump.h | 15 ++++++++-------
>  2 files changed, 16 insertions(+), 14 deletions(-)

Applied in revision f29682c.

Thanks,
Marek

--nextPart1871749.M50srL4DPq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXJ1NQAAoJEFNVTo/uthzA1aAIAKIrW8lGsVIyifphCCkUkwIK
ebeejcMxFH5HQvW6DbDQm7XPxBMceX2YivgsmqYIHBoV0B3Lv0DiTnyHWqCP/b93
NiAXLy2Kkk8MyH0Nk+T75AVFEzUnVAp8DqTzvLztAXK8R9W31hRFBywa34k3Y8SS
jA/luhCt8cS5EASYInTV1KpsvriJc3Wirm/747BSlKI3ODcJIZ0Rx442x/EAdXc0
XQQgD0mouGfuz2ZWoUSyIBrRad6cQOu5z0FdjL1CWNE0Rnee83+v3L8XlzZeEJRJ
pArFj7R2yHgJTurT3H1yQVkEe/PpAHt2tZiWThIDiEqrjuvJFXivAvDGaeczQt4=
=m/TN
-----END PGP SIGNATURE-----

--nextPart1871749.M50srL4DPq--

