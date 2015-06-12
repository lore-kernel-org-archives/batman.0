Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 12 Jun 2015 10:53:53 +0800
Message-ID: <9335609.3RCpKXFmTj@voltaire>
In-Reply-To: <1434033854.25497.3.camel@nord-west.org>
References: <1434025163.1056.73.camel@nord-west.org>
 <1912783.F1ndSkPlnl@voltaire> <1434033854.25497.3.camel@nord-west.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2770692.cn5kTRP6b0";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Mesh hickups with 2014.3
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
Cc: freifunk-ol-dev <freifunk-ol-dev@lists.nord-west.net>


--nextPart2770692.cn5kTRP6b0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 11, 2015 16:44:14 Bjoern Franke wrote:
> Thanks for your reply. Multicast optimizations are disabled, but we ha
> ve multicast related errors in the logs:
> br-mesh: Multicast hash table chain limit reached: bat0br-mesh: Cannot
> rehash multicast hash table, disabling snooping: bat0, 201, -22

That message is not coming from batman-adv but the bridge code itself. To me 
it looks like the bridge code disables multicast once the hash table limit is 
reached. Use the search engine of your choice to get better info. Sounds 
definitely related to your issue.

Cheers,
Marek

--nextPart2770692.cn5kTRP6b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVeknBAAoJEFNVTo/uthzAEqAIAMBXzgzxj1GrS9nTKGDHMnBb
GUs4gBPxtxedMZxiWfo0Eay0XxXXMnl2os4JITXwx0LTiAkIsunc/L2EPY5NMjWJ
lffHE3nciqrXy160pTAuv49fxmDX+yQQCN4fWNc32bDJ+LH4j0sn9uMJffSZBopN
91E9+6Ok4P9ix/zbMzEuFGNplEFMykCL3q3eHhiOGhZb1F8hY7luoja46D1ivUlk
0lNXoEUR4BAt2s/bJp5X+EDXRlvLLywkRwP9Qaz+HiR/h3HasSCTha7h88FeGf1a
kAi44kE6iRjmA2cJiUAOFJFOuk0rbBd8bsmPrjmQA0hqvNkUs2PO2f7pAGLzZGs=
=RI9U
-----END PGP SIGNATURE-----

--nextPart2770692.cn5kTRP6b0--

