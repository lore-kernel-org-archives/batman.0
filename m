Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 May 2018 12:50:27 +0200
Message-ID: <2946906.LStWHluSmG@bentobox>
In-Reply-To: <fec8128d-0021-74db-b047-305fb1f70104@cogentembedded.com>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
 <20180524120300.15829-3-sw@simonwunderlich.de>
 <fec8128d-0021-74db-b047-305fb1f70104@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4087780.vPFYHgfXCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: Disable
 CONFIG_BATMAN_ADV_DEBUGFS by default
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

--nextPart4087780.vPFYHgfXCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 25. Mai 2018 13:33:59 CEST Sergei Shtylyov wrote:
[...]
> > --- a/net/batman-adv/Kconfig
> > +++ b/net/batman-adv/Kconfig
> > @@ -94,13 +94,13 @@ config BATMAN_ADV_DEBUGFS
> > bool "batman-adv debugfs entries"
> > depends on BATMAN_ADV
> > depends on DEBUG_FS
> > -       default y
> > +       default n
> 
>     N is the default default. :-) You don't need this line.

Hm, looks like this would have to be changed in a lot of places (~782 
according to `git grep 'default n$'|wc -l` in my slightly outdated linux-
next). Do you want to fix it everywhere? Might be good to get this integrated 
in checkpatch.pl when this will become a new policy.

Kind regards,
	Sven
--nextPart4087780.vPFYHgfXCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsH6nMACgkQXYcKB8Em
e0afwxAAxFhM/LZFUcFfh8hs8mWJue7BU+VmRwlb44RvSgLtYkqEEky5jnPIUIRf
GbKwuQlG0UgvVAlSwkeKOx97kpjsawm66acd9mwAf8ICJe8At7ZmOi5RFRDhhRJU
3+idLlrka8MOhrIrVs7fCqRdWg7CCBeq3YmZiK187Fganex2FxABgMgtGws5X04X
h9X7p5XUPgA3X/9woiYZS/NvH6JMaaMX/hb2l1Daos+N000TBkBguGURP1aF7ssl
crhb6rK2M03UnqvbJHl/y99uKOQWj8tUXdxDBdR7IDmY0Z3NeBRjgMCtfj/4fBQJ
PadZB7yRMGNwAJ6FSAuO3lZ/f4oU0D/zkzV6gWul1Fnjo+tIzud5qas/vGUVWEN0
xkED+TphzFLpkyjrdiaCVUZEDWC70HSbeLxmPFw6llr4Ywiid+nREimnlIcsvfRU
JEIo9kYmITOYwS7y3a1p7QW2pF0Mfs4+Szg8erpEq+/g9ngzi9YDtLteR2i22+Pq
YyX18uHCpH5R9nv5j6qf1jHDuInqRXwTMaUNm0kXMdkqngd5SYZHNpKqKhKfZQ3B
noJJZiuFjtVYE1tYj2yQOspmnCs9ydt/4PfIQrxc5N2DlJRllsUbF0gZb0xbu4i9
iPYvwDoyVa1cGHLfQfdCEDb7WgAeu9V/d4xYRV366YIAtrzPTfQ=
=r6uW
-----END PGP SIGNATURE-----

--nextPart4087780.vPFYHgfXCh--

