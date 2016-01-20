Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Jan 2016 16:31:09 +0100
Message-ID: <3664367.acxEXol4x0@prime>
In-Reply-To: <569FA717.5090108@unstable.cc>
References: <1453296735-8319-1-git-send-email-sw@simonwunderlich.de>
 <6579684.ngYt9xsEyU@prime> <569FA717.5090108@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2172762.OcJKXIYman";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: move and restructure
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
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2172762.OcJKXIYman
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 20 January 2016 23:26:15 Antonio Quartulli wrote:
> On 20/01/16 23:18, Simon Wunderlich wrote:
> >> this is changing the behaviour.
> >> here now we get a router which potentially was elected during the
> >> previous update_route() call while processing this very OGM. We are
> >> still discussing if we want to do this or not, but this patch should be
> >> just a style change, while this is not.
> > 
> > No, this is already in the code which is merged into master - we already
> > acquire the updated router (see bat_v_ogm.c:547, function
> > batadv_v_ogm_route_update()).
> 
> uhuhuh?! Actually you are right!
> This means we currently send one OGM every time we make an election,
> thus we might send multiple OGMs with the sequence numnber, despite this
> is still under debate.

No, we only send once per sequence number, see below.
> 
> As far as I remember did not want to follow this approach at the moment?
> Am I missing something?

Right now we store the last sent sequence number for an originator in 
orig_ifinfo->last_seqno_forwarded when forwarding. This field also gets checked 
and the OGMv2 gets dropped before forwarding when receive it again.

So yes, we send immediately after we make a new election, but only send an OGM 
once per sequence number.

Cheers,
     Simon
--nextPart2172762.OcJKXIYman
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlafqD0ACgkQrzg/fFk7axbAEACgxa7eY+SewrHhYx6fxf/JJNKy
j2kAn1dSWR5QvXmAqfnrS9O808YMQWT4
=ao/m
-----END PGP SIGNATURE-----

--nextPart2172762.OcJKXIYman--

