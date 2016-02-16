Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 16 Feb 2016 17:07:50 +0800
Message-ID: <33852719.eHQaTqlKo3@voltaire>
In-Reply-To: <2083986.sQ3UmFvpA5@bentobox>
References: <1455273335-27063-1-git-send-email-sw@simonwunderlich.de>
 <2083986.sQ3UmFvpA5@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13479143.HQFzna6ez8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix logic error in
	batadv_v_ogm_forward
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>, Simon Wunderlich <simon.wunderlich@open-mesh.com>

--nextPart13479143.HQFzna6ez8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 15, 2016 09:30:09 Sven Eckelmann wrote:
> On Friday 12 February 2016 11:35:35 Simon Wunderlich wrote:
> > From: Simon Wunderlich <simon.wunderlich@open-mesh.com>
> >
> > My latest restructure attempt of the BATMAN v forward function
> > introduced a regression, causing kernel crashes when an OGM is
> > forwarded. This patch fixes it.
> >
> > Fixes: 30c96bc787 ("batman-adv: move and restructure
> > batadv_v_ogm_forward")
> > Reported-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> > Signed-off-by: Simon Wunderlich <simon.wunderlich@open-mesh.com>
> 
> Thanks for the fast update. It fixes the problem in my setup
> 
> Tested-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Applied in revision ef30ba9.

Thanks,
Marek

--nextPart13479143.HQFzna6ez8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWwubmAAoJEFNVTo/uthzAkzgIAKRKNQl3K2B+ViQSgSK+x/ih
AowqqEoaAAaT/Hh4YS0izP9slj51vezwBtg9ej5P9kgF5DTgIic5P1rx3Ktn/jbE
uaDhfPsdsRXAUpxmzFuy3q2TX/13nL+7luYMseGwalEPXUtHA10/6SdW7Nbr8/kK
f6cWcFoFNi2Dd2vRRRuQCf13xNBf/CkMivCIBt7wihWe2YLcnWOBpisDOrj/6yuN
1LxSKFmQZdMcTd/SoN56D921jORLM5HelzGz3dKtVL41hcfzUMWYfEdVYQqPLuOt
NGwkUzeTA7iRDsGfEBwV37DKBKZ59avZzd93VEguARFVqS+uTOEdH4xwie85OI4=
=gJal
-----END PGP SIGNATURE-----

--nextPart13479143.HQFzna6ez8--

