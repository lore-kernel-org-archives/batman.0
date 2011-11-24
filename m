Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 24 Nov 2011 14:18:22 +0100
Message-ID: <1323728.0ybshCSZ9s@sven-laptop.home.narfation.org>
In-Reply-To: <201111242101.21710.lindner_marek@yahoo.de>
References: <1322131238-11036-1-git-send-email-sven@narfation.org>
	<201111242101.21710.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8264967.99DAIVrGPc";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Move build compat stuff to
	Makefile
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart8264967.99DAIVrGPc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-15"

On Thursday 24 November 2011 21:01:21 Marek Lindner wrote:
> Hi,
> 
> > I looked at the new patches from ordex and thought about using the
> > Makefile from the kernel as the Makefile.kbuild in the standalone
> > distribution. The Makefile is only the user friendly compatibility
> > layer over the kbuild stuff.
> 
> I thought the main idea behind this separation was to have one Makefile for
> the kernel folks and one for the out-of-tree users ? Are they going to
> accept a single Makefile which contains more than what is needed for
> in-kernel development ?

What?

I moved the kernel's Makefile the standalone version and called it 
Makefile.kbuild... a 1:1 copy and not some kind of "a little bit like the 
other thing from the standalone repos". Maybe you already noticed that this 
thing is one reason for the merge conflicts which need additional work to get 
it into the kernel. So the concept would be:

 * Makefile.kbuild == the thing called Makefile in the kernel under
   net/batman-adv/
 * Makefile == the thing which does the magic things to get a "good" user
   experience and the compatibility stuff

I would be even happier when we also could remove the '#include "compat.h"' 
from main.h somehow, but I had no good (and working) idea.

Kind regards,
	Sven
--nextPart8264967.99DAIVrGPc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOzkQeAAoJEF2HCgfBJntGL34P/AkKHVapeyODvfqwR+R0Wfxa
HTZP/f8n3RemiYAqUbNms6jHCQf/l+V1FPcxsohgHq84sp6ugd/yp0L2WVewtIfO
gLlrz6pKWEmTW9ko4GKHGBPdo+JvmjPxuOdEhmy+heDrwTuc4jRRxD+r68ush/lV
LTg7+I31ZwP8O4nr5YIG4Zb6wScjZoq6HTobu4yh5kpjyDfDsC3tvNhCGu8xv2Sy
kU4aJxEorllJ6yd9wrnPH+vYBNbCTduATM7MVwicLg2tBruwbV2T9nDd/Jd6UHOt
b1TI67vnZOG0s/QbJbh2z2fmBzrLmZW6vGBW7SpddSTAj5k6KrWRdmgolr3w0kqG
yz8iMBkfKJgl3QFcu/dXuoqZN2RpWnTr1STpNlR6Ln80X9ImSW3ZKT9P6pFxEJvu
bE9+CT39RYsDDJrIetQ32uUUeUgWlZcXxme3GY3uMuo8SgVQLru7Tlb6hS8GS+oQ
4r2iScQW9TE/718h6D7/RliVZzM0kz28Gas7fCwNo6+P+Q/Aay7Gz65iCnMdMP/T
0PlnVhRN/UrJz7sYoJFtp9SaOIbyLC7mt5NLZnW658qBraeRNwi1fB1VNohpp6vV
jdWjWI4gtv924h3zBjfCqKEH2VEI9I3GYaIZpfrPiuEObXKX8S1IHCDY8EFQ6Gal
HbhYGFnRcyINhJ3WDRqb
=192J
-----END PGP SIGNATURE-----

--nextPart8264967.99DAIVrGPc--

