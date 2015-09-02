Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 02 Sep 2015 19:39:18 +0200
Message-ID: <1775592.Epjag6J6MN@prime>
In-Reply-To: <55E578E8.5010107@meshcoding.com>
References: <1440600113-21305-1-git-send-email-sw@simonwunderlich.de>
 <1440600113-21305-4-git-send-email-sw@simonwunderlich.de>
 <55E578E8.5010107@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6553859.pIh0QgYnxk";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv2 3/3] batman-adv: detect local
	excess vlans in TT request
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


--nextPart6553859.pIh0QgYnxk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 01 September 2015 12:07:36 Antonio Quartulli wrote:
> On 26/08/15 16:41, Simon Wunderlich wrote:
> > If the local representation of the global TT table of one originator has
> > more VLAN entries than the respective TT update, there is some
> > inconsistency present. By detecting and reporting this inconsistency,
> > the global table gets updated and the excess VLAN will get removed in
> > the process.
> 
> This a nice catch, but I am not sure this is the right way of
> implementing the fix.
> 
> Imagine this sequence of events:
> 1) originator O1 sends an OGM
> 2) client C1 connects to O1 on a newly created VLAN and starts sending
> traffic
> 3) originator O2 detects (speedy join) C1 before receiving the O1's OGM
> 4) O2 receives O1's OGM and the check will kill C1 because its VLAN is
> not advertised in the OGM. O2 needs to wait for O1's next OGM before
> getting to know C1 again
> 
> Maybe this scenario is rather unlikely? What do you think?

Mhm, I'd argue its rather unlikely. This would imply that the data frame is 
reaching O2 faster the OGM. I don't think its very likely that it overtakes 
it, and even if it happens, its probably a very tight race.

Also, I'd think that nodes typically just use or don't use a VLAN, and don't 
create VLANs all the time ...

Even if that happens, the race is resolved with one originator interval.

I'm open for better ideas, though. :)

Cheers,
    Simon
--nextPart6553859.pIh0QgYnxk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlXnNEYACgkQrzg/fFk7axY65ACfcJ2Tpg1/W3q/SJTpFXkVgdTL
9s0An006864qPvPLPlQd3UPIOy1BVJ+4
=qa18
-----END PGP SIGNATURE-----

--nextPart6553859.pIh0QgYnxk--

