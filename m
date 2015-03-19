Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 19 Mar 2015 18:21:15 +0100
Message-ID: <18777523.9ZBWag5W97@prime>
In-Reply-To: <1426578449-2780-1-git-send-email-sven@narfation.org>
References: <1426578449-2780-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8703940.4Aubrf28cW";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Remove manual \0 terminator
	after snprintf
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


--nextPart8703940.4Aubrf28cW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 17 March 2015 08:47:29 Sven Eckelmann wrote:
> snprintf already guarantees \0 terminated strings for size arguments is > 0.
> 
> Reported-by: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision f7914a8.

Thanks!
    Simon

--nextPart8703940.4Aubrf28cW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlULBY8ACgkQrzg/fFk7axZxdACdHXeI6ipA+oEMG8naIBiTYor7
mYAAn0ShRILgynS6Sn0i6sBy6QD8fU0f
=eTfW
-----END PGP SIGNATURE-----

--nextPart8703940.4Aubrf28cW--

