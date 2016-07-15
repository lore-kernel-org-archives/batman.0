Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Jul 2016 17:36:38 +0200
Message-ID: <2523940.IGx5okD260@bentobox>
In-Reply-To: <6738075.DuRfZKd46c@voltaire>
References: <1467236695-6180-1-git-send-email-sven@narfation.org>
 <6738075.DuRfZKd46c@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart66759315.0Y8RNbGhQE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Place kref_get near use
	of reference
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart66759315.0Y8RNbGhQE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 15. Juli 2016 16:38:09 CEST Marek Lindner wrote:
> On Wednesday, June 29, 2016 23:44:54 Sven Eckelmann wrote:
> >  net/batman-adv/bat_iv_ogm.c            | 7 ++++---
> >  net/batman-adv/bat_v_ogm.c             | 5 ++---
> >  net/batman-adv/bridge_loop_avoidance.c | 9 ++++-----
> >  net/batman-adv/distributed-arp-table.c | 2 +-
> >  net/batman-adv/gateway_client.c        | 8 ++++++--
> >  net/batman-adv/hard-interface.c        | 6 ++----
> >  net/batman-adv/network-coding.c        | 9 ++++-----
> >  net/batman-adv/originator.c            | 8 ++++----
> >  net/batman-adv/soft-interface.c        | 4 ++++
> >  net/batman-adv/translation-table.c     | 6 +++---
> >  net/batman-adv/tvlv.c                  | 9 +++++++++
> >  11 files changed, 43 insertions(+), 30 deletions(-)
> 
> Could you please split this patch into smaller changes ? Mostly (not always) 
> along files ?

I went through the change and it didn't made a lot of sense to split it per 
file for some of the changes. So I split based on the type.

Kind regards,
	Sven
--nextPart66759315.0Y8RNbGhQE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXiQMGAAoJEF2HCgfBJntGe68QANL2ouDgaQ0S8KNPQB+sysO8
+Lh9FgOmITIMxwZRRGFzN1ZqNICGZHABo8Xevemffjz4huoocyVjUWB5/KRpEcR1
M1aRuYB8XhaTC3q75B2efjGqsZafcj1v4xh6550bZ2OJSWeGElfZgPiVIl8aoAT2
ZGjUUKwCfcpvQ+STdmb1hxUmx0GfxRh8o9O8GbhJmKuBovN18X4powDDll7jWNk6
1e1rwc3EiX9hw0DQ1W1peQI2oRDJLuA37CKnybrjM02YqTY+Am68T4sooSSkYdEB
mqSUH85dq8/M5jsDfJswj6xclITjcmXlV3oYX6DTdklMSf/+xaGau02p7jRcmHQK
bo/21CdHqBjyJj7BjXmTp14n720ZjsJNBP3vb1gounlukWRUuc2i3QB5lYb+p2CJ
EZV7U8Cgo/QQkqNnDsM7//NvA7xytTuphKHNPD1yJNPkFaB/Wh5vce2pIvrZjav7
C9yIaWPUYXBmfKBDPfZhKKvHyus5kH5CXxO395JqsbsSglOMQZ27AK7K9ORDozV9
M4L5zeU2PxtQtWpILS3K4umZ4JJ57+ibBo3gVGFOUFsG7n2NLuForCT0zl4lv3zP
XZBKC2WRaabGpaGymKLmAjoEWEw910W/3oJN2Rjdp+tQ+rT7ZpxejXIP/PbrdEIw
cjBkfvg6YiIuPUfrpgv3
=Nglf
-----END PGP SIGNATURE-----

--nextPart66759315.0Y8RNbGhQE--

