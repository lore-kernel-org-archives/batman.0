Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 19 May 2010 21:41:22 +0200
References: <201005171951.21349.sven.eckelmann@gmx.de>
In-Reply-To: <201005171951.21349.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart36415295.kFBKSzvkrr";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005192141.32752.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Converting to sysfs - maint versions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart36415295.kFBKSzvkrr
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sven Eckelmann wrote:
> The patches are for trunk, but I would provide backported versions when the
> patches are discussed and we could solve the problem in a sane way.

I've backported following patches to a version which can be applied using
git-am on top of the maint branch of batctl and batman-adv:

 * [PATCHv1 1/4] batman-adv: Move device for icmp injection to debugfs
 * [PATCHv1 2/4] batctl: Use socket in debugfs instead of batman-adv device
 * [PATCHv3 3/4] batman-adv: Move tables from sysfs to debugfs
 * [PATCHv1 4/4] batctl: Get tables from debugfs instead of sysfs

(So nearly everything in version v1 - only patch 3/4 in v3).

Best regards,
	Sven

--nextPart36415295.kFBKSzvkrr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9D7iAAoJEF2HCgfBJntGxYwP/RWbi6c1EAZs93Qr/jLzIV/P
n7kyAVEoMZ3u10HfRd6wmeP8CKC04X9n/8mXU799jE5jQ554lIG4QdNJo54p2Mw3
GAbyRqIYbypXfGd0KcGHuwQHLKl8xEQqXBwwemo0GyKY7JQDe/h/vWoVZwrdcm38
7q0O3rChMNKL7h4XIzPSQ/xVaU4q2g0mKFstBRDJXx/VmQbT0yuYLvIjiKoU/FLx
At2O3OSOxm28RxE18gp9Ly6gTddm7b2P1YrXsEl8gX7jddXd8bqnErT1W5IJjOEi
AVWxRWcslkhhJIFBSVKHxR1LICZ3klECYb/TgwhSHYmilsrYhpzhwpjAQpBdQUQu
MnsV9ZmFQRw3NRWfnJ4bnjDllaRhaoUjiJiLVkLLSHq9ENkpzor9822acg+EM3dd
9/slaPZ9aLdElrOg1mlavk06V0QMoHClEhNs+sqeOdLbKcCnauWzw3L/yf9ZQRew
wVcGIc0I2SJnBa9H1k5ZclEVmIyjl4RmbgzXNV3/fDPp5HzibYciiVvU1aFLmGIb
xt7UkBAjVGqbci9rMdDzvj8C2MnMV5/59hMakmHixdZVxglHV3FfboKHF90EgJrT
d3gNbxJS/skySgajeFdHeDJfSl61OItgVJ3SthBbJlHfKwp4nKFBkk43d4fnNHCv
0MSdqDgSekVmPncQWGMG
=48jy
-----END PGP SIGNATURE-----

--nextPart36415295.kFBKSzvkrr--
