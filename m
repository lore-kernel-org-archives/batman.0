Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 15 Feb 2014 09:27:59 +0800
Message-ID: <1821645.R5sTtn65FM@diderot>
In-Reply-To: <1392427040-1614-1-git-send-email-antonio@meshcoding.com>
References: <1392427040-1614-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart37637035.F12XZAyKWJ";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: avoid double free when
	orig_node initialization fails
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart37637035.F12XZAyKWJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 15 February 2014 02:17:20 Antonio Quartulli wrote:
> In the failure path of the orig_node initialization routine
> the orig_node->bat_iv.bcast_own field is free'd twice: first
> in batadv_iv_ogm_orig_get() and then later in
> batadv_orig_node_free_rcu().
> 
> Fix it by removing the kfree in batadv_iv_ogm_orig_get().
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
> 
> Change form v1:
> - remove kfree from batadv_iv_ogm_orig_get() instead of setting
>   orig_node->bat_iv.bcast_own to NULL
> 
> 
>  bat_iv_ogm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied in revision d4acda1.

Thanks,
Marek

--nextPart37637035.F12XZAyKWJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS/sKiAAoJEFNVTo/uthzANLkH/1Dp4TJUP1lMaZ+CrhQNj/vC
M1vODNMEb+m+OXpKWV0dazZNrpyx1P/LyqpkgFGAfXZbnseauZEIGJHN0aN7a6Ji
KBgl5HnWg/jJi0IWvDfEkzIf5gk8D3RZjQ1mFIAUD6afACIbbNUW3BAq7ZvG6pYe
g2pIM/jRNI5JcF772Xm8RrMoRJDKB+vqv/QmimS5SrNwUTYueq0mqH4KD0w3+TDR
xzD6kJ+dLB01CPBHnblkY7KkNOXTYH1YH6hLXywbqKK3LGnX1Fa6gO4eY5QrFbXm
qSIy5qQStthLT4d/ieuBbtAliwWfFaOLT98xjUOPavpVN8BfnNLI99qBuSE+6G8=
=fsSp
-----END PGP SIGNATURE-----

--nextPart37637035.F12XZAyKWJ--

