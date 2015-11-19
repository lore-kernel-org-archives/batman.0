Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 19 Nov 2015 15:13:40 +0100
Message-ID: <5592566.OqeGCRmsJ8@prime>
In-Reply-To: <CAKrZ8yf8rKK__5gNsUncjt59zR7T+wuVx2x+DHQELdqWVz6DxA@mail.gmail.com>
References: <CAKrZ8yf8rKK__5gNsUncjt59zR7T+wuVx2x+DHQELdqWVz6DxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart51714284.Zjn3yP9Ai0";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batctl file errors
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

--nextPart51714284.Zjn3yP9Ai0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

On Thursday 19 November 2015 15:04:56 no name wrote:
> I am using BATMAN on a raspberry pi b+ with a kernel version of
> 4.1.13+ but my problem also occured on an older kernel (I tried
> updating, which did not help). My BATMAN is on batctl
> debian-2012.1.0-1 [batman-adv: 2015.0].

please use a recent batctl which matches your version. There are newer debian 
packages out there, too.

> 
> 
> I try to get the vis_mode up and running, which fails in multiple
> ways, because I can't even create logs.

For vis, please use alfred. Vis is not included in more recent batman-adv 
versions anymore.

> 
> sudo batctl loglevel -> "Error - can't open file
> '/sys/class/net/bat0/mesh/log_level': No such file or directory"
> 
> sudo batctl vm -> "Error - can't open file
> '/sys/class/net/bat0/mesh/log_level': No such file or directory"
> 
> and so on. The thing is, when I try:
> 
> sudo batmand s -> "Not using interface s (retrying later): interface
> not active" whereas if I try:

batmand is not batman-adv. batmand is the original Layer 3 version, while 
batman-adv is the layer 2 version. batctl only works with batman-adv. I'd 
suggest to use batman-adv only.

> 
> sudo batmand s IP bat0 -> batman cannot be pinged from any other
> interface any more
> 
> did I forget to install something?

I'd suggest to install recent versions of batman-adv and batctl and possibly 
alfred if you want vis, and deinstall batmand. After that, consider reading 
our docs again, we have a couple of nice getting started docs. :)

Cheers,
     Simon
--nextPart51714284.Zjn3yP9Ai0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlZN2RQACgkQrzg/fFk7axY8kwCg6xXC3/5HEGb9xFJN2Hw5QYhr
iugAniiSjuaQQZ4SQfzWcAQKCDCese5g
=whyz
-----END PGP SIGNATURE-----

--nextPart51714284.Zjn3yP9Ai0--

