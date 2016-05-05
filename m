Return-Path: <gio@eigenlab.org>
From: Gio <gio@eigenlab.org>
Date: Thu, 05 May 2016 19:10:25 +0200
Message-ID: <1878039.YFyZzFfin1@riseup.net>
In-Reply-To: <2921513.lgCmTUKKT7@voltaire>
References: <2083541.Hg032Jxeer@riseup.net>
 <20160505153447.GQ11201@prodigo.lan> <2921513.lgCmTUKKT7@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1559062.TAllMNFcYA";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Batman-adv doesn't compile in openwrt after last
	commit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

--nextPart1559062.TAllMNFcYA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 May 2016 00:09:31 Marek Lindner wrote:
> On Thursday, May 05, 2016 23:34:47 Antonio Quartulli wrote:
> > After such commit Marek introduced a dependency to another openwrt packet,
> > therefore you need to type make in the openwrt root in order to properly
> > rebuild what's required now.
> 
> The batman-adv package only had a partial dependency on cfg80211 on which it
> relies due to the supplied kernel backports. I fixed it.

It works now!
Thanks for fixing it!
Gio

> Thanks for reporting!
> Marek

--nextPart1559062.TAllMNFcYA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXK36IAAoJEArVJPi8Kg4LFOoP/2baBaZ1gaB6jVKWjJnEAk6e
9SpiDbCxkRnzYqP/wJiAEEppdomlK43WOF3lwmIqdwDVxaC6ZkOjpGbsEy7f56/n
PMDfhwFtlZFNhpnfZZzPslYtFHKj59nUBXH6ppbjJ/+PwKmwhAXe/MAvSUu4hQwT
z4QOMMvlR/t25ffYI5/nZ0F3iZlKO68mWT7F272D+gpuGCTQNPGYWK9J6gy7Patk
hFqgUBn9NODizjyML4UHEXdHjr/4ZYiYckAcs6J3wP3Z214TBQ6q3qcx2bWXNPRE
PezapNAfDl1AVM9c93ioDUmZ8U8iAk+tR9abqkCwb1L2p9SegU5DgrbpuX15hre5
t30IvjPmhaFO2G/gbo7E4wGOcE9DTLCRwn7GV0koPNiIlxDI/+12ueKiS/5Mwmyv
m7GWTCnxUS6JEfc7Z/ZWfzSHXjOyOsfYgFACzHC7wSJM/Zsi1qslc2deegNb2FAe
XmC36xYA9dDKM5ox/d35S4eVK8pwzYVQEX1sqm9uOLx4VGuwOtBJZejFq5SlMqgW
2Y2wj7izv7Kq6xjWXmkWTXIQUzb19q6eZ9bXj5BH2n1OIpzbOhkNJQ5foJUqv8Ch
vMtS5C2U8LrumHuAJIoemm5/0pV2wmYxTjROQm4Ihzi8J2Xq0c54PZEF73h3napO
rGP8qrxqFWrXR0/j8fbJ
=rock
-----END PGP SIGNATURE-----

--nextPart1559062.TAllMNFcYA--

