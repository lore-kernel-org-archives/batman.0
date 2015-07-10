Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 10 Jul 2015 16:20:14 +0800
Message-ID: <2530346.cE5PXIuVig@voltaire>
In-Reply-To: <1434957820-8418-1-git-send-email-sven@narfation.org>
References: <1434957820-8418-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2632250.bDCd0ZA5Nn";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add missing include rculist.h
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2632250.bDCd0ZA5Nn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 22, 2015 09:23:40 Sven Eckelmann wrote:
> originator.c is using hlist_for_each_entry_rcu but did not include the
> required header for it.
> 
> Reported-by: Marek Lindner <mareklindner@neomailbox.ch>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/originator.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision 1bd0558.

Thanks,
Marek

--nextPart2632250.bDCd0ZA5Nn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVn4A+AAoJEFNVTo/uthzArmwIAJ8TS8ks3Ma0DpXQazlmwV3P
wRjLRAITno+VDJKWjUkxSMBOW6NgL7Xhw6VIcfMul7gxbMFm7kTc6bf96B+J4M1Z
CxFixRXWeyPBhUGmbM4ZSJsFIBqMbJOwhJORVirm7urDTCJILAUdFWtSDaydjuXZ
UOb9s/+25qE7uHd6tkWqbbXF++aSQnP58qaymBw/ehfPMkL01YMDSLf9ZrNNQl5r
MhGzLFTdt1mfRnevhei42VVUqMRacDEzjzu/2if3a4NcMxB9wj2kDn4rvBPdLIaA
zgRigFiXkt3Yvqbf2JXRd0VCf12wuJ0KPbzbO7qVyTB2mrCr3cZcBDHZEdgyEh8=
=IThh
-----END PGP SIGNATURE-----

--nextPart2632250.bDCd0ZA5Nn--

