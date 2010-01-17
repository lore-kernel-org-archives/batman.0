Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 17 Jan 2010 01:35:32 +0100
References: <EACB115D0487C4459885C4B54EE8D9CF05D74AAB@USDALSMBS02.ad3.ad.alcatel.com>
	<201001170040.31071.sven.eckelmann@gmx.de>
	<EACB115D0487C4459885C4B54EE8D9CF05D74AAD@USDALSMBS02.ad3.ad.alcatel.com>
In-Reply-To: <EACB115D0487C4459885C4B54EE8D9CF05D74AAD@USDALSMBS02.ad3.ad.alcatel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1807671.p7Z3pZXqny";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001170135.36477.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Security on adhoc network
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
Cc: LAMBA Jaideep <Jaideep.Lamba@alcatel-lucent.com>

--nextPart1807671.p7Z3pZXqny
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

LAMBA Jaideep wrote:
> I tried WPA_NONE and CCMP with wpa_supplicant on both the sides with
> preshared keys. By doing this you are right nobody can see the data and
> I get encryption and authentication. But here comes a twist.
> Lets say I power off one node completely after initial secure session.
> When he comes up wpa_supplicant starts off with 0 as sequence number. On
> the other node sequence number might be greater (or way greater) which
> causes other node to believe that he is experiencing a MIC_FAILURE
> attack.

It is a bit late here, so I am maybe a little bit off topic. I guess you me=
an=20
the problem you asked at
 http://lists.shmoo.com/pipermail/hostap/2009-December/020741.html

As far as I know it can be fixed by disabling the check just for ahdemo/adh=
oc=20
in madwifi.

So try to replace

if (pn && pn <=3D k->wk_keyrsc[tid]) {

with something like

if ((pn <=3D k->wk_keyrsc[tid]) && (vap->iv_opmode !=3D IEEE80211_M_IBSS) &=
&=20
(vap->iv_opmode !=3D IEEE80211_M_AHDEMO) {

and try again. As far as I know WPA_NONE has nothing like a real session (n=
o=20
session keys and so on), but I could be wrong right now (don't have the inn=
er=20
workings of WPA_NONE in my head right now).

But yes, it is right that WPA_NONE is a more or less undocumented hack whic=
h=20
is far away from being perfect and gives long sleepless nights, but is exac=
tly=20
what you can expect from adhoc encryption at that layer.

Best regards,
	Sven


PS: Is there any research done by Alcatel-Lucent in the topic mesh networks?

--nextPart1807671.p7Z3pZXqny
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLUltUAAoJEF2HCgfBJntG1YsQAL5qN7jh7+uiGCqKr6olxqIW
bdFEik0XxTX3aFPeqv6Hb654RYUtZ5P6ojaQj48RCjNeHy26S73qDbYnDjbBdEXB
Wda2NAML+udCGY3cBcy1qbo2r0u9dDUDIU63FqEX3DCF3TykR9oGPPbywdUAn4i3
TazGcL8tK0pBLEROb4Bn7x5xUp8z/zLV7d0GTuHb7rblSSGAZUe6jPSoU/Bwaysa
U1FubqqNm/zZtTZRJNG1Fh89fnV4KbbOn8VLRrOj1li8jsASC3O+O3s+7mmFvyCc
y0kqF0vw1nkcGQjNgUjD7cMW/7HsbuEG/gx4w/3VL20tLozstxAskpmXbny5NXVh
IOxSobKjfDRkKxAd2Y1xjEP2sej99e65ChZK3z2jU91WeGdwxIyWOPLJL8abtmDk
+r+jshkJIEvIWPefjfeU7L5hX/RUgEzWuWasurLW9LzY04XlLd8Ts15del2ftHLD
gmSj/J8MqKb/pq1ceI7MnLHyjmCckRpBjG0FBQMZsQQVL+muHVSsC5IG5raSp7xL
jMEnpGz6qj9YGHk3o92FJl2wUzbIb9FMQ9gkJuue03CE8sAgcMHTJ6ZjiwGyiwcH
C/VH7Ib+iRLzCoy9lw+ZSvFPmOlnyNbLCNWm1b8DRT+fBIib4xPJBjD4KTohNtuf
LkApvfmIz0eg/NDHa7nL
=WOIo
-----END PGP SIGNATURE-----

--nextPart1807671.p7Z3pZXqny--
