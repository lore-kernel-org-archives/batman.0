Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 Mar 2016 13:35:01 +0100
Message-ID: <121426826.jDACy89axc@bentobox>
In-Reply-To: <1456867148-31883-4-git-send-email-andrew@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-4-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6337446.Efj9TpSUhT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Handle parent
	interfaces in a different netns
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
Cc: Antonio Quartulli <a@unstable.cc>, "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart6337446.Efj9TpSUhT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 01 March 2016 22:19:07 Andrew Lunn wrote:
> batman-adv tries to prevent the user from placing a batX soft
> interface into another batman mesh as a hard interface. It does this
> by walking up the devices list of parents and ensures they are all
> none batX interfaces. iflink can point to an interface in a different
> namespace, so also retrieve the parents name space when finding the
> parent and use it when doing the comparison.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Antonio Quartulli <a@untable.cc>
> ---
>  net/batman-adv/hard-interface.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)

Include missing in net/batman-adv/hard-interface.c

    #include <net/rtnetlink.h>

Does anyone (not only Andrew) have a proposal regarding the compat code?
Patch 1+2 should be unproblematic (maybe these can already be applied?).

This patch here is the first problematic one because it uses get_link_net
which was first introduced in v4.0 with d37512a277df ("rtnl: add link netns
id to interface messages"). I personally see some function substractions
coming at us. But then it would be better to have this code in a smaller
function to make "patching" easier (but I don't have a complete solution
right now):

   dev_parent_net = default_net;
	if (dev->rtnl_link_ops && dev->rtnl_link_ops->get_link_net)
		dev_parent_net = dev->rtnl_link_ops->get_link_net(dev);

The next problematic part in regards of compat stuff is the patch 4.
linux/ns_common.h is missing (can be added without a problem in
compat-includes). More problematic is the net::ns substruct (to be more
precise the net::ns.inum) which was first introduced in 3.19 with
435d5f4bb2cc ("common object embedded into various struct ....ns") and
was previously called net::proc_inum (3.8-3.18) and did not exist
before v3.8 98f842e675f9 ("proc: Usable inode numbers for the
namespace file descriptors.").

Kind regards,
	Sven
--nextPart6337446.Efj9TpSUhT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW2YD1AAoJEF2HCgfBJntG7ikP/A/glBoNUzi+/uiGmWvn59jg
O/eEB8MQwKDvNEevAG0azWcNeVinsr3NfOo67NbulUSKUfMaUhZqDYG+QhZ4+Sr1
EI95I++1P+bLCy9H0/tFDX9k1PwMeXlVPwgUl0S1gEOFGF7K0qQ/nD6YJeHvp6ns
BUSn9ic4e9ym9ROxLXrdkygcAFTcbtpMgm+ozdkwq7BozCysa1e0E7VUbORbxBT/
Hvh+XDSkzbHRb4fliuXjMvUOt4RjaG6ji//aAoaKT4OduvtNV5L0HsaRHX5r5WDt
N6wAX3FDB2bnmm4WWFiwMDMuIgDy3nOsh71yJymBzag9Shw2NvnoCiE0OJHNmfOm
rp+lE2AYZOml01/p2krYVGcvTDyIwjTGj4BqaoEEghwFCrwNYehf7kWjzO5JW/lO
uI95TyYXTvystpT2VFF2r9bZus95O+QONwTEXLc8gPS+64v2EUxvcUjIeHdKHS+D
K4ClTpPlC6Ep/qd9GXA/VpSypmxMRuL3y7bHwcNCQCbMbEPq7GQWB7KKIO/P/T9e
+fwFYcEMGDP9In1NpPWIHyGYrzgV+NB+oYZTqiJfMFZ7GDtUVa1DuB+dkqMOlyvc
GOROIarpK7TezGlA+w5GS/LeiO+2+fgqthlafPTsJ0G4GDvYuMxdNe84RhjF5bLd
6ngajlD/Zy0lZQRFOu/6
=a59h
-----END PGP SIGNATURE-----

--nextPart6337446.Efj9TpSUhT--

