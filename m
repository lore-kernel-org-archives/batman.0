Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 07 May 2016 18:28:20 +0200
Message-ID: <1884294.h0rzVsQuVd@sven-edge>
In-Reply-To: <572E1219.7070005@wifibot.com>
References: <572DF6E3.3030901@wifibot.com> <112511932.Eq5c9Kmyda@sven-edge>
 <572E1219.7070005@wifibot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5206996.xkpHHJt0ro";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: contact <contact@wifibot.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart5206996.xkpHHJt0ro
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 07 May 2016 18:04:41 contact wrote:
> Thank you, it is working and it is more clear for me.
> 
> I have switched to V but when I switch on other V nodes, my first node
> reset or freeze, probably a kernel panic. Need to plug a rs232 to be
> able to see what could be the problem.
> I will switch back to IV.

Which version did you build?

https://github.com/openwrt-routing/packages/commit/8dec3dc38b514ed8f1212b51f9f6039af3fb0e04

or 

https://github.com/openwrt-routing/packages/commit/a3cd8a1729779b8a39336a863ba7f97481e81f5c

or a different version/feed? Please make sure that you don't use a legacy feed
together with batman-adv v2016.1 and B.A.T.M.A.N. V. It can only be used when
build directly against the used mac80211 package which is only done in the two
openwrt feeds linked here (and in a devel feed [1] which is building always
against the current master).

Kind regards,
	Sven

[1] https://git.open-mesh.org/openwrt-feed-devel.git

--nextPart5206996.xkpHHJt0ro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLhekAAoJEF2HCgfBJntGhGYQAJLgsYqRrm0wTGKwnox4/vnQ
dUbic2Eu+o3lC7Qr3OsxFB3D7ZsZ6mP8wdBCwSPCWcz7SuPHp9uds8/0Tgt3cvWj
Tv1749NWPi7YRyF+1gqO7C4/Dm8uwDYGJpib7ffu6BEmInFh2mM8Nm3Ty3BoCrFI
EgVrky/OFxVb7CA41V3dFtnK/4pT0Ts50YbZFhX8TZ+tCjnmclRGzhAdOHECFkr+
Ec4VNDDiHtNdhj3pB1yjh4kvzb8Ho2EU9M4aNLaOQ0IXrYC2gtcbzK0WTbiTW1/5
71Lg22OxpMUWaN2rO/0FaN9gk8fhMzZnNVHxwz9dpkeTDfO1PRSvxZZyNc6p+Oae
bnwheLtRmo9P5Cjuia/OceWMBU/zOqLeIuP+xY7Ln8JwGUMDDpujlXXw7lN7/Zy+
znVW54xWyF1c98kuEstO5YlSxZqPqHUwPyDya80gPUd8V0IKhWw/UDaUWZHKb2tJ
yeyxpJ8ugOyNVKOs4YNhQgPO4i6le4eImNcucEaafrVjlG1b/fflzwcpwa8W8G8t
kRqXfCSFVRtim2GYkI2lRwbZM9m2sL07xOaSqkdSPcMFTU4ZvfZiSl4BM7o1QK0E
qE5lzyGIYlFSa6gaK9JzWGr4jHZb4g0xEGPAO6qyrp2IIMEt9czvrDm0ntzfAXpI
OIUg0mOBKuyebPPhoi5Z
=cuvI
-----END PGP SIGNATURE-----

--nextPart5206996.xkpHHJt0ro--

