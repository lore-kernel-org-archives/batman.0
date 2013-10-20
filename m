Return-Path: <linus.luessing@web.de>
Date: Sun, 20 Oct 2013 10:25:07 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20131020082506.GC13550@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] A few questions on TVLV
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
To: b.a.t.m.a.n@lists.open-mesh.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I think I had posted some thoughts on the TVLV feature on the IRC
channel before with some suggestions for changes (e.g. moving the
TVLV feature from the individual packet types down to the common
batman header). And had tried to come up with examples for
features where TVLVs for batman broadcast packets could be useful
- which might have been potential, but not the most convincing,
not the most awesome features.

So now I have a feature which I would like to have / would like to
work on in the future [0], and I would like to know:

a) Whether it is possible to do that with the current TVLV
infrastructure without breaking compatibility.

I think it is, probably by announcing this capability via an OGM
TVLV and only activating this feature if all visible nodes support
it, right?

b) If it is possible without breaking compatibility, then this
could still cause quite some burdon for heterogeneous, multi party
controlled networks, because all nodes would need to
upgraded or older ones somehow blacklisted, right?

c) What is your estimation, would it be easy to pull the TVLV
feature down onto the common batman-header code-wise?

d) Would the ease or difficulty to implement it (c)) and the
benefits it would provide (a)+b)) justify including a patch
for a TVLV-per-batman-header in the first compat bump release?

e) The first compat bump patches were already submitted to net/,
so there actually wouldn't be much time left to do that, would
there?

Cheers, Linus

PS: I would also volunteer to work on moving the TVLV down to the
common batman header, but if the time frame to do that is too
short then I'd probably not be fast enough to do that.


[0]: Split Horizon with a tag (the tag would need a per batman bcast TVLV)
* A per hard-interface mechanism tries to automatically detect whether
  the connectivity to all local link layer neighbors is both
  transitive and symmetric.
* If so broadcast/multicast packets coming from that interface are
  tagged with a unique ID (e.g. the lowest MAC address present on
  that link)
* Such tagged packets are never forwarded onto the according link
  again.

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSY5NhAAoJELxyPiAAt6UvUfEP/1GSnRr87dmA/QfQshMp93dF
hkXW3JWeitlkiMuWttqpnmmf2xGbCrca6aFA6ak41ZtjQq9NEAIm1X9s/pFGkqEl
WDO6McpgIHmQrZiM2m1HaP6L7MWXaXRe1LEIxFocx8rzBXPygHz8G0hk47oAEjin
h22c246w2h9bG+1SniYHq+jIhMYBFOFhh0mo2FW8gmFrK/fP7yx8EN8O+fCXxM+u
URl/RodEF+9qKiXXrYVb11+nTr8UmKfeBR5DKJ0DwBTefVBXR+Q+J9Y3yk3USYgI
fmJbrcSgwXRCtoFfT2QtV8rRmLYCoZJQgxt3iXgAYzv9bImqHkEicb0d2JFUQ17c
gjJSW27H8V6iMCcsO1g7Xc1gb8Wil/ef2E7k4FgmAabnpQvHhqea+TLdxwYtltg3
ToNInOXl5l/qm5lMfPPBXzHLYk/CiFW1jZk2pkANL74qu/d0QnXjXjFpJiCN6IPw
G27gz9PlqOsHoYqrZ4qhgYF8V/qU18ivWpCqfDq4JJHMti3hAi/F/oxROmSk4xWb
COlVKxDzc7HL/av5DIoi+oKWLjzwZl+JWQ6MUfwmjUS0YaAEtC1Euomr6aF7X8fE
KlCHf1Zk9Vmc89LIJFkfvXSW8W4FWATf/S/WVF30lRS3fw8NjDRVXxHRMfUP3f0E
IFXAgbFuisOn7MVECM6a
=AFGF
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
