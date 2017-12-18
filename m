Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Dec 2017 22:51:58 +0100
Message-ID: <2202407.cOva1GthCj@sven-edge>
In-Reply-To: <CAHuRCtSXTMBekv95iaoxVQtxGWLvk4HOz_SbOsn4WdXT9HpaFg@mail.gmail.com>
References: <CAHuRCtSXTMBekv95iaoxVQtxGWLvk4HOz_SbOsn4WdXT9HpaFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20184143.8Uk1HXENVE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Batman -adv no longer backwards compatible with
 kernels Pre -4.0???
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
Cc: jorge power <jorge@alumni.ufl.edu>

--nextPart20184143.8Uk1HXENVE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 18. Dezember 2017 15:55:48 CET jorge power wrote:
> I am running kernel 3.3.8 and trying to use batman adv ver 2017.4.
> I am getting error:
> 
> net/batman-adv/hard-interface.c:101:28: error: 'const struct
> rtnl_link_ops' has no member named 'get_link_net'
[...]
> So was the backwards compatability broken intentionally so its no
> longer backwards compatible with older kernels?
> 
> What can i do?

Stop trying to do your own stuff and use the full compat layer from batman-adv 
or LEDE (mac80211 + small batman-adv compat layer). We will not integrate any 
compat stuff in net/batman-adv/ because this is the part which is part of the 
official kernel [1]. So if you don't want to use the compat stuff then please
don't complain about having build errors.

And in case  somebody wonders: Yes, he acknowledged on IRC that he is not 
using the compat stuff from batman-adv to build against OpenWrt (without the 
OpenWrt package!!!!).

Kind regards,
	Sven

[1] the official kernel doesn't require compat and doesn't want it
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl?id=cb81fc6a3cf694345f29858624e5d9f3509d30d4#n3829
--nextPart20184143.8Uk1HXENVE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlo4OH4ACgkQXYcKB8Em
e0aYgA//fhIvKBOXuN6GamLMDR7fJXTAWVPAsrSrql7PMdfRRON6xOGh7WMn3w2A
TGBGwupmqFFOI8QcdGRz2z+07r9zW8Jo0mmhLEGewmL60P/EzosAf4BtzTcEdGzs
cJXG4CJoJsydMwHLxjf0hscNIDNnlgiltHSMZJQZ2CuW2kPHL/XWV9SYgUTlAEiB
OcaXmeee850+rJgIm0j9A6OYIyunk0dPcW3TQ3clr/5x/UCl/Eeg7yKAZiuZklGy
qAjwU953NiB/sN4SMs5aKDkCamMYOul3fERu709Xt/hI5xD4G1Ldi7OavxIoSi3V
mBWAdDbAvij2csgLEsKvvhYj9cOanFX2IGQyguu7lVeJ+w5598JcGlK2eIMvA+yQ
4H+/G70Hkw6Y/oXa0b69X+eZul84hZcxFrvznNuaYebA6J2VZwOGwaVx/WEPxRxk
cjvXriqvkHGgtCPXsf8r9KpQ0W46VFWJRd1uapQuUgzXU2g990v1EVSHNKKrAPFM
HF90KVJ6e77ICDIngzPsEpzPC+W2gZeBVwwepgcILwTNU1EUbIbDRahGLl7TfMgg
noTuzZwAtSOscIy3AIQvjLGcV7Z1foZvJlzeTCJ6lPDl3JoesxDAohbkR6dH2/6Z
v68nHVG4s9V4wNHNlLsHDFFxOZZ1dWZ9/jFViWLWwOquM5SLtr4=
=ZR6I
-----END PGP SIGNATURE-----

--nextPart20184143.8Uk1HXENVE--

