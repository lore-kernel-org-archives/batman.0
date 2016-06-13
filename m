Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2016 12:47:55 +0200
Message-ID: <2887982.6nLXfEyYzY@bentobox>
In-Reply-To: <20160612041426.26339-5-a@unstable.cc>
References: <20160612041426.26339-1-a@unstable.cc>
 <20160612041426.26339-5-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6009958.fGsuiqaA4B";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 4/4] batman-adv: disable sysfs knobs
	when GW-mode is not implemented
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

--nextPart6009958.fGsuiqaA4B
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 12 June 2016 12:14:26 Antonio Quartulli wrote:
> Now that the GW-mode code is algorithm specific, batman-adv expects the
> routing algorithm to implement some APIs to make it work.
> 
> However, such APIs are not mandatory, therefore we might have algorithms
> not providing them. In this case all the sysfs knobs related to GW-mode
> should be deactivated to make sure that settings injected by the user
> for this feature are rejected.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart6009958.fGsuiqaA4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXXo9bAAoJEF2HCgfBJntGJIoP/1tv140YbnwOBlAqgwDvSsMB
+8iQJdFbFy7MgrBvpHeLMZFoNBrqntqFuE0jOGz1ZJHWDmAPeRaFSZlz3KDwLikv
BOTTMnfSkwwL6Of6BtOToDpCqts/XPuHEIjWTEzzeJ83askHt2HsDrQxz35GJQOm
wNmeF3yrfyIlqgidW56JL3vmZ4SArZjv/r29IkXdHzeaLLpMZIkovI866SQEuvAn
rT6iOu+dZWSYK8ua2Yqtd4unpQGqq9ZmQz19QTrvm3Qc1FPsYtI5HkOU7SRlRbgv
C17g88GQbYb+ua0XVrJihatOGy1lmSbiITd1IvmJtcpU2AB3VCKhYupN4VvHrxkk
ws1AONAZHzqHi9STdncZ77jDDhVu/R+575ZfMtZxZisp8X2JbzZ041QnbpIglZRz
rsNhgFJrlwif1Fl5bhBuxaunlv1aAeiYcvWxq94ky7090MDX06MAH4dqf6yNmg3r
1aXqrG8ZUgY214wa7qFhM2bnBtVuraVtZXeLdHmY1K5LsL3CFlghEf4f6QRb/yOh
8Am1JF8x0mOalqYJO6Tli1HnQYwRoon+3RWnkzsd5mwu5Fzth3iBo9x9otdmsJvT
WV316wVRC017z2KU+x8gQkUC8rGbugYtqra+mMxlqrkCId8miyHDEdVa4+Xtq7bz
Nua13dvNz39EgKuGciiM
=eQcz
-----END PGP SIGNATURE-----

--nextPart6009958.fGsuiqaA4B--

