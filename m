Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 22 Jun 2010 00:59:47 +0200
References: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
	<20100621223427.GA22687@kroah.com>
In-Reply-To: <20100621223427.GA22687@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1579514.SJotazQnEj";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006220059.48628.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (2)
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
To: Greg KH <greg@kroah.com>
Cc: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1579514.SJotazQnEj
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
> On Sat, Jun 19, 2010 at 02:51:45AM +0200, Sven Eckelmann wrote:
> > Hi,
> >=20
> > here are patches targetted for 2.6.36. They are made on top of patches
> > you have
> >=20
> > already received in 1275852501-28523-1-git-send-email-sven.eckelmann@gm=
x.de :
> >  * Staging: batman-adv: remove redundant struct declaration
> >  * Staging: batman-adv: Move device for icmp injection to debugfs
> >  * Staging: batman-adv: Move tables from sysfs to debugfs
> >  * Staging: batman-adv: convert all sysfs files to single value files
> >  * Staging: batman-adv: Adding netfilter-bridge hooks
> >  * Staging: batman-adv: Add information about batman-adv sysfs entries
> >  * Staging: batman-adv: remove superfluous hint to "translation table"
> >  * Staging: batman-adv: convert vis_interval into define
> >  * Staging: batman-adv: Convert MAC_FMT to %pM
> >=20
> > They also depend on patches not yet applied on 2.6.35, but sent to you:
> >  * Staging: batman-adv: return -EFAULT on copy_to_user errors
> >  * Staging: batman-adv: fix function prototype
>=20
> Something's still not right.  I applied the above 2 patches, and then
> tried to apply the 1/8 patch above:
> 	Subject: [PATCH 1/8] Staging: batman-adv: Mark locally used symbols as
> static
>=20
> It fails with:
> 	patching file drivers/staging/batman-adv/bitarray.c
> 	patching file drivers/staging/batman-adv/bitarray.h
> 	patching file drivers/staging/batman-adv/hash.c
> 	patching file drivers/staging/batman-adv/hash.h
> 	patching file drivers/staging/batman-adv/originator.c
> 	patching file drivers/staging/batman-adv/originator.h
> 	patching file drivers/staging/batman-adv/routing.c
> 	patching file drivers/staging/batman-adv/routing.h
> 	patching file drivers/staging/batman-adv/send.c
> 	patching file drivers/staging/batman-adv/send.h
> 	patching file drivers/staging/batman-adv/soft-interface.c
> 	patching file drivers/staging/batman-adv/soft-interface.h
> 	patching file drivers/staging/batman-adv/translation-table.c
> 	Hunk #2 succeeded at 250 (offset 5 lines).
> 	Hunk #3 succeeded at 442 with fuzz 1 (offset 16 lines).
> 	patching file drivers/staging/batman-adv/translation-table.h
> 	Hunk #1 FAILED at 26.
> 	1 out of 1 hunk FAILED -- saving rejects to file
> drivers/staging/batman-adv/translation-table.h.rej patching file
> drivers/staging/batman-adv/vis.c
> 	patching file drivers/staging/batman-adv/vis.h
> 	Hunk #1 FAILED at 44.
> 	1 out of 1 hunk FAILED -- saving rejects to file
> drivers/staging/batman-adv/vis.h.rej
>=20
> So, any thoughts?

I have currently no idea what you try to achieve by applying all patches out
of order, but you have done following:

 * Staging: batman-adv: return -EFAULT on copy_to_user errors
 * Staging: batman-adv: fix function prototype
 * Staging: batman-adv: Mark locally used symbols as static
   =3D> of course fails because it was applied out of order and misses
      9 patches inbetween


