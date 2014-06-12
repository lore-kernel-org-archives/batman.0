Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 Jun 2014 17:28:14 +0800
Message-ID: <3125454.JTjkQlAfcy@diderot>
In-Reply-To: <1400939778-12886-1-git-send-email-sven@narfation.org>
References: <1400939778-12886-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart25975132.0EfCNCiVNT";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batctl: Import hash table version
	from alfred
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


--nextPart25975132.0EfCNCiVNT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 24 May 2014 15:56:16 Sven Eckelmann wrote:
> All new functionality, cleanup and similar things to the hash implementation
> were done in alfred. So import the newest version to keep it in sync.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  hash.c | 88
> +++++++++++++++++++++++++++++++++++++++++------------------------- hash.h |
> 69 ++++++++++++++++++++++++++++++---------------------
>  2 files changed, 96 insertions(+), 61 deletions(-)

Applied in revision 63c0932.

Thanks,
Marek

--nextPart25975132.0EfCNCiVNT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTmXKyAAoJEFNVTo/uthzAoDkIAI82DOP1o5JxzyjspojLF8H+
HoZQVywou/Gyp3+ljAckNABbwLRRdmetO+rb15JyKWgGpmBmrIQhADMeh//okRqT
LyShiK1kRHVEwxJ3gdxSrclUcMneCo5gN8J3IPJmN0miQO8P0KiOI1js6CneWlVm
U8mXB06FcmbSpj5eE9+/o1m7KLU68QKmLqNWhwU86VbKGtJRwy/h2CSqdsa0s9qr
Zi+Mdw6GtYBJLt0gj6lR5gNUoAww3atAWtHFN35lrqg34i66aEbj+HiBVv+r0ofn
Ck2FKUau7/1EjClFTiBRV9Or4pO1Gyf/Y6HpuD8LWjua89ADuhsCITn1yxhTXeU=
=oe9h
-----END PGP SIGNATURE-----

--nextPart25975132.0EfCNCiVNT--

