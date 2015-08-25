Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 25 Aug 2015 17:27:23 +0200
Message-ID: <7584192.JLJF9DuEHW@prime>
In-Reply-To: <55DC3A1D.1060800@meshcoding.com>
References: <1440170118-10876-1-git-send-email-sw@simonwunderlich.de>
 <1440170118-10876-3-git-send-email-sw@simonwunderlich.de>
 <55DC3A1D.1060800@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1622905.L1Y0lElrCM";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 2/4] batman-adv: avoid keeping
	false temporary entry
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


--nextPart1622905.L1Y0lElrCM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi Antonio,

On Tuesday 25 August 2015 11:49:17 Antonio Quartulli wrote:
> On 21/08/15 17:15, Simon Wunderlich wrote:
> > In the case when a temporary entry is added first and a proper tt entry
> > is added after that, the temporary tt entry is kept in the orig list.
> > However the temporary flag is removed at this point, and therefore the
> > purge function can not find this temporary entry anymore.
> > 
> > Therefore, remove the previous temp entry before adding the new proper
> > one.
> 
> [..]
> 
> >  		/* if the client was temporary added before receiving the first
> > 
> > -		 * OGM announcing it, we have to clear the TEMP flag
> > +		 * OGM announcing it, we have to clear the TEMP flag. Also,
> > +		 * remove the previous temporary orig node and re-add it
> > +		 * if required. If the orig entry changed, the new one which
> > +		 * is a non-temporary entry is preferred.
> > 
> >  		 */
> > 
> > -		common->flags &= ~BATADV_TT_CLIENT_TEMP;
> > +		if (common->flags & BATADV_TT_CLIENT_TEMP) {
> > +			batadv_tt_global_del_orig_list(tt_global_entry);
> > +			common->flags &= ~BATADV_TT_CLIENT_TEMP;
> > +		}
> 
> mh...interesting..and nice catch. Have you tested this with a client
> roaming from A to B during the "speedy join" period?

No I didn't. I've just seen bad entries dangling and never getting cleaned up, 
and suspected that "speedy join" added TT the entry falsely. However, in that 
case it should only have been temporarily and getting removed later, which 
wasn't the case. Therefore this patch ...

I haven't tested this patch on the production network because its very hard to 
reproduce there, and the bug is probably squashed already with the first 
patch.

Thanks for reviewing!
    Simon
--nextPart1622905.L1Y0lElrCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlXciVwACgkQrzg/fFk7axbxTQCgtZyAYWore5MFWPCzOyCm198F
kRsAoK5P/SHm/VrQo7J+zdn5JoT7FzL9
=9Obo
-----END PGP SIGNATURE-----

--nextPart1622905.L1Y0lElrCM--

