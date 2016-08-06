Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 06 Aug 2016 10:27:08 +0200
Message-ID: <2277921.TikbSnUKEq@sven-edge>
In-Reply-To: <20160806044244.GA13676@otheros>
References: <1468793741-4606-1-git-send-email-sven@narfation.org>
 <20160806044244.GA13676@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1561222.Kksk2DtxPJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Don't allow zero and
	multicast sender address
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

--nextPart1561222.Kksk2DtxPJ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 6. August 2016 06:42:44 CEST Linus L=FCssing wrote:
> On Mon, Jul 18, 2016 at 12:15:40AM +0200, Sven Eckelmann wrote:
> > The routing checks are validating the sender mac address. They reject e=
very
> > sender mac address which is a broadcast. But they also have to reject
> > zero-mac address and multicast mac addresses.
>=20
> Initially I was a little shocked because there are legitimate
> cases for zero-source MAC addresesses. But then I saw in the code
> that you are talking about source MAC address of the outter
> batman-adv frame :). Maybe that could be clarified in the commit
> message?

Ah yes, you are right. This should be described better in the commit
message.

> For batadv_check_management_packet(), agreed, I guess much of the
> protocol does rely on valid source addresses.

Yes, think so too.

> For data packets, I'm not quite sure, though. Could be interesting
> to not restrict that now to still allow enhancements regarding
> privacy, I think. And zero-source MAC addresses shouldn't harm
> anything in the case of data packets, should they?

So you would prefer here that is_broadcast_ether_addr is replaced
for bcast and ucast packets with is_multicast_ether_addr? Same for
patch 2, right?

Kind regards,
	Sven
--nextPart1561222.Kksk2DtxPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXpZ9cAAoJEF2HCgfBJntGk28P/AinhbvG/T69/G++z4V9Gmph
7h+X48lqX7Ps+dG2jjtuydooraXCQNMkG453h7Ph1j/prkB9b5OjK0hL87QZEhlv
jYyzlx2BWJ3gSoB1gO0hcOp3egrJWVVixxJkcYZNTivpbEeHapRywDKds1gPDOwc
BcxOjWnoflE68TbmB0RG2lJCPVwKwV79q66pjcbpFmh2ll6o6pOagSe0CXxWTjnM
qYRRwZycK6H5kngZ8nXWshUb7rs50LWJz6OPjDEKcF8y5kkSjCP6vGcf6p2+HDkx
RyfUolxayxjwbzadVzicJu8aTnbG9oC92VPjI+7w1sEdUFlDm7NSwP6346cYURgW
+KyzJRPvQk/MPVfqYLV2hkvPIGO3NRDnYzW04XrH/QBXrEXr1sYzTSfSOemjqrm7
N3jLefNomvXg6SawaVSua2AbeKl9D6QyQJRtoAbl993Ap7RKsEtMKECPaAy6ZFCM
PVhA4G2vWO2Zf82QL3AQGNvuds4JXxTELomSu//uFPTf20OAoG8cnwJ1qlMsUyRD
Cs7xhULe65CHZ/LhlgMybJjgED0dvzMYM+qvA2PdSBfKrnHDUpDEiJblAvUeMilF
RcMGoDeuzpDdL3aJmiRSPCe+aCJ90yCMU5nfXRrIYeYImyK3bmcS8A0QqmvOBXGJ
V45ZiOWBBhfeB0iXIOvD
=+L40
-----END PGP SIGNATURE-----

--nextPart1561222.Kksk2DtxPJ--