Right thing to do:
 * Staging: batman-adv: return -EFAULT on copy_to_user errors
 * Staging: batman-adv: fix function prototype
 * Staging: batman-adv: remove redundant struct declaration
 * Staging: batman-adv: Move device for icmp injection to debugfs
 * Staging: batman-adv: Move tables from sysfs to debugfs
 * Staging: batman-adv: convert all sysfs files to single value files
 * Staging: batman-adv: Adding netfilter-bridge hooks
 * Staging: batman-adv: Add information about batman-adv sysfs entries
 * Staging: batman-adv: remove superfluous hint to "translation table"
 * Staging: batman-adv: convert vis_interval into define
 * Staging: batman-adv: Convert MAC_FMT to %pM
 * Staging: batman-adv: Mark locally used symbols as static
 * Staging: batman-adv: Ignore debugfs on kernels without debugfs support
 * Staging: batman-adv: permit setting ogm interval to JITTER*2
 * Staging: batman-adv: Add release information for version 2010.0.0
 * Staging: batman-adv: 32bit sequence number and TTL for broadcasts
 * Staging: batman-adv: Add bonding functionality
 * Staging: batman-adv: bonding and interface alternating
 * Staging: batman-adv: record route for ICMP messages


Just saved my patch queues as 2.6.35.mbox, 2.6.36_renewed.mbox, 2.6.36_2.mb=
ox
and created a temporary gregkh branch of linux-next/master:

$ git am -3 ~/2.6.35.mbox=20
Applying: Staging: batman-adv: return -EFAULT on copy_to_user errors
Using index info to reconstruct a base tree...
=46alling back to patching base and 3-way merge...
No changes -- Patch already applied.
Applying: Staging: batman-adv: fix function prototype
Using index info to reconstruct a base tree...
=46alling back to patching base and 3-way merge...
No changes -- Patch already applied.
$ git am -3 ~/2.6.36_renewed.mbox=20
Applying: Staging: batman-adv: remove redundant struct declaration
Applying: Staging: batman-adv: Move device for icmp injection to debugfs
Applying: Staging: batman-adv: Move tables from sysfs to debugfs
Applying: Staging: batman-adv: convert all sysfs files to single value files
Applying: Staging: batman-adv: Adding netfilter-bridge hooks
Applying: Staging: batman-adv: Add information about batman-adv sysfs entri=
es
Applying: Staging: batman-adv: remove superfluous hint to "translation tabl=
e"
Applying: Staging: batman-adv: convert vis_interval into define
Applying: Staging: batman-adv: Convert MAC_FMT to %pM
$ git am -3 ~/2.6.36_2.mbox=20
Applying: Staging: batman-adv: Mark locally used symbols as static
Applying: Staging: batman-adv: Ignore debugfs on kernels without debugfs su=
pport
Applying: Staging: batman-adv: permit setting ogm interval to JITTER*2
Applying: Staging: batman-adv: Add release information for version 2010.0.0
Applying: Staging: batman-adv: 32bit sequence number and TTL for broadcasts
Applying: Staging: batman-adv: Add bonding functionality
Applying: Staging: batman-adv: bonding and interface alternating
Applying: Staging: batman-adv: record route for ICMP messages

So, linux-next has already following patches applied:
 * Staging: batman-adv: return -EFAULT on copy_to_user errors
 * Staging: batman-adv: fix function prototype

All remaining patches are missing and apply cleanly.

