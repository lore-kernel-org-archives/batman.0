Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Apr 2015 08:35:37 +0200
Message-ID: <1524181.VdC0CvID4i@sven-edge>
In-Reply-To: <2239102.H9P5JOuLU8@voltaire>
References: <1429292430-30883-1-git-send-email-sven@narfation.org>
 <1429292430-30883-4-git-send-email-sven@narfation.org>
 <2239102.H9P5JOuLU8@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1717917.K3mbkasDQY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 4/4] batman-adv: Automatically create
	nested kfree_rcu helper functions
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1717917.K3mbkasDQY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 21 April 2015 11:52:16 Marek Lindner wrote:
> On Friday, April 17, 2015 19:40:30 Sven Eckelmann wrote:
> > The kfree_rcu compat helper for old kernels require a special function
> > that
> > knows how to calculate the offsets to the actual data pointer to call
> > kfree. These can either be manually provided or the GCC extension for
> > nested functions can be used to automatically create a local function
> > using a macro.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > 
> > v4:
> >  * rebased on top of master with merged patches from
> >  
> >    https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012985.htm
> >    l
> > 
> > v3: no change
> > v2: no change
> > 
> >  Makefile                        |   1 -
> >  compat-include/linux/rcupdate.h |  15 +++++
> >  compat.c                        | 120
> > 
> > ----------------------------------------
> > compat.h                        |  20 -------
> > 
> >  4 files changed, 15 insertions(+), 141 deletions(-)
> >  delete mode 100644 compat.c
> 
> Applied in revision 082c888.

The commit is also not the patch I've send you. compat-includes/ is also 
missing in this commit.

Kind regards,
	Sven
--nextPart1717917.K3mbkasDQY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVNe+8AAoJEF2HCgfBJntGqPMQALURR9iNkl83OTQrAAs/VtyW
GZi2aPWLtm0REJqjvEG+n/UcmMSHsXLNwJfCA/Pv8zQ0kCWRR60rR6/JzysmvUeY
daBQzjL6UNYJTr85/kwKsExE91CSFs+oHa4DlKALuc8oBHFZduTiGMSlIapDRRal
jfDHBjQIJYqHz0ibHjK3UiN4Mm7hGNGJfC+vuibAod1U+jkIiqAlhmfxe7MGXf0N
ZmahmUVeaKeFTtTCQROyXpI3WSKO5713mhHE+Xqp3/VbfewR4M5cjB4S8QskcxCM
9wE3Bko2FbThTgBy82O2H9L9hpAeI+q7eEVpol3pLvriSTfLsgTfcwAVl3t6tk2R
YeqxOfo+ceNpmtcjrKd8Qle71h+0+zTlc5ld51JH7yBqUDdUXKNUkp9tC+ETPgjd
HVi4wEfv8PCtOUX+kiERRr3eg8tG0D9ArGJLUygkkmO8L0G4fLqUxJWCw67dfDny
4GNpM0Hzl2rLaXRlSGXDedFZ8EWEe5dlfroBc7sVETLfx7wYxyTXn616dIyCp/EW
r7pQKiOoN1powYQisqj119vZ8TI8gPr3XmwcJ0Bf5ySt5ij3/lmn5g3FhGX+Hf4n
VkD27NtFyNRQmEAajsn3Vd6H18C7Zewdhcl+LJ6Vqv1mmtfH9BIYAYqTZiCeHaqP
gTn7gWzG03JO9eS+grKJ
=99ly
-----END PGP SIGNATURE-----

--nextPart1717917.K3mbkasDQY--

