Return-Path: <Treasach@web.de>
MIME-Version: 1.0
Message-ID: <trinity-81c0c32c-d583-4093-bfed-f4207f7fa84a-1406191832784@3capp-webde-bs58>
From: Treasach@web.de
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Jul 2014 10:50:32 +0200
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] alfred - one gateway - multiple interfaces
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
Cc: max@rfc2324.org


Did you try to contact the author of this init-script/deb-file? Because th=
is Maximilian Wilhelm is not the maintainer of this package in Debian https=
://qa.debian.org/developer.php?login=3Dmax@rfc2324.org nor an alfred/batman=
 developer.

https://qa.debian.org/developer.php?login=3Dmax@rfc2324.org[https://qa.deb=
ian.org/developer.php?login=3Dmax@rfc2324.org]
http://git.open-mesh.org/alfred.git/search?s=3DMaximilian+Wilhelm;st=3Daut=
hor
http://git.open-mesh.org/batman-adv.git/search?s=3DMaximilian+Wilhelm;st=
=3Dauthor
http://git.open-mesh.org/batctl.git/search?s=3DMaximilian+Wilhelm;st=3Daut=
hor
=C2=A0

Gesendet:=C2=A0Mittwoch, 23. Juli 2014 um 21:23 Uhr
Von:=C2=A0"Tobias Hachmer" <tobias-MiV4+CnmVYKELgA04lAiVw@public.gmane.org=
>
An:=C2=A0b.a.t.m.a.n-ZwoEplunGu2X36UT3dwllkB+6BGkLq7r@public.gmane.org
Betreff:=C2=A0alfred - one gateway - multiple interfaces
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
500 http://apt.rfc2324.org/debian/[http://apt.rfc2324.org/debian/] wheezy/=
main amd64 Packages
100 /var/lib/dpkg/status

Guess what: We have the requirement to run one alfred instance for
each batman domain. What is the suggested way to achieve this? For
instance, I assume that this isn't intended by design because
/etc/default/alfred in conjunction with the init script aren't
multiple interface aware.

- From our POV the preferred solution for this would be to patch the
init script in order to support multiple interfaces by reading this
from /etc/default/alfred, like:

INTERFACES=3D"bridge_one bridge_two"
BATMANIFS=3D"bat_one bat_two"

Just to fork multiple separated processes.

Maybe this is solved elsewhere and we didn't get it, yet.

Please give us your thoughts and hopefully a solution to this issue.

Regards,
Tobias Hachmer
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/[http://ww=
w.enigmail.net/][http://www.enigmail.net/[http://www.enigmail.net/]]

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
=3DYiHt
-----END PGP SIGNATURE-----
=C2=A0