Now the same for staging-next (branch staging-next):
$ git am -3 ~/2.6.35.mbox                         =20
Applying: Staging: batman-adv: return -EFAULT on copy_to_user errors
Using index info to reconstruct a base tree...
=46alling back to patching base and 3-way merge...
No changes -- Patch already applied.
Applying: Staging: batman-adv: fix function prototype
Using index info to reconstruct a base tree...
=46alling back to patching base and 3-way merge...
Auto-merging drivers/staging/batman-adv/bat_sysfs.c
No changes -- Patch already applied.
$ git am -3 ~/2.6.36_renewed.mbox=20
Applying: Staging: batman-adv: remove redundant struct declaration
Using index info to reconstruct a base tree...
=46alling back to patching base and 3-way merge...
No changes -- Patch already applied.
Applying: Staging: batman-adv: Move device for icmp injection to debugfs
Applying: Staging: batman-adv: Move tables from sysfs to debugfs
Applying: Staging: batman-adv: convert all sysfs files to single value files
Applying: Staging: batman-adv: Adding netfilter-bridge hooks
Using index info to reconstruct a base tree...
=46alling back to patching base and 3-way merge...
No changes -- Patch already applied.
Applying: Staging: batman-adv: Add information about batman-adv sysfs entri=
es
Using index info to reconstruct a base tree...
=46alling back to patching base and 3-way merge...
No changes -- Patch already applied.
Applying: Staging: batman-adv: remove superfluous hint to "translation tabl=
e"
Applying: Staging: batman-adv: convert vis_interval into define
Using index info to reconstruct a base tree...
=46alling back to patching base and 3-way merge...
No changes -- Patch already applied.
Applying: Staging: batman-adv: Convert MAC_FMT to %pM
$ git am -3 ~/2.6.36_2.mbox=20
Applying: Staging: batman-adv: Mark locally used symbols as static
Applying: Staging: batman-adv: Ignore debugfs on kernels without debugfs su=
pport
Applying: Staging: batman-adv: permit setting ogm interval to JITTER*2
Applying: Staging: batman-adv: Add release information for version 2010.0.0
Applying: Staging: batman-adv: 32bit sequence number and TTL for broadcasts
Applying: Staging: batman-adv: Add bonding functionality
Applying: Staging: batman-adv: bonding and interface alternating
Applying: Staging: batman-adv: record route for ICMP messages

More patches are already in staging-next, but all remaining apply cleanly.

A diff between those two repositories only give me a change which was appli=
ed
by the net folks for their 2.6.36 branch:

diff -ruN drivers/staging/batman-adv/hard-interface.c ../linux-next/drivers=
/staging/batman-adv/hard-interface.c
=2D-- drivers/staging/batman-adv/hard-interface.c 2010-06-22 00:55:28.36001=
8720 +0200
+++ ../linux-next/drivers/staging/batman-adv/hard-interface.c   2010-06-22 =
00:52:26.491518520 +0200
@@ -72,7 +72,7 @@
 #endif
=20
        /* Device is being bridged */
=2D       /* if (net_dev->br_port !=3D NULL)
+       /* if (net_dev->priv_flags & IFF_BRIDGE_PORT)
                return 0; */
=20
        return 1;



So I would say that everything should work as expected.

Best regards,
	Sven

--nextPart1579514.SJotazQnEj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMH+7jAAoJEF2HCgfBJntGhzAP/2sP+sLywwrTHnwfEi4qMDGe
zzjdLvVaSU2zVUmWEOXtKnNZyA33T1s3t+CgjVNNqLyKrgzymC0xWjIBExtUhRkY
pieGhypCoXYz+8x0n8mhttRgo2lhsyci09INfFNA7bT/GuotEcsSeuHaRTnhaKPc
WivqVGCTY0GMgABmXJBnDyFNmREebHXfkByybZ7hZkenlruP+c7e3KrTWqzBq1EU
yC3uFQ9nLaDJWW2zcj3XcWm69nQ4uVWA35CzayzWYncpW0z2lYx/603c0mmpv6vE
foQAO6i+cwDdmtOiZf2ngOZDC3/HrNoUQIoBPKSmRw5mVIH9wXdaK1iRKDe+khjh
W4hsD9EBN6iNv06JF/fPAiLcLjaCqq+eRyv1jYCgibobiLTYwRF8qs8nhc8BSHPq
niFFAiCmjlfhjtm3WKJ3w4XHg4pcDR9QrE9tk++AxgZvTanrlodzjMu8waMtesqh
n8v0+dztb3kgrQkHRT/lE8cexmxKhr77ntYKUmr5gpctOi26feybZRcmabTotjnB
eMmHh15n3CdvTIPXFQFqkzxJkGrvQ70CqctlrmWniR1gnkDN38PP07PmHHmO75gu
xKRj4KqnikHonmVqsMsqAmDIIxgfO3NJzGzkLZ8IkfWB3kvTM7u70R2vHh6K/gTR
iPYj45bO+Ubh3er9G5SC
=B7KE
-----END PGP SIGNATURE-----

--nextPart1579514.SJotazQnEj--
