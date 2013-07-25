Return-Path: <jh@sotun.de>
Message-ID: <51F194D6.3000701@sotun.de>
Date: Thu, 25 Jul 2013 23:12:54 +0200
From: Jan Huwald <jh@sotun.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2WWVAFIBTVMNVXOOWKVIO"
Subject: [B.A.T.M.A.N.] Mangling broadcast packets
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WWVAFIBTVMNVXOOWKVIO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I am currently redesigning hbbp and p2ptbl[1,2]. p2ptbl is a distributed
key-value database build on top of HBBP link-local UDP broadcasts. Both
are used in some Freifunk communities and elsewhere.

To reduce the bandwidth demand of the employed gossip protocol I would
like to use something that behaves like a link-local broadcast packet in
a batman-adv mesh every respect - except that any mesh node on it's
route may decide to drop it or change it's UDP data.

Right now only approaches that are ugly or don't work come to my mind.

Ugly:
* using NFQUEUE on all enslaved interfaces to mangle packets before
  they are seen by batman; requires out-of-kernel parsing of batman-adv
  packets and watching enslaved interfaces
* add a custom broadcast TVLV; requires kernel code and either bloats
  OGMs are requires non-OGM broadcast TVLV packets

Don't work:
* using NFQUEUE on bcast payload (without batman header); does not work
  because they are not exposed to the iptables
* send link-local UDP on all enslaved interfaces; requires to
  reimplement all the loop-avoidance / routing / resending logic that
  already exists in batman-adv

If you see a smarter way or a reason why manipulating broadcast packets
is utter nonsene: please let me know.

With best regards,
Jan Huwald

[1] http://code.sotun.de/git/hbbp/
[2] http://code.sotun.de/git/wrt/p2ptbl/


------enig2WWVAFIBTVMNVXOOWKVIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR8ZTWAAoJEApFouY8nhT6P4UP/jADsMtjhOU6oj+2m+mGs+N5
qItcg8YBYr84ZrWKFphGmPLFUFor8QLMrVIdtPET9ezqh0k22kVhTUG6hp6skICf
fUaC0wGljYPwnBFKMQeNn33G5KJk+zVvavd9ogF2FojP0eZ1a/wcLaALp4PlybB8
GifJUmBV6Pkpq+vwkVhnPI289ZQ3YGLrc/MwFWnQrjcUXJm08mqUyQupWGo6dSyZ
CgalMJTXFI1qXY/QoiinZMsFysc0A71H/8Na01tnXPlkU+HCxFUJIekU0YyVlw2o
3MMeJqewjbsgzF5gL1blz3s41Rjj1LiFTYwz+T+wqCT6tJtBsBtrmLuORbCD2Yp3
Z04of61b41+PNm4W4LM61F3la2vFhgTk1XSXAiWdREIkvXRdY12eNditrh99V57E
t+QNZoLGBAUsrNbWOT1zwe2liYQFw6CJKadmeBiCf3ptiqi7bgiOjNa9Dnwe2vUZ
iMn9XBXaMHd8olhqWlD7KjT1j5fSlJNH0u3p4Tb6wduvkXGa1vr9mNgpy+MQVNMR
czNhpTXli3znauP9qeJSNpkt9qQ6+EF6BivUyzpk+g9l3Bcvpfbl4heobvfPwr3+
yO3AHkBvzr6JiaRxZy7fDUlhwP3eyMNsuk55Youx1UcHPR0Ndxc/cJWePM7BTqkZ
QRXRmS1YA8dxZzrb9wvR
=VFfx
-----END PGP SIGNATURE-----

------enig2WWVAFIBTVMNVXOOWKVIO--
