Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 06 May 2016 11:31:11 +0200
Message-ID: <1967690.8xsP0WyeJ3@sven-edge>
In-Reply-To: <1462526567-10019-1-git-send-email-sven@narfation.org>
References: <1462526567-10019-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1889059.lefUlxIixQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid nullptr derefence in
	batadv_v_neigh_is_sob
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

--nextPart1889059.lefUlxIixQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 May 2016 11:22:47 Sven Eckelmann wrote:
> batadv_neigh_ifinfo_get can return NULL when it cannot find (even when only
> temporarily) anymore the neigh_ifinfo in the list neigh->ifinfo_list. This
> has to be checked to avoid kernel Oopses when the ifinfo is dereferenced.
> 
> This a situation which isn't expected but is already handled by functions
> like batadv_v_neigh_cmp. The same kind of warning is therefore used before
> the function returns without dereferencing the pointers.
> 
> Fixes: b05bbab5e1fc ("batman-adv: B.A.T.M.A.N. V - implement neighbor
> comparison API calls") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

Looks like the reference counting is also completely broken in these functions 
:(

Kind regards,
	Sven
--nextPart1889059.lefUlxIixQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLGRfAAoJEF2HCgfBJntGLJ4P/1ufUDMHtz/arP5dVCfqZfxh
QCSyEMFaZQ736LVzxaNJDyOj10zP8NwyS84aQ8uw47xdNDxJ3+gSo9bhjJd6oOmm
6jkR7zN+zK4lhTdEXBphDNu/VdXERF5F6f/Dib2uddBgiK00+9A0ZuVkCpdTMKMz
uxIKmv7LHt3crTU88/Ru0IeB2L5J0PSMz8ZkGAiuaCQexa9i3SpKLl7m3f4A+gHv
F9XAdRf01N2zTEg7jjVGvCmLYshgdk/CfiPB2r9EGKxWWcts70ktMeOyGCnm0lGb
PYvVqDqTLvMkHEZ+WV16F+IFe9saoHezssa0hhNXSkJuJXBvWgfjY5WJwuWIEKw0
lPR9XnqVaUu0tiIRpGGwAPE7YEhDZnbKuUFAsrPMcRaq3S66cnXQDpwA12X4VSMg
DJ3PxZker5HMZtVKYp7xCJDzylgoP0+1lrhrUHIVM3nb1aeH8mr/xWffIwXG9NDA
dH5yMG0T8fSDhtthrTy3cfYQVpCaiDHtdVmP6irQGtqCO0Cz4XFf603zKUMOrCkW
tUxNC8ZRzb0/RDQGsLIpYMYnL9QpiCCaJJDJJTLgCpwYNasFJpnoF1mg9NE5MkVR
B2ASRBeT9tLTzfnY7HsLiakuENoKLq/pXBn+CymiO7qv2DzTfBfcNP17NbMnRey8
Z39NdGLquM/Fevt9UjHz
=9PkA
-----END PGP SIGNATURE-----

--nextPart1889059.lefUlxIixQ--

