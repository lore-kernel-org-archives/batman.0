Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Apr 2015 11:32:23 +0800
Message-ID: <10750000.oymJvT72oN@voltaire>
In-Reply-To: <1429288461-26260-1-git-send-email-sven@narfation.org>
References: <13114664.Eg4ODy7KEo@bentobox>
 <1429288461-26260-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3185618.A8mY72z7NR";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 1/6] batman-adv: ignore
	netdev_set_master() calls on kernels older than 2.6.39
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


--nextPart3185618.A8mY72z7NR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 17, 2015 18:34:16 Sven Eckelmann wrote:
> From: Marek Lindner <mareklindner@neomailbox.ch>
> 
> batman-adv calls netdev_master_upper_dev_link() which is replaced with with
> netdev_set_master() for kernels older than 3.9 via compat.h.
> Prior to 2.6.39 netdev_set_master() contained Linux bonding calls needed to
> setup bonding devices. Calling this function from batman-adv leads to
> unexpected behavior when current batman-adv versions are used on these
> older kernels.
> 
> To fix the situation compat.h now ships its own implementation of
> netdev_set_master() which does not change the net_dev->master state
> on kernels older than 2.6.39.
> 
> Reported-by: Andreas Pape <APape@phoenixcontact.com>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  compat.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

I have already cherry-picked that patch myself.

Thanks,
Marek

--nextPart3185618.A8mY72z7NR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNHNHAAoJEFNVTo/uthzAI7UH/3hRsovC3j1Pf/UMXqccesW0
7WQUjhnVtqzXksNdKP1D21mnDaQoSvGk3PDhMCJDGVct15vp5+wrC87pyDQ3IUEG
vSLLOFh1rJb5f3407HU32zQUwPpK8R86PP6NZz04UMbrXYcrMCmADsaR/okwDPgE
BlupuW9PdwBN1F2IS6mcVEE6T2ocm//ICS6wkVYJQnMT/RwZXQODJsqTJoC41Xu3
xTKvtFp1dqjH4BUS9DXRtQ1MoKwoEITfi8M64nlNqAENcvXBiczlqBQcnxDvnQIu
ulXLcVBU4BuKZgF8FaHlD6rR73NIx+u9bJ3G1uoqCWLnU2Vm7RqeFooDaQKH1LY=
=2X4I
-----END PGP SIGNATURE-----

--nextPart3185618.A8mY72z7NR--

