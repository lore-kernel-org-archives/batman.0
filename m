Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Jan 2016 15:34:08 +0100
Message-ID: <6955990.FU2gLkkPUc@bentobox>
In-Reply-To: <56A0E50A.5050209@unstable.cc>
References: <8047297.0qIFjkW2bL@voltaire> <1664897.xQoZSmslHn@bentobox>
 <56A0E50A.5050209@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8307053.JBvfvZPPCn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] OpenWrt cfg80211.h station_info incompatibility
	with kernel+mac80211 [was: B.A.T.M.A.N. V leaves the nest v2]
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
Cc: Felix Fietkau <nbd@openwrt.org>, openwrt-devel@lists.openwrt.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart8307053.JBvfvZPPCn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 21 January 2016 22:02:50 Antonio Quartulli wrote:
> 
> On 21/01/16 22:03, Sven Eckelmann wrote:
> > On Thursday 21 January 2016 14:55:01 Felix Fietkau wrote:
> >>> @Felix, would it be ok for you when I propose a
> >>> "*-sync-cfg80211-station_info.patch" for the 3.18 generic kernel 
patches?
> >>> Or do you have a good idea how to force the openwrt-routing batman-adv 
package
> >>> against the cfg80211.h of compat-wireless?
> >> The openwrt mac80211 package exports its headers to
> >> $(STAGING_DIR)/usr/include/mac80211
> >>
> >> You could just make the batman-adv package use those includes.
> > 
> > Thanks, missed that. I will prepare a pull request for openwrt-routing.
> 
> In case this was missed: we also need to make sure that batman-adv
> depends on mac80211 and that it gets compiled first.

You are right. But the B.A.T.M.A.N. V patches cannot be build with the 
official openwrt-routing package - so no need to get too eager. All we are 
doing right now is to prepare the integration (for the next release which will 
include B.A.T.M.A.N. V).

But if anyone is willing to prepare the changes for the internal branch...

Kind regards,
	Sven
--nextPart8307053.JBvfvZPPCn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWoOxgAAoJEF2HCgfBJntG6MYQAMnF3c4NAdJwFXI1qfg6MwYh
BM9Q5YtGkRA7IGzw9HsmbwQncAa04t0J5Jn6A/GyOw5SGFl8y7jQMiO4vTmbr31D
YNnD4K5gnCO8pDw958gEB7tI3P6ywQ+mf8Qw3Hs6ZE6ZP7oYJ6kA1+jG3xnOblUw
jEaaKlaIRtYlKj/SRZFBzvu1Bs8S89B2pl4R3ILeRRYfXrxxaoS4kUnPabZnFwfv
M3TPPojBr4VJvWDFb+QZ8y9FvmqUAasOvi/mooNfGRnCJXwyL6tNZxvvqUwSidih
jpceJV1vxxZ+N39XJBdOycDYo8cm4HPsQPq4yCPoyV/5fACjecNwrZHFIS8CEXd+
s/Ddguku8GImGRYFwsxrxImnK9+EkdFzq3gUiFoHnqKlyb+EPaOVQW6VgFzvJ4bI
RBse6KygOQG2UOp7G7rtv5RSg9+9WnL0hFnfajnkrAfW8jQ8dF1P+NuN8UUGY8Ip
NdSC7WQ3awNRQzXfBF/S9UY/EXbMmhOBZ4she/w+dFG1g5QsckIdxRBgiUe8F/ro
gGiYK7DnX0Lpqu1poNnusvF0wC/zt7gpmpXCL0A9nNRLuGfUFdTgCA+yWgZInhl6
npb4vSBg2mENFhXw27frN95rAisqRqTs+nRXvIJ7C6v4y1wcLjf0XshgWxgbGq55
zyk4PctQ6f3tSXurI521
=0h9b
-----END PGP SIGNATURE-----

--nextPart8307053.JBvfvZPPCn--

