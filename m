Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 22:11:27 +0800
Message-ID: <1960157.aAM15XqZBq@voltaire>
In-Reply-To: <1458478815-22693-1-git-send-email-sven@narfation.org>
References: <1458478815-22693-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11055884.l294TKncYV";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Drop support for Linux < 3.2
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

--nextPart11055884.l294TKncYV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 20, 2016 14:00:15 Sven Eckelmann wrote:
> The Linux Kernel 2.6.32 reached its end of life [1] after over 6 years.
> Instead it is recommended to use at least kernel 3.2 which is also already
> over 3 years old. All older kernels (v2.6.29 - v3.1) should therefore be
> dropped to reduce the support overhead.
> 
> [1] https://lkml.org/lkml/2016/3/12/78
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision a986940.

Thanks,
Marek

--nextPart11055884.l294TKncYV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+TuPAAoJEFNVTo/uthzAGlQH/if9DS6ORGkdGEbCWNKAq5HM
Rdbs3Uf/aMRjpEUUYra2KLaNgCgi5V5GFVxL29267ZlBBzzCz8qpdPLnOdBlMKdB
Dy1++JbJLBk6qj3tXJKOJixqf4tuBoi2QzMj+yQ9kOm3k9Re5DPUW5Kjg1F16Xb8
UKM6ruhb9U6c8xrejPox81S1t+nNWbag22tRcubfyLHvr0V8Z9vztfWgVjBGGcvP
xFYmV1Eub+D8i1ePfN0ybA33JFVCmXugcxntFa9T4201AM4ONPfByNi2erQaO2x+
LwxG2qzWY232XBz9xo8upvcevU/wMuYnZBcIx2ng/h68zE/FPoyM2Fs7Wga2jQA=
=jw/l
-----END PGP SIGNATURE-----

--nextPart11055884.l294TKncYV--

