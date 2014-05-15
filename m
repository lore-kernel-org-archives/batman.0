Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 16 May 2014 03:01:50 +0800
Message-ID: <2166697.h3OPWJ6Wsa@diderot>
In-Reply-To: <1400145866-22473-1-git-send-email-antonio@meshcoding.com>
References: <1400145866-22473-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2705636.71M6bS52kM";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove semi-colon after
	macro definition
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart2705636.71M6bS52kM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 15 May 2014 11:24:26 Antonio Quartulli wrote:
> Reported by checkpatch with the following warning:
> "WARNING: macros should not use a trailing semicolon"
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  debugfs.c | 4 ++--
>  sysfs.c   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied in revision f95ce71.

Thanks,
Marek

--nextPart2705636.71M6bS52kM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTdQ8eAAoJEFNVTo/uthzAoVoIALpUSM2gH7ZT2JvSYOajcg1f
9jiFFSQtLSwnA0OYnx2YQ4ESzb88eLGhKJc32q9Y+yzRzbcD05ncZ65skBXlFSH3
6vgffoNwr50WhGIYiUMPE53khXAf3ifagOzt9V2pdtOcno1nIxAaoTLVXFrAI1/a
5W7+OOIbCRwfXhnypmHZ08HjeTdpk+SeSUoFsBvJr5lo345qa+id9p7fRQmAGSBh
YFNA56eadq8oARzevSd6UX5RWmpbR9Q+TZZeDjgUWyi9qpmBweOaJZtN9M9jZIh/
KH2iNurc8/RrDrASq+LaQtbBQSk76DEyLHNwu0eDKuBOlc38V1QJHm1cWJcBuJ0=
=y+lW
-----END PGP SIGNATURE-----

--nextPart2705636.71M6bS52kM--

