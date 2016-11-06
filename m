Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 06 Nov 2016 09:10:17 +0100
Message-ID: <5940014.AJRkrQUGx3@sven-edge>
In-Reply-To: <5944fa3d-ab98-176d-aac2-a1412590c174@t-online.de>
References: <5944fa3d-ab98-176d-aac2-a1412590c174@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15088502.5JWSuPRLLp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] Alfred not working within network
	name space
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

--nextPart15088502.5JWSuPRLLp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 6. November 2016 08:29:27 CET Jean-Jacques Sarton wrote:
> scope of function corrected, has to be static
> 
> Signed-off-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
> ---
>  batadv_query.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

subject is wrong, commit message body is wrong, patch doesn't apply.

    Applying patch #16803 using 'git am'
    Description: [v2] Alfred not working within network name space
    Applying: Alfred not working within network name space
    error: patch failed: batadv_query.c:136
    error: batadv_query.c: patch does not apply
    Patch failed at 0001 Alfred not working within network name space
    The copy of the patch that failed is found in: .git/rebase-apply/patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".
    'git am' failed with exit status 128

I would guess that you wanted to squash it in the previous patch.

> 
> diff --git a/batadv_query.c b/batadv_query.c
> index dc8a042..69f5a48 100644
> --- a/batadv_query.c
> +++ b/batadv_query.c
> @@ -136,7 +136,7 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
>  	return 0;
>  }
> 
> -int batadv_interface_check_debugfs(const char *mesh_iface)
> +static int batadv_interface_check_debugfs(const char *mesh_iface)
>  {
>  	char full_path[MAX_PATH + 1];
>  	FILE *f;
> 


--nextPart15088502.5JWSuPRLLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYHuVpAAoJEF2HCgfBJntG/OMQALppJR+jQkUd3liqD0aeudvK
IkylIYLYBX+YzgWtzJFlgWemT+X3V4xaIhxbH46pXJlLd2AHdKTZRos08IykWxc+
01z+SER8y1Uvdx/EGtcAF12VbGCN10GXiaDxtZMUKoTV1SS7+cMyTFrO/HApY5Mr
YdwMlFjp3s2oFkipNwwpEEm735hL+MT4WcOpANXlGDGVoFpjv9YFS+fLT0nSe/fP
EPpm7HzXnRNV2NeuM9Qzg9LntwPdvk1qG9UrXQc5z6Q7fk9/hIqllVDH0bQgQOay
R0SlwXd8TLZMzYKc1alcPwU1ewDaTGl3Sr0zFOgCm4TsnZShMUPPY0QC97SM5L2u
QxwwTNuAcwTL1T4BeMB0XGN1qigVRWKCh85TxzVPj+f3RURsy4BKhHDr7wEf0B8B
gGqblqx766FhhKih7Gla2RDXW9B9IEeVuQ9tsuysc0hLnsLvDif2TFzMDbtkRFu5
bmuKhwCEr4V5GAr+nKDrtVIdyZhI6LTSB2Bg5IWDh8JsZTxPvP33EcR2uzDZbsS2
mstlLX0DhoFul4Ll2gjW1vfue33ewI33Y9rHs6BluhzPI7MvGVAazLFRAlZVO9YE
wPMAXrVp8hLg76S81rnPU2F0CBemAlwUsklv9UcFzdUJVKRZ7fRxnj6SyHCT39LF
WkMmuIdtvCmiqETF/x5a
=U/d7
-----END PGP SIGNATURE-----

--nextPart15088502.5JWSuPRLLp--

