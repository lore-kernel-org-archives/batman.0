Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net] batadv: fix for leaked TVLV handler.
Date: Tue, 21 May 2019 22:48:32 +0200
Message-ID: <2234850.c0QxkmldC6@sven-edge>
In-Reply-To: <20190521195857.14639-1-jeremy@azazel.net>
References: <00000000000017d64c058965f966@google.com>
 <20190521195857.14639-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4379812.Jl03XZO3XG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: Jeremy Sowden <jeremy@azazel.net>, netdev@vger.kernel.org, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, syzbot+d454a826e670502484b8@syzkaller.appspotmail.com

--nextPart4379812.Jl03XZO3XG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 21 May 2019 21:58:57 CEST Jeremy Sowden wrote:
> A handler for BATADV_TVLV_ROAM was being registered when the
> translation-table was initialized, but not unregistered when the
> translation-table was freed.  Unregister it.
> 
> Reported-by: syzbot+d454a826e670502484b8@syzkaller.appspotmail.com
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>

Fixes: 122edaa05940 ("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast packets")

@Marek, @Antonio, please check whether this looks good to you.

Kind regards,
	Sven
--nextPart4379812.Jl03XZO3XG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzkZCAACgkQXYcKB8Em
e0YN9Q//T6t3yD6cU1SOuMWlrF1Aj0/L4eC2I5c2jxK0R07b4lSuJPCF6xxduI5W
g0Plqr9g5N7CzYW7CADCc5oMJq2ksUwi77rvTxpJXnS2CJXW0SwnNBrHrVCbhbFZ
akOOp1bXMzUNH9Uag4iRw0CwL6dO6hu9cOo6a/gYTeQvVe/Dkx42+pFSZ4/Y9Hph
3Qvq2wXcOQWxj3IkeHPxOwUdBjZwUPBL60aH41pZEUX6L72x4YnNkGbfWCsFoKOX
8Tgm+RzQeR4+vFqyT775L9BeBV2Mvdu2ey5dyP0PAXlc+rIMAYmmfzJY109MaF9b
f3qd0xnUYBJE9LYPZbuEWlvlgmvNjkfzVa2cL/zXNc03r3tYUIUB+SAr2oGtZQKc
YKfFUf4IVj/ew6x2UnhRelp/uAraIUEfShyM/K5a25bV9QLNqGWMy+BEBAyfXut+
9GyijuZ/+b3S27pREsGC+iAVZK1zrtLPnUOnJIWTGvN7br3DklNbbsQgHkxD9//q
XYKPAN31ksk7TKBl+ul5v5JYjZAeukKELq4vef/uDYEfeRAJzsARAytO5qDCHPTE
3x3cGkOr7apLMuDgfVG/2M5DLX4rB5KuKKDs0C4GjX4xtmxnzhatk8bHUQ3yvOYP
SA6a4fbC/nu7P+9feH0S1olQkhptoyAwL3WS0E3aAYn/QhjTFVQ=
=sJEP
-----END PGP SIGNATURE-----

--nextPart4379812.Jl03XZO3XG--



