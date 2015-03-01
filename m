Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 01 Mar 2015 17:17:50 +0800
Message-ID: <4026910.3ENWfGA5H1@voltaire>
In-Reply-To: <1425199578-6392-1-git-send-email-sven@narfation.org>
References: <1425199578-6392-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1595103.sglvo1lIpt";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Use common Jenkins Hash
	implementation
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart1595103.sglvo1lIpt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 01, 2015 09:46:18 Sven Eckelmann wrote:
> An unoptimized version of the Jenkins one-at-a-time hash function is used
> and partially copied all over the code wherever an hashtable is used.
> Instead the optimized version shared between the whole kernel should be
> used to reduce code duplication and use better optimized code.
> 
> Only the DAT code must use the old implementation because it is used as
> distributed hash function which has to be common for all nodes.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3: rebased on top of current master
> 
>  bridge_loop_avoidance.c | 16 ++++------------
>  distributed-arp-table.c | 17 +++++++++++++++--
>  hash.h                  | 22 ----------------------
>  main.h                  |  1 +
>  network-coding.c        | 10 ++--------
>  originator.h            | 13 +------------
>  translation-table.c     |  8 ++------
>  7 files changed, 25 insertions(+), 62 deletions(-)

Applied in revision 3606e0a.

Thanks,
Marek

--nextPart1595103.sglvo1lIpt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU8tlGAAoJEFNVTo/uthzACzEH/3MK09DXF+1h7YJhq79kKlXp
jMh4DQRUSRZ/hj6RGNUDlRneo+HR2iOx5JJXe09Pwz6CBZfF47pTrLd+/VWLcHxD
YKFaelZ48LM75tUbaTtST3Ae8G4TrbdkMnVQ9+e38lvHFBl0OJBt+LaEYkpTJHTc
MP3eYXhCUqyPsGfB3CtgowmMa/rPB4uB3Z8Kd7ETpDJMOMdkMt/UB8AArGJza00a
ef2PNVW5XbHuN1eqOboJk4nZXKjEdNR8S8aErLIr381FzaMpnLKjiJR1Ab6ot0hl
vQtWOPo91UK5D8EmVGG6JKqQGgLlEXegbH4SBFdnerBc2tiFhWjNxEeOg2+EIMY=
=01HA
-----END PGP SIGNATURE-----

--nextPart1595103.sglvo1lIpt--

