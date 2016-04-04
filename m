Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 04 Apr 2016 17:47:45 +0200
Message-ID: <1746063.26TRQ81zca@prime>
In-Reply-To: <1459531356-8361-1-git-send-email-sven@narfation.org>
References: <1459531356-8361-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3545163.ZHWlSRvg2z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Check for invalid mac in
	EUI64 address
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

--nextPart3545163.ZHWlSRvg2z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Friday 01 April 2016 19:22:35 Sven Eckelmann wrote:
> The ipv6_to_mac function currently only checks if the EUI64 markers are
> present but not if the mac address is valid for a host. This has to be done
> to avoid invalid data in the alfred data storage.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  alfred.h       |  2 ++
>  batadv_query.c |  4 ++++
>  util.c         | 15 +++++++++++++++
>  3 files changed, 21 insertions(+)

Applied in revision 46b8926.

Thanks!
     Simon
--nextPart3545163.ZHWlSRvg2z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXAoyhAAoJEKEr45hCkp6hySIP/A1NMZx/ptQTJtHRtVXiAJiW
s5gibP/gF+aGW794+SYydaJFKQSVdoc6Y6HvyfHFckdfiMYbQ4/RV9FzZyVM/quD
YMb4+3VI7RaE1f/ymBq9cptSU7KsZa2Zg+YgG61leMuo8Anfg6DQF/6ZFcR60B69
0BA3qjU3/VvBwJMwh9loTUzLJTQPRycOQlhPkt+luBfSv+91XZ7+DAd7FjUVIyhQ
BxFk2lzr6VGqO71LGsvdUv7yxELQ8rPS3k1hUJgaMwFK5XB+MpmPVqo3YhdloVGA
bEeSdSQB3XwPNgjYHXSVaEnZeGNb/FD8X2vfAFhtZUfKhY4QpAkT1CFxVPd+BkfQ
q3f0L869Ppz/uzYSJO6BOmGjtvntr4rgGi/GENKzhs/bVSlDrtNGtx0bgVwPg+ZV
l3yE1TRNYynO0UKE3JcHGY7S4wwhgrpUgoCeGQQJ1ZH57pjrzNYDwh5UB5r0tXWK
N958kV+xSkR/R2K+38B4lLd5iOoNIXVZgg1sbB+26nGcpGpgaFZaGfI14VCJ0Yv/
UnYaot2pe/oyGt/WcG1w75eLkB5TJ1UUtp8/S3+UwYpJSq0NL5fKnDdywXNFYo/I
F9szGUTMzjhZHl1aH3dSN3uZgwpCIHSKOYF5zvpMtrfjkCJglFOwq+IjyGZh3Bi3
vl2NDjI/P2jV/HxNn8W1
=gwt+
-----END PGP SIGNATURE-----

--nextPart3545163.ZHWlSRvg2z--

