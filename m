Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Feb 2016 14:47:02 +0100
Message-ID: <1586904.iQrJt9hjfD@bentobox>
In-Reply-To: <OFF77AFE43.E83B8DC0-ONC1257F64.0046B45F-C1257F64.00480579@phoenixcontact.com>
References: <1456381687-29637-1-git-send-email-apape@phoenixcontact.com>
 <4170150.MY2kasJMNI-2016-02-25-13-51-36@bentobox>
 <OFF77AFE43.E83B8DC0-ONC1257F64.0046B45F-C1257F64.00480579@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2005081.GbjJ582rnq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: [PATCH 1/7] batman-adv: prevent
	multiple ARP replies sent by gateways if dat enabled
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andreas Pape <APape@phoenixcontact.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2005081.GbjJ582rnq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 25 February 2016 14:06:39 Andreas Pape wrote:
> I wasn't aware that there is something like the build_test to be used
> before
> sending patches.... But I'm willing to learn.

No, build_test is not something which has be used. It is actually quite hacky
and only used in the daily tests (and by brave people still wanting to use
it).

But you should [1] compile your stuff with sparse. Install it and run the compile
with:

   make C=2 CHECK="sparse -Wsparse-all -Wno-ptr-subtraction-blows -D__CHECK_ENDIAN__"

You can ignore the "shadows an earlier one" in the external headers and the
one about __ret.

And you should definitely use the checkpatch.pl from linux-next:

    ~/linux-next/scripts/checkpatch.pl --strict 000*.patch

> Is there a documentation available how I can use this myself for testing
> before
> making another attempt to send the patches (including a cover letter)?

If you really want to test it with build_test then you have to clone it on
an amd64 system, install iwyu (3.5+), python and the standard build tools.
This example expects that you have a working mail server on your system
which at least can send mails to a local account (YOUR_MAIL_ACCOUNT). The
patches in YOUR_BATMAN_ADV_TREE should be in the master branch to avoid too
many changes checkstuff.sh.

    git clone git://git.open-mesh.org/build_test.git
    cd build_test
    git clone git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git linux-next
    git --git-dir=linux-next/.git/ remote add net-next git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
    LINUX_REPOSITORY=`pwd`/linux-next ./generate_linux_headers.sh
    sudo mkdir linux-build
    sudo mount linux-build.img -o loop linux-build
    # edit checkstuff.sh and remove: testbranch "next"
    TO=YOUR_MAIL_ACCOUNT REMOTE=YOUR_BATMAN_ADV_TREE ./checkstuff.sh
    # fix all the stuff regarding sparse, cppcheck, smatch and try again:
    TO=YOUR_MAIL_ACCOUNT REMOTE=YOUR_BATMAN_ADV_TREE ./checkstuff.sh

Cover letter can be generated in git sendmail by running:

   git send-email --compose 0001-.... 0002-... ....

It is not really required. I just wanted to tell you that the result is not
really about this single patch. But please add all patches to the call of
`git send-email` to automatically create a single thread.

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/open-mesh/wiki/Contribute#Submitting-patches

--nextPart2005081.GbjJ582rnq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWzwXWAAoJEF2HCgfBJntG0PIP/0Gjp9R55mpf5GIuMNNHGr3b
zTEkTCGL+RCJwG0ucsajsSVh1uOC9vwNQ2QMYOIl9WScN4sUvnsHtcytPOyt7MAh
EPcr8/FcPLGHdWAO2397eqs5OY1KxZL585DDI5+n5i9FETkkga0QresgjpPz4x5j
CS6UhnkIGczpIZQ889auXDX76JBkaqlOV6ViUDH7+7TB8JB/7ZyLmhVHJIPZ+eYI
J0PwA3dx54ggg/PjrVA5DTZ/BEKN7E8u/ci5osYM1XkZN86zhUCCiiK77gVMyZGg
Y8ktNJAYLV/+4ReMJvY/EBxeXMmxkvCoyt2w6P+v0TwRV3Ycv7tAgHrUc9Pc9TPF
8Z3heersaymUaerMuj5VAdiXHSUNHmkPbsJjilvpNRrXobsu1oWawKLYgs+VfRM1
blY1X+9etlI3NlImQrSNfZ5pGn7EHmmnI+8CTfFEB8oV6eYI28MT8gXV6OYEE8B1
JAEEBWX1K9pXKwpzW6ktWMH7EU3Qwf6Sc8sdG+nfShszXXSUsRVfx1ULQYXIAqto
gW+1L5p5whVl13rAR25FFD6Zf9aUhbN+g5tTKK0+vtHeC1SJNXFCyY/SoF6LC6+Z
K4zmHZEFMlqiYfktqJIAjwWASJcvvEbwr+qi63UoYzrZJhHGBtwp9mGToAGDhiCv
73FNA4TEFZl/MW+ewjw0
=QEbN
-----END PGP SIGNATURE-----

--nextPart2005081.GbjJ582rnq--

