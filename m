Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2016 14:39:49 +0200
Message-ID: <6311894.ZRre2EmoLd@sven-edge>
In-Reply-To: <20160521121614.23779-1-a@unstable.cc>
References: <20160521121614.23779-1-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5174823.Xal9XnQjQb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: B.A.T.M.A.N. V - implement
	hard-iface init function
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

--nextPart5174823.Xal9XnQjQb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 21 May 2016 20:16:14 Antonio Quartulli wrote:
> Some fields in the hard-interface data structure are specific to the
> B.A.T.M.A.N. V protocol and have to be initialized only when such
> protocol is compiled in.
> Instead of having a #ifdef block in the middle of the hard-interface.c
> code it is better to have an algorithm private function that hides the
> precompiler logic in its own header file (like other functions).
> 
> Fixes: ffd2f27908e5 ("batman-adv: Only init ELP tweaking options when
> BATMAN_V is enabled") Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
> 
> Changes from v1:
> - move bat_algo.h include line to the right location
> 
> Changes from v2:
> - rebased on top of newest master to fix compile error.
> 
> 
>  net/batman-adv/bat_v.c          | 14 ++++++++++++++
>  net/batman-adv/bat_v.h          |  5 +++++
>  net/batman-adv/hard-interface.c | 10 ++--------
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
> index e4a91cd..81157a3 100644
> --- a/net/batman-adv/bat_v.c
> +++ b/net/batman-adv/bat_v.c
> @@ -334,6 +334,20 @@ static struct batadv_algo_ops batadv_batman_v
> __read_mostly = { };
> 
>  /**
> + * batadv_v_hardif_init - initialize the algorithm specific fields in the
> + *  hard-interface object
> + * @hard_iface: the hard-interface to initialize
> + */
> +void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
> +{
> +	/* enable link throughput auto-detection by setting the throughput
> +	 * override to zero
> +	 */
> +	atomic_set(&hard_iface->bat_v.throughput_override, 0);
> +	atomic_set(&hard_iface->bat_v.elp_interval, 500);
> +}
> +
> +/**
>   * batadv_v_mesh_init - initialize the B.A.T.M.A.N. V private resources for
> a *  mesh
>   * @bat_priv: the object representing the mesh interface to initialise

This seems to be the first use of atomic functions in this file. Can you 
please add "#include <linux/atomic.h>" to have the atomic_set functions 
defined.

And yes, it is a lot nicer than my quick fix :)

Thanks,
	Sven
--nextPart5174823.Xal9XnQjQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXQFcVAAoJEF2HCgfBJntGPvQQAKFtAqvRbeHC02+jI0cuv/OC
GbF3EXuPMB+U/vBP29wjhq0RjjyU/l6TsHsTBq1LBxaxHfrmpCRKLqBlwpEkFtJr
R4hUhtvIDJIOOKGxUosFk7W6mnDKp3F4c4SZzOXrO3+VvtOkq3R74Rith/GfzM1K
xFtrnEQtpgUq96Ol5ut6fk/70b6x6GOzdrznb5+3lcntCwrnTzNdvVErAC6PY/ry
crjXyWwlkaLquG6K2nSo8opW+tYXVt2WsC0EPrPH9GrlBLSdKBCaWpt6b82/pHGC
rdAzlk36Lgk9aEFt13wyoJlmFre/3WXk53pRPGy4+MUVt0fmJX3W6l4mtUCU4QtJ
3WWX78UciZNylsXIf15QMHXSOpg4J95kHy8KUaD8gestPeNv4jI1M6hbKT1W0bV9
I+q2jAJ8ZFjDk8fcqnf9/OF53ixj2T5+32HkTuWOWB1sxFtoKNlb2y6YEif5etfS
o5wKaNti5cNEAjiMDUJxunmuUohhKvRABx4+08uwbaDd4usoLpVvdNgjR+uHylyE
rfKfRVy0bSSNf4l+MtRxSMmBP7UpKtJYkl01IQtCSJddGkerDhUmZZusiiWsE2rI
FsEKvA8GjRT7aZn2EFAYPtv8Cy+cuH3lBxP584Xj+oMQrLw2RxWD1/44tSdU+tJG
B7id9gmTRhBsh/ePGctd
=X9B2
-----END PGP SIGNATURE-----

--nextPart5174823.Xal9XnQjQb--

