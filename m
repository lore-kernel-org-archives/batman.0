Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Jun 2016 16:36:23 +0800
Message-ID: <5728038.Z0THFbVVB6@voltaire>
In-Reply-To: <1465796492-5039-1-git-send-email-sven@narfation.org>
References: <1465796492-5039-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7391059.x9q87YcANZ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 1/4] Revert "batman-adv: Fix hardif
	remove/add race"
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

--nextPart7391059.x9q87YcANZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 13, 2016 07:41:29 Sven Eckelmann wrote:
> The description given in the commit is misleading and is at least not true
> for sysfs. The sysfs file structure should instead be deleted immediately on
> rtnl notifications and be underlying objects should be removed later when
> all kobject_put were done for the object.
> 
> This reverts commit 6b0485c758be ("batman-adv: Fix hardif remove/add race")

Applied in revision b58db7b.

@Andrew: Sven's patchset aims to fix the problem you encountered in a better 
way while also addressing other issues. Can you give it a try in your 
environment to confirm it fixes your problem too ?

Thanks,
Marek

--nextPart7391059.x9q87YcANZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXZ6sIAAoJEFNVTo/uthzAx7QH/Rl/9G7F6+qeiRzFiuvlQfI8
x98nn41oKkuE6QBUncKcUW9eBYhSgXOdmjivLfYoGWaHN0qcqtPKlW1sAZEBMqns
lKlLGRQECf1s7mbHi7hLQ5R5W+ZMeRrktuFm97zsrZxzEQwwCm5wchdhb7mUP8Ed
Mmj/2M/oDU7o8oJvckg8xO2TSZ9+RlgGE1wjrWIg3ngthWI1UMD5mkIDliMItFRI
jrEq2Bty3emeovWBT5l3uE8+GeMNZOXTysQi2ZjtuAI7hVp8joKm7bR7MjcbVp/B
sL5Un7XKybnBs+iPaE1zhbagr7gL+NiVj4sn9iI88QRnkrMK3dEvSJUD0p3/kV4=
=Gv/V
-----END PGP SIGNATURE-----

--nextPart7391059.x9q87YcANZ--

