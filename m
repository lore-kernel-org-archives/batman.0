Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 15 Feb 2014 08:36:23 +0800
Message-ID: <2359903.7ZUkPc7fVf@diderot>
In-Reply-To: <1392134707-2318-2-git-send-email-antonio@meshcoding.com>
References: <1392134707-2318-1-git-send-email-antonio@meshcoding.com>
 <1392134707-2318-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12896675.VlGBUmiNBM";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: free skb on TVLV
	parsing success
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart12896675.VlGBUmiNBM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 11 February 2014 17:05:07 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> When the TVLV parsing routine succeed the skb is left
> untouched thus leading to a memory leak.
> 
> Fix this by consuming the skb in case of success.
> 
> Introduced by 0b6aa0d43767889eeda43a132cf5e73df4e63bf2
> ("batman-adv: tvlv - basic infrastructure")
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  routing.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied in revision 9289542.

Thanks,
Marek

--nextPart12896675.VlGBUmiNBM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS/raHAAoJEFNVTo/uthzA0zsH/iE7ALrvNpJy9NgrYqU/KE/X
IbdwT6pMrGlF7Fe+9zvyQjR2Qq8N5Z14ZyK82711OnsOwPJA0YByHZdRVApzemI8
INaF0sjvXgUEWJvG2xO0RZ3dFsBQOE6RKR/bQX9kfSDO5lpQ8ETfPfTarQ+Jm2j4
yxZTJcp/bawfjIJQGMytEz5DdN52Ycu0hQHL0iyGyTt3JWhc6H4aNT0fLI/tv1X4
JfdZCUXRuVdArH1URG7OlKsw/vJJbIBBppNUY4FVGAtZFhfQYoXstJ/PNVyhzW6A
YyFhlgGyYYmmMu1JKkznHYAMrcEaB//KgNfkh/ah8uuQc22153arUipI/10TqnM=
=dkdr
-----END PGP SIGNATURE-----

--nextPart12896675.VlGBUmiNBM--

