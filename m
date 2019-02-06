Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Feb 2019 19:50:17 +0100
Message-ID: <20661651.ZxqjWeeW99@sven-edge>
In-Reply-To: <d9eb35b2594d9cfedd8525dc32a18b40c60451b0.camel@perches.com>
References: <20190116102651.489113812@linutronix.de>
 <3904432.cpar7GfAiZ@sven-edge>
 <d9eb35b2594d9cfedd8525dc32a18b40c60451b0.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4519362.vEzlPQ4pp3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [patch 2/2] scripts/spdxcheck.py: Handle special
 quotation mark comments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Joe Perches <joe@perches.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, b.a.t.m.a.n@lists.open-mesh.org

--nextPart4519362.vEzlPQ4pp3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 20 January 2019 19.39.55 CET Joe Perches wrote:
> Well, maybe checkpatch should remove the comment trailer.
> ---
> Miscellanea:

In case you are waiting for me (haven't seen it popping up in linux-next): 
yes, this patch solves the problem for me.

Tested-by: Sven Eckelmann <sven@narfation.org>

Thanks,
	Sven

--nextPart4519362.vEzlPQ4pp3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxbLGkACgkQXYcKB8Em
e0Z7bxAA1cAsljRChsAqqXoGxC0jGvcS3o1NJmwBWwkbMn1TnSx7JxmxdFm35xmQ
POC4mgN4O/T1Y4hzKawm0f74jsTTIsU8k6JaOqVEIMgzrtFkavvymkWzfXKgSA0k
xpmNkov6VqOuy4XwqHvBxNwO3qt7B0bUknbVzPxpSVr6eLPkPaoGN7l1hbUK/8dK
gZ2s4OCuqdVO/XDm91KblMwOmcm0M6EPafRBAV+7AKfMumIzQCmUoBn2gKuQt4JG
W1Ho7wd4Js1cAMj0WUFHNb8Lrx7fOS97R0xjsM02Tb9SN8yqQPOCblOncLcpnUc5
cJy8Z2e/0mQYvVROGQEkOXGFvj0AbYp2fcrNPmvm2NRFvpCDo/NpZ4vAIZ7u4/0x
vPgIgUWG+N3mVTqPwsmQlXTgznr754iId+UPITu4Iy6yRp9E+chG24+zEg04Q8tG
OsDS4guVvgr4tVjnG/Oin5E6ax/j2t6OnlNzwG8WVrs5VB0WOfnz2tqTaeyTMuoc
/1V+6NZ4HIaLjXmVEOuOJl7kyw7Q5KWpQcutfQeHOQSxZjF936SxfVtHEmSaHvaR
fGmOifCr44KVAQyfM4NxIgELarMydomgUr6jg96yitkpjL8SqVqmGQYjl8F2GFiF
5Kiqk/9CYvD7UQf9hU74GD05fRVUqIleowDeqFA8D2Fe/BrN6hA=
=wqKT
-----END PGP SIGNATURE-----

--nextPart4519362.vEzlPQ4pp3--



