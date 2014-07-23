Return-Path: <tobias@hachmer.de>
Message-ID: <53D00BAF.9070506@hachmer.de>
Date: Wed, 23 Jul 2014 21:23:27 +0200
From: Tobias Hachmer <tobias@hachmer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] alfred - one gateway - multiple interfaces
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello list,

running here 3 gateways serving two communities. Nearly everything is
duplicated/separated logically: fastd, bridges, routing tables, batman
domains, etc.

Operating System is currently Ubuntu 14.04.

alfred:
  Installed: 2014.1.0-1
  Candidate: 2014.1.0-1
  Version table:
 *** 2014.1.0-1 0
        500 http://apt.rfc2324.org/debian/ wheezy/main amd64 Packages
        100 /var/lib/dpkg/status

Guess what: We have the requirement to run one alfred instance for
each batman domain. What is the suggested way to achieve this? For
instance, I assume that this isn't intended by design because
/etc/default/alfred in conjunction with the init script aren't
multiple interface aware.

- From our POV the preferred solution for this would be to patch the
init script in order to support multiple interfaces by reading this
from /etc/default/alfred, like:

INTERFACES="bridge_one bridge_two"
BATMANIFS="bat_one bat_two"

Just to fork multiple separated processes.

Maybe this is solved elsewhere and we didn't get it, yet.

Please give us your thoughts and hopefully a solution to this issue.

Regards,
Tobias Hachmer
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCgAGBQJT0AuvAAoJEHXGlTiIv2V4QPUP/13h9qrMX79NMUBbIDnLGt41
b1tViUzs1v8zGeYfshgER4cTNk1j7B1iikjCchojxwhGdZpXh5CuWaTzJnbSVBjA
5SxSKsRdhVetp3EBErhezhv4jW1E7QlzjIQ9BW/kBV7bxyMxvaYhn6sfTlviCH2h
WTYNxtU0ACxVJ63h8c720qneTkiS8O+SGLUHSxy7v8BuCRRTJtiMBYJf3zv7jJ2D
0Zskla7ASW9leWkMgescjcYL4c2m3N+BR1m01tML5C3En49NVddAEawwcoU/RTmR
WH8NdRTG/SExwZqWGiya+wIvORsAqMZTmgjAqoAJsX5MbK9vzuOqQQv0VVxCerr/
r+l9mtOGluzLr5hMB4/1rpvAdd1VH5xlqtu9UArTJWANFStMQCr70g/jMknghkhj
aUjo8Qg6hunP6y7npWFQmv/TR6fEF9BNETHIeGDVvUh5SvwtEIzg6PjbEU3poRKK
h64fRdqdSe0UEuiC6fiaMWE+ryke3Mf2lPTJUsjrnOerwS4QCctL0MHsuuEtmJlv
OVlfRWWAWJHcf9/oykGIpwmxgTbeLqoAn9fOZVab4o3yHkeELJlTHX3pK7F7jxzw
1Y1yk8fxxE5cx/7BHkQsDOubzZyrr5gt3uh66YbtYuwO5Envh7GxhzLBvzQJn+MD
QjGkA6b7zn4g/+g5jnO2
=YiHt
-----END PGP SIGNATURE-----
