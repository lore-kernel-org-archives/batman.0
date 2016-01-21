Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Jan 2016 15:26:41 +0100
Message-ID: <132128022.hJazYISVSs@bentobox>
In-Reply-To: <1664897.xQoZSmslHn@bentobox>
References: <8047297.0qIFjkW2bL@voltaire> <56A0E335.8040207@openwrt.org>
 <1664897.xQoZSmslHn@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3114162.dhOieuYHx8";
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
To: Felix Fietkau <nbd@openwrt.org>
Cc: openwrt-devel@lists.openwrt.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart3114162.dhOieuYHx8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 21 January 2016 15:03:10 Sven Eckelmann wrote:
> On Thursday 21 January 2016 14:55:01 Felix Fietkau wrote:
> > > @Felix, would it be ok for you when I propose a
> > > "*-sync-cfg80211-station_info.patch" for the 3.18 generic kernel 
patches?
> > > Or do you have a good idea how to force the openwrt-routing batman-adv 
package
> > > against the cfg80211.h of compat-wireless?
> > The openwrt mac80211 package exports its headers to
> > $(STAGING_DIR)/usr/include/mac80211
> > 
> > You could just make the batman-adv package use those includes.
> 
> Thanks, missed that. I will prepare a pull request for openwrt-routing.

Hm, didn't work out so well. It basically explodes right away because 
possible_net_t, possible_read_pnet, possible_write_pnet is not defined on 
v3.18 when not using the mac80211 backporting headers. And when usign the 
backporting headers then it will explode because it conflicts with batman-
adv's own backporting stuff. And without the batman-adv's backporting headers 
it will also not compile due to missing backporting hacks.

Kind regards,
	Sven
--nextPart3114162.dhOieuYHx8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWoOqhAAoJEF2HCgfBJntG2YMP/RkNm3zS2tqgxnNekY0jRW+x
mTml6isJdcpHz9juT4zh3xRs7ZJTV04cvJNyR2jCVqAVafeJlZS3VTYcO2dAc455
1b1A2sV0E4eEuAzI0ri9DWBF21344nrTk45UR0WIkdjwg0tigBi9aKg95FG95q1s
kI03KXNefRrkeTfilHpimuhgix5UFi7IEuPpbuTa2MaqLI5ahdwQ+PdOzbjgOiC0
TN3Kzu70PlU5umUssIdt8VH0a8uQCm5oi4EkwNorIc1H2en0X9BDTcEcn38pQDIt
LgjspFNlmwtr+oxcjlDb7pqjrKftuEId66mhhSoBFgd829AnTamx0P+Y4s5ljZ8O
jr5MCP2pPKGhzragZ6zklbVTSdHI1T3oFP6NawZiPrPieRkNMI6lGQvG0LhRoNZ5
iZ5GsAKjENFQZd5GJfHl5fzB4TTRA6f0OvgRUDbHIoyT9VtqdubC2sL9NaOXJszF
V/wNchoEJNhiui4kDKoeGrDKGkttm0qjZuL8UE2Iwbpoby6EmPTCIlHYOv6tW0Dd
Wgt/JdEOhIsWxRPqCvRfZtTqgb/eJQgnjcz2Tze8XZcrYgCh/TWjYysC0DOJDo47
iKSzHGaGpni16kqi8hXa5+Cp7LtkMSNtpzEtSde9KPkKPxYwJIB052s2n/xL5XoF
Muq+5zzMgBYAXf7+jmzl
=ykwU
-----END PGP SIGNATURE-----

--nextPart3114162.dhOieuYHx8--

