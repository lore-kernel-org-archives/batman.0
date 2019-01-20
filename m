Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Jan 2019 16:32:55 +0100
Message-ID: <3904432.cpar7GfAiZ@sven-edge>
In-Reply-To: <20190116104127.698565432@linutronix.de>
References: <20190116102651.489113812@linutronix.de>
 <20190116104127.698565432@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1720244.jrHZZGNX3P";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [patch 2/2] scripts/spdxcheck.py: Handle special
 quotation mark comments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, b.a.t.m.a.n@lists.open-mesh.org

--nextPart1720244.jrHZZGNX3P
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 16 January 2019 11.26.53 CET Thomas Gleixner wrote:
> The SuperH boot code files use a magic format for the SPDX identifier
> comment:
> 
>   LIST "SPDX-License-Identifier: .... "
> 
> The trailing quotation mark is not stripped before the token parser is
> invoked and causes the scan to fail. Handle it gracefully.
[...]

This patch introduces a false positive when checking files with an ANSI-C 
style /* SPDX-License-Identifier: .... */ comment line.

    $ ./scripts/checkpatch.pl -q -f include/linux/bug.h
    WARNING: 'SPDX-License-Identifier: GPL-2.0 */' is not supported in LICENSES/...
    #1: FILE: include/linux/bug.h:1:
    +/* SPDX-License-Identifier: GPL-2.0 */
    
    total: 0 errors, 1 warnings, 79 lines checked

checkpatch.pl is already stripping the "/* " prefix and only sends the 
remaining "SPDX-License-Identifier: GPL-2.0 */" via stdin to
scripts/spdxcheck.py. Thus the newly introduced check

> +                # Remove trailing comment closure
> +                if line.startswith('/*'):
> +                    expr = expr.rstrip('*/').strip()

doesn't match and thus the code doesn't remove the " */" at the end of the 
line.

Kind regards,
	Sven
--nextPart1720244.jrHZZGNX3P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxElKcACgkQXYcKB8Em
e0Yp4A//S9LSe/7QRX7rwb8+URrAa4NeSlLqK9xkIEu8l1qH5JgHUNBXbyx4vLEv
EG/IiMskFVwaExXSvgjrE5IMgKGfeDgd+7G+lYHmcMHrO6brDH5Onbc3t9XHe+8O
dmHa/WLZeYQuvt8iAOuzkGp8s1mUUnDPyN4HiC3ObU53PDCW0mfF9O9HPNEQikjX
avqzO+wyKyBD52h8UYzPVinVble2nbF6wkrxYpUURsZsNtpyiCFg3okKlfbqa+Mb
2gT8nqvNZ9cc8d9QVlg/theMfS5mTcQoBVPCw8ExQ0s7hwO4OjswXTLhh1Dpo6MY
GtEIs68qvQyYOPkfm2KWTeYc4okNBOfJKDprbUk7Kql6LUMhiwE8r2H/M5SNE61s
I8Y5n1oSi3MW3h0Ihqu25XyJ9pLmCgI+Mo7PC/kSeSGahMjnZiPlYXb0OwWl2Bjx
yZoRGkZk4RWAIcAPQkT6IQHi32HYzZUuHPqeIp/H2X0K6lAPMAjdDZV1LTxYP86d
XcmfiBCxBV8PoCmvxzxxK8K5LCXFcbMsPBzJPfFThQmUh7xLRB3XMC49cQTJetMt
0NhaIHgwG2maPRfxH5rDv2uRADDRvvS6bCTbIEb/GFELT+0sOWqUYpn6fNUPjx7y
XBDhZOKSMbQjGccBSExaR3g4rlgsROgh0el0C55tK3V4VAdsd+U=
=nnHA
-----END PGP SIGNATURE-----

--nextPart1720244.jrHZZGNX3P--



