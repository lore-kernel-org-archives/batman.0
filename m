Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Aug 2018 13:38:30 +0200
Message-ID: <2791173.mX5NbDZpiX@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7519786.uQctjuaDmX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Paper "Performance Evaluation of BATMAN-adv Wireless
 Mesh Network Routing Algorithms "
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: ligang.liu@mail.sim.ac.cn, liujp@mail.sim.ac.cn, qianhw@mail.sim.ac.cn, zhuj@mail.sim.ac.cn
Cc: b.a.t.m.a.n@lists.open-mesh.org, kekegai@smart-com.org

--nextPart7519786.uQctjuaDmX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Just saw your paper "Performance Evaluation of BATMAN-adv Wireless
Mesh Network Routing Algorithms" [1]. Some small questions:

* What is OpenWrt 1703? (you've referenced a batman-adv config tutorial here 
  and there is no such version as OpenWrt 1703)
* When did you want to contact the authors of the B.A.T.M.A.N. V 
  implementation in batman-adv about your findings?
* How did you solve the cfg80211 bug which returns uninitialized (random)
  data when asked for the expected throughput of a station? Maybe you remember 
  that the expected throughput is *the value* which B.A.T.M.A.N. V needs to 
  calculate routes.
* What batman-adv version was used?
* Did you use the openwrt-routing feed (which exact version) for
  batctl+batman-adv or how did you build it?
* Did you generate graphs for the chosen best next hop and how it changes
  over time in comparison to B.A.T.M.A.N. IV?

Kind regards,
	Sven

[1] https://ieeexplore.ieee.org/document/8421863/
--nextPart7519786.uQctjuaDmX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAltlkDYACgkQXYcKB8Em
e0Y+yhAA0BRoqdmg8hONf2zevAM6UnU7wna/F/II7NgRH9xcMHZsyy7ZrAWPw5Sg
yqD1AR412b3KxQO4J6QwNEvGq+jNJ79QiaCEvP/nyWcs7Jr2BL0J1fqAnl8oGiha
UCvLBX45tq6c+aZ6yQwtTOWc7iWFeTYpumV2HVziYuhXkw1jWgUlnBowZmlLSCbS
QqQwGp82Utx2ZdM4y8S/jVT3ustNFJerzKj20V8QxcVxFK5TCGILQZ5UemQ2Pjp0
ShargdsImemSIuYvPmRpNJbis7s6QqDVUIT4VGfdnipf3I3jJ//FKQ3HlEAG1zeJ
77YkVjRXzP1rkZnB1CZgq6Nqtf1JENHh9GeY3bxWHJ7biO0Vz8Ubq/IuKjhBIT2V
IgSC/cGrV9gpP8jD1MnnUI0vHSGYvdUv+Bmh1dkoChZ7CuewjesGRi17q7SzUk/a
1iTaqyuiq+v3tyIGukYyyIbhOD8BWVex8ydOvuiF8avbGH8XSJnMJnmfcNvTyAyg
9PcAVAU01+6Ue40fSgr+RYcZpglTeSeAekJPRiQwIUxJh4tlO/AobNmcfSOR1XUT
BWgwFeATy3njwNHY9rA6kUiy813xP+qGIMJBEgurP+scUSgrHTSTXGDvn0vxTr1E
hPQ5AIeFvFpA5IUoALEyI0jdVMZVQHx2m/Coq6h2MFrxG1NlCAE=
=NBjO
-----END PGP SIGNATURE-----

--nextPart7519786.uQctjuaDmX--



