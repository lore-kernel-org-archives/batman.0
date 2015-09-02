Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 02 Sep 2015 19:35:26 +0200
Message-ID: <51474855.ZTugXQXYdU@prime>
In-Reply-To: <55E58C63.1090500@meshcoding.com>
References: <1440600113-21305-1-git-send-email-sw@simonwunderlich.de>
 <1647977.TX5clMHFCZ@prime> <55E58C63.1090500@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3984137.phoqO871aG";
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


--nextPart3984137.phoqO871aG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 01 September 2015 13:30:43 Antonio Quartulli wrote:
> On 01/09/15 13:00, Simon Wunderlich wrote:
> > On Tuesday 01 September 2015 11:00:29 Antonio Quartulli wrote:
> >> On 26/08/15 16:41, Simon Wunderlich wrote:
> >>> In the case when a temporary entry is added first and a proper tt entry
> >>> is added after that, the temporary tt entry is kept in the orig list.
> >>> However the temporary flag is removed at this point, and therefore the
> >>> purge function can not find this temporary entry anymore.
> >> 
> >> When can this really happen? When a temporary client has roamed to a new
> >> originator before it could be claimed by the first one ? Or are there
> >> other cases ? I think it is important to make this clear, because the
> >> original logic was such as the expected behaviour was to receive an ADD
> >> event from the same originator where the temporary client was seen.
> >> 
> >> Other than this, the patch looks good.
> > 
> > I've seen the problem in that problematic case which was fixed in PATCHv1.
> > Practically, it is unlikely to happen unless there is a malicious attacker
> > or another bug like the one described earlier - that is, speedy join is
> > triggered without any actual TT update.
> > 
> > The main problem I've perceived here was that the TT entry got the
> > temporary flag removed even if the original sender didn't supply a proper
> > TT announcement yet. The reason for this was that it got a proper reply
> > from another orig node.
> > 
> > The roaming case you've described would also cause the temporary client to
> > be removed, but might be added later through a ''proper'' TT
> > announcement.
> > 
> > Do you think I should include any of this in the commit message?
> 
> I think you should mention something that makes this case "real": I'd
> just say that it is possible that a client detected behind a given
> originator moves before an actual claim is made, so triggering this
> particular configuration.

Sounds good, I'll extend the commit message.

Thanks!
    Simon

--nextPart3984137.phoqO871aG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlXnM2EACgkQrzg/fFk7axYyewCfSoWWOxRINOzS0KLTzQhBPwOj
SJsAoIcLJFg4KwL3qcae1CPltOZ+3mhD
=Iz6g
-----END PGP SIGNATURE-----

--nextPart3984137.phoqO871aG--

