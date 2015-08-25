Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 25 Aug 2015 17:24:01 +0200
Message-ID: <1615647.59CK0EQaeA@prime>
In-Reply-To: <55DC386D.70109@meshcoding.com>
References: <1440170118-10876-1-git-send-email-sw@simonwunderlich.de>
 <1440170118-10876-2-git-send-email-sw@simonwunderlich.de>
 <55DC386D.70109@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15165855.Li4XbfMoPS";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 1/4] batman-adv: fix speedy join
	for DAT cache replies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net


--nextPart15165855.Li4XbfMoPS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi Antonio,

On Tuesday 25 August 2015 11:42:05 Antonio Quartulli wrote:
> On 21/08/15 17:15, Simon Wunderlich wrote:
> > +			/* Cache replies should not be considered for speedy
> > +			 * join, since the clients do not actually reside at
> > +			 * the originator.
> > +			 */
> > +			if (subtype != BATADV_P_DAT_CACHE_REPLY) {
> 
> Tha patch looks good but this should really be:
> 
> 			if (subtype == BATADV_P_DATA) {
> 
> because speedy join is supposed to work with any payload packet.
> 

OK, will make that change in PATCH v2.

Thanks,
   Simon
--nextPart15165855.Li4XbfMoPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlXciJEACgkQrzg/fFk7axY2EACgsXvnTavu2vGSSjjICFbJQQNV
bHgAoLwvzQixwNvHYq1BTxmkgrt+sBqC
=mVHu
-----END PGP SIGNATURE-----

--nextPart15165855.Li4XbfMoPS--

