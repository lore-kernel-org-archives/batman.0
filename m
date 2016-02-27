Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Feb 2016 07:33:01 +0800
Message-ID: <1694936.QPXWkBB6xO@voltaire>
In-Reply-To: <1456178194-29307-1-git-send-email-sven@narfation.org>
References: <1456178194-29307-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2270069.GH5PJyL6Xg";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix unexpected free of
	bcast_own on add_if error
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

--nextPart2270069.GH5PJyL6Xg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 22, 2016 22:56:33 Sven Eckelmann wrote:
> The function batadv_iv_ogm_orig_add_if allocates new buffers for bcast_own
> and bcast_own_sum. It is expected that these buffers are unchanged in case
> either bcast_own or bcast_own_sum couldn't be resized.
> 
> But the error handling of this function frees the already resized buffer
> for bcast_own when the allocation of the new bcast_own_sum buffer failed.
> This will lead to an invalid memory access when some code will try to
> access bcast_own.
> 
> Instead the resized new bcast_own buffer has to be kept. This will not lead
> to problems because the size of the buffer was only increased and therefore
> no user of the buffer will try to access bytes outside of the new buffer.
> 
> Fixes: fdafa7d29ace ("batman-adv: provide orig_node routing API")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied in revision 32bcb3f.

Thanks,
Marek

--nextPart2270069.GH5PJyL6Xg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW0jItAAoJEFNVTo/uthzA7FUIALKpTYyGNySYIK8FC+sBbe9i
59mSYrafDZCmFLMv1gCyVofTHW+IWHAlwp57HR6FwluxIjXDh13a1xCnGBp9DqPQ
PjNipTuZfysFWlF5j0K0r8zBohFTI0GO0A6i3UFe8ag/0tiW80L+fUt8mSS8dFnV
j81ht2x/cOpxd0oRrLdzXCUOb+53OR1bKpw9I4+upfM/+U/Rxkay5xa3jHlvlFVr
rNTW72fo0297gFmPY8E/v0miI7DEUrSzeKB4zfyw+nUfBA27hlJ4L6+nwmreYS3w
IvUuUCBiaSDOxn6jNJE4MfFdaT4ob4fqbr/L0z+lDc68rweav7jI18YMpJ0rC40=
=taWL
-----END PGP SIGNATURE-----

--nextPart2270069.GH5PJyL6Xg--

