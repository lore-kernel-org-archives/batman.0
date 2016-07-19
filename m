Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:45:14 +0800
Message-ID: <4709544.nVJXH5iMET@voltaire>
In-Reply-To: <1468597173-25378-17-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-17-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1733688.MdsrMm9H0U";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 17/18] batman-adv: Place kref_get for
	tvlv_container near use
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

--nextPart1733688.MdsrMm9H0U
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:32 Sven Eckelmann wrote:
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
>  net/batman-adv/tvlv.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied in revision aebb6e7.

Thanks,
Marek

--nextPart1733688.MdsrMm9H0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjeiaAAoJEFNVTo/uthzA45kIAIgX1/nbZRYXQDjluU7CTbC3
wS6mj6fB3GhYnKYgre69QwXlx2Ju34gWclq0jb8ftE1/613OY7vgwiUsS6n7mvWd
iyS1HhWSWYs1w3yz9Chd2UaejVa3m82bizORggjnFHCUBTkBKMmvsdsJ2isPQPt0
l3CNery57bQdi1npGvVHLUi0OJL879VqY/KiXEpC4Ao1SL+zFW+mlPBl0bsv1geh
yLCdpvbVBzOeUS/vgEIMCJ4NseSZUIYB1h8WswtGYDzeVAYNO7HZ3WyiwGAZljTy
9QIcFpJ8xwa+7etVWyWYeehbK/Bxg8QpGax88I668WU53r4VOikJOWLkTDvp1QI=
=58kW
-----END PGP SIGNATURE-----

--nextPart1733688.MdsrMm9H0U--

