Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2015 13:00:20 +0200
Message-ID: <1647977.TX5clMHFCZ@prime>
In-Reply-To: <55E5692D.8090909@meshcoding.com>
References: <1440600113-21305-1-git-send-email-sw@simonwunderlich.de>
 <1440600113-21305-3-git-send-email-sw@simonwunderlich.de>
 <55E5692D.8090909@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11350165.s8NQ7kvuHc";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv2 2/3] batman-adv: avoid keeping
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


--nextPart11350165.s8NQ7kvuHc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 01 September 2015 11:00:29 Antonio Quartulli wrote:
> On 26/08/15 16:41, Simon Wunderlich wrote:
> > In the case when a temporary entry is added first and a proper tt entry
> > is added after that, the temporary tt entry is kept in the orig list.
> > However the temporary flag is removed at this point, and therefore the
> > purge function can not find this temporary entry anymore.
> 
> When can this really happen? When a temporary client has roamed to a new
> originator before it could be claimed by the first one ? Or are there
> other cases ? I think it is important to make this clear, because the
> original logic was such as the expected behaviour was to receive an ADD
> event from the same originator where the temporary client was seen.
> 
> Other than this, the patch looks good.

I've seen the problem in that problematic case which was fixed in PATCHv1. 
Practically, it is unlikely to happen unless there is a malicious attacker or 
another bug like the one described earlier - that is, speedy join is triggered 
without any actual TT update.

The main problem I've perceived here was that the TT entry got the temporary 
flag removed even if the original sender didn't supply a proper TT 
announcement yet. The reason for this was that it got a proper reply from 
another orig node.

The roaming case you've described would also cause the temporary client to be 
removed, but might be added later through a ''proper'' TT announcement.

Do you think I should include any of this in the commit message?

Cheers,
    Simon
--nextPart11350165.s8NQ7kvuHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlXlhUcACgkQrzg/fFk7axYVNACg8VHe54FnnEj3s92zKtve4q4u
1nkAoIfgk00nJbuAqXchwmaFSFIwBwXN
=xFkq
-----END PGP SIGNATURE-----

--nextPart11350165.s8NQ7kvuHc--

