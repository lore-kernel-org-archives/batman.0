Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 30 Dec 2015 20:38:42 +0800
Message-ID: <2457136.iz2mu7y0Mc@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5076266.HHdsYfbvHg";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] B.A.T.M.A.N. V leaves the nest
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart5076266.HHdsYfbvHg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

for those following the mailing list and other events around the B.A.T.M.A.N. 
team the term 'B.A.T.M.A.N. V' probably sounds all too familiar. It has been 
more than 5 years since the first ideas for improving the routing protocol 
were exchanged. In the following years we had several GSoC projects dedicated 
to pull this topic forward, countless hack & brainstorming sessions (including 
sleepless nights at each battlemesh). Turns out, replacing a mature protocol 
like B.A.T.M.A.N. IV takes more effort than you might think.

Another hurdle we kept running into was the missing separation between routing 
logic and feature code preventing any developer and/or tester to quickly 
switch from one protocol to the other. Now we have finally completed hiding 
all routing logic behind an internal API allowing to change the routing 
protocol while still benefiting from all the layer2 features.

With this mail the B.A.T.M.A.N. team announces the availability of the latest 
protocol revision: B.A.T.M.A.N. V. Major features are its throughput based 
path metric and packet type separation. For a high level overview about the 
differences to B.A.T.M.A.N. IV feel invited to continue reading[1]. Technical 
protocol specs also are available [2][3].

The code has already undergone stability and performance testing[4], thus is 
considered ready for a wider audience testing. In the coming weeks said 
patches will be included in the main source tree and sent upstream to the 
kernel maintainers. Comments and feedback are welcome!

Next steps involve finishing the throughout meter[5] to enrich B.A.T.M.A.N. V 
with an automatic link throughput detection when other mechanisms fail.


Happy routing,
The B.A.T.M.A.N. team


[1] https://www.open-mesh.org/projects/batman-adv/wiki/BATMAN_V
[2] https://www.open-mesh.org/projects/batman-adv/wiki/ELP
[3] https://www.open-mesh.org/projects/batman-adv/wiki/Ogmv2
[4] https://www.open-mesh.org/projects/batman-adv/wiki/BATMAN_V_Tests
[5] https://www.open-mesh.org/projects/open-mesh/wiki/2012-10-06-GSoC-2012-Edo-Monticellis-Final-Report

--nextPart5076266.HHdsYfbvHg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWg9BSAAoJEFNVTo/uthzAnpkIAImZBe3h2vkDMVDZKfJDRfsI
ZHzdyvW8kwphnXurGMZeEUAfXYfkAGlpHyYhFX+oKzVpf1rFzWcHuhBMUMmaVdxM
yStmekXOAz0lVERioOHTJAPhhvEmRHHg/yviQUA89jBxv08Invd4BMs1/HWv58rf
nuoqSCnV2r6fPeUqG6Sv8y/XeqdOoHA/DYQI5M/a2kT7y7/sCy2hYfJlxvbdSp/3
TNG9dYHQr2nfB/i7h1fl2kJ7G7Anbj8DuMGkmeENKP37J5h2Apa7O+PEv5misiS+
mgZc3sNRLP0FK5pWr71Mfro2gBx9y+6Y3ei7stJJetTviXdnQLKelSe+xYk07Rk=
=q2ub
-----END PGP SIGNATURE-----

--nextPart5076266.HHdsYfbvHg--

