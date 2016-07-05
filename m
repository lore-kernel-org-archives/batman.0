Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 17:03:37 +0800
Message-ID: <1757105.h26jqzYBs4@voltaire>
In-Reply-To: <1466797412-1312-1-git-send-email-sven@narfation.org>
References: <1466797412-1312-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1817944.dW7xQTxpAC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Avoid tt_req_node list
	put for unhashed entry
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

--nextPart1817944.dW7xQTxpAC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, June 24, 2016 21:43:32 Sven Eckelmann wrote:
> It can happen that a tt_req_node list entry was already removed from
> tt.req_list when batadv_send_tt_request reaches the end of the function.
> The reference counter was already reduced by 1 for the list entry and thus
> the reference counter is not allowed to be reduced again. Otherwise, the
> entry is freed too early and the next batadv_tt_req_node_put in this
> function will operate on freed memory.
> 
> Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/translation-table.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied in revision 03ecc9f.

Thanks,
Marek

--nextPart1817944.dW7xQTxpAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe3fpAAoJEFNVTo/uthzAr2YH/jbZGOxoJlQHbxMzuG/Di/Jb
+oCH5ou1s0H0pPG/8PXWP6B0o9UUtS+V875fPJ78fwUMe/DmNg4RS0fawM+qziu/
c54qNHUaeNaGPbg8nlV2F4rkaQrf5kjnYGSU52TZ3IfbS+cil1TNi3bQ9DAC7MO9
dhVeiw0n4g4NRulCfL3IjOytB+je9pmyhOX0250DZo4bREboga2n55aAirY//RnP
ThnMB0AzHA3tu59tDOAWlMVCHJMLBINFkML44G2NFhgs1LJQ7fRZ71t7KZF8QSSU
mR1co+ev3LJgVBy9lIkHyK39Bw52New8TTKIsIfiGQo2Hye2WdkqevwKCPHhhpo=
=B5rH
-----END PGP SIGNATURE-----

--nextPart1817944.dW7xQTxpAC--

