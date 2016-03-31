Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 31 Mar 2016 11:07:22 +0200
Message-ID: <2334006.YMjFVZQkQ0@bentobox>
In-Reply-To: <56FCE2A0.7000200@universe-factory.net>
References: <1459340372-6971-1-git-send-email-sven@narfation.org>
 <1459340372-6971-2-git-send-email-sven@narfation.org>
 <56FCE2A0.7000200@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8155829.ISUT8DGDSY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC 2/2] batman-adv: Don't re-broadcast packets
	on non-wifi devices
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

--nextPart8155829.ISUT8DGDSY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 31 March 2016 10:41:04 Matthias Schiffer wrote:
[...]
> I don't think completely disabling the rebroadcast here without a way to
> enable it again is a viable option.
> 
> At least when using batman-adv over VPN tunnels, making batman-adv take
> care of establishing transitive connectivity may make sense, as batman-adv
> does this very well and without much configuration. This is actually the
> recommended setup for non-full-mesh setups using the VPN tool fastd (which
> is developed by me.)

Thanks for the feedback. There was also a small questionnaire answered by
Adrian Reyer about fastd:
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014803.html

Kind regards,
	Sven

--nextPart8155829.ISUT8DGDSY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW/OjKAAoJEF2HCgfBJntGgY8P/jPjJAx9qILTaAodBX+jT3PW
KtN7ovSWz9MF4YS/Jl/YzFNEQ7kuQ3KqswA4nNgNa9r9uEUimONwOwge9CoEELUZ
nr53ZOIWRDZsq3444yvrZtEZr5KwIrPPJ0bZxrzEy6A58NW7TkdlRI/Y12LPoQQq
XN6AxsZW8pnb36tfsbtWB+MJ2MghC0B9UQrnbdXjq+6PW3ul2GiZLIs2HecHNB8f
YfPW2obgcPjtvbvHlYDpZiIfE84wWSQM3nNliUASxSdeRbNgk7RtnxNuxLg69Lot
VXsWnKET1shyd/4lC+sLZxavkqXnDwKdON/pcWPfduaGiEX+XXZkkMC9verY1jnE
JqiZNGwJhAxkcf2UluoY5Lcnw6pN/YeYVFjubxGlM4/USEekfF6ih0IM9mSeNqnW
aHF2hr8lzCNNQZBznshNixSgcWSAgsiH+zjl+uU5yxvidQRpnsb1ZEVHpwHidN4k
2UTyXaje/VBT4rOagaZ2y4z4JPfS2SKoa3Lyon4OJfORYwFDa69y3DnooxMkIaY2
V+phk2Greds3mt5bLysHGkRFZxnUAC0i+/pnvNpPEaNPJ8DMMH9H3hMCNYiiwhbg
p23DCrTM54tmMWmy3AeDplHRmSEtr/88fzf8z2KZpMj2iMG/YvV1ivXZMs5rvgke
7XdBenh+N5bOKMV2EHhD
=4Do7
-----END PGP SIGNATURE-----

--nextPart8155829.ISUT8DGDSY--

