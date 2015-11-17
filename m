Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 Nov 2015 16:43:09 +0800
Message-ID: <5838912.NLG8CpsEQj@voltaire>
In-Reply-To: <1446568985-4222-1-git-send-email-sven@open-mesh.com>
References: <1446568985-4222-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7661263.yuiXeQvCKM";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix lockdep annotation of
	batadv_tlv_container_remove
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
Cc: Sven Eckelmann <sven@open-mesh.com>

--nextPart7661263.yuiXeQvCKM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, November 03, 2015 17:43:05 Sven Eckelmann wrote:
> The function handles tlv containers and not tlv handlers. Thus the
> lockdep_assert_held has to check for the container_list lock.
> 
> Fixes: 5b95c427d187 ("batman-adv: Annotate deleting functions with external
> lock via lockdep") Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
> ---
>  net/batman-adv/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 41a559a.

Thanks,
Marek

--nextPart7661263.yuiXeQvCKM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWSuidAAoJEFNVTo/uthzAO8AIAMGqQcomrpEvft5DFJA4QvFz
x7w6i4hBQ+LzjKZadF+awTnMFhEXIa4cHwxOHrlx/mbezm+bUFuj8YcLKod+0sWj
jC1HAKHfuWxCM7W4lRcxU7tPsb9Gwm0SIVSNKKEty4xA4G0TyrKMjIsRTkPWRjG4
03QiN/ZqVl5jDLql8FyWkpcexli7YM8iTCIobGRs+GvsHCiAvrawd9pBxqmr6Ct9
8chSqc9WK8XVkMiNuOd6lRuP2equCqA1tJgLH478RPZHszzByT2VQSHdbwLPFJpl
EWDXOgzia1lxOvJzOiXfROdonXhxFfUsP9IJAXB6bUX9ItOLwTTgRe+H3ZSBAhA=
=8IGt
-----END PGP SIGNATURE-----

--nextPart7661263.yuiXeQvCKM--

