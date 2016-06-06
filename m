Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jun 2016 00:10:51 +0800
Message-ID: <1608583.49ByqXbT05@voltaire>
In-Reply-To: <20160521121756.27450-1-a@unstable.cc>
References: <20160521121756.27450-1-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2758144.eKJSjKTS8u";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: remove useless forward
	declarations
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2758144.eKJSjKTS8u
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, May 21, 2016 20:17:55 Antonio Quartulli wrote:
> If main.h is included, the batman-adv private forward declarations are
> not needed anymore. Remove them.
> 
> Cc: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/gateway_client.h | 1 -
>  net/batman-adv/icmp_socket.h    | 2 --
>  2 files changed, 3 deletions(-)

Applied in revision 563823d.

Thanks,
Marek

--nextPart2758144.eKJSjKTS8u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXVaCLAAoJEFNVTo/uthzAF0MH/RZXRGezsDTbVpH/s82qDTC1
MIKEaneIGTLmeXLNw8PvBnQZXRtNpVDHhq4dGLsq4fDLOQj5Iapziu+G2I3Y8J8x
IHDGYZYPztZ4kNzDdccgWhuoLJ2H8oUm8Timg7vWt8EuUBsEtyMXQnPX9Ko8LnQx
GobQ4UpkTfiR8a5ZLWa/eEiUt8tIXXjyEyPWMBfkaWKEllbCBD9pA1blCBNdC4sh
iyzpMgJt4890/U+VYCdZ7TC09Xk7htyoW5zS8Mqc6i8yX6rdcksf+XahQfkjgahP
rZ5R1LLq9LnvYE8e4qzXvQ/e425DM3uDvqj99bNcs5Hsy7dhdlwt67FwdkAr2S8=
=oWoj
-----END PGP SIGNATURE-----

--nextPart2758144.eKJSjKTS8u--

