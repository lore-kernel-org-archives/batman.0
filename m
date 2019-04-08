Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 08 Apr 2019 10:10:27 +0200
Message-ID: <1743828.EEJ9lJHY9g@prime>
In-Reply-To: <f2d6318d-a691-971e-9889-00867115303f@gmail.com>
References: <a5949349-69fa-7ef5-fd78-88af76749e24@gmail.com>
 <7264236.pZJWJxn9C4@prime> <f2d6318d-a691-971e-9889-00867115303f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3131022.RyoOysFVOU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] About making batman-adv mesh network invisible
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Xuebing Wang <xbing6@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org

--nextPart3131022.RyoOysFVOU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Xuebing,

I'm not aware of any "proprietary modulation", and I doubt it's possible - =
at=20
least not while using an AP at the same time. You can look into 5/10 MHz mo=
de=20
or do other quirks if mesh is the only thing running on your module though.

Cheers,
     Simon

On Saturday, April 6, 2019 2:06:55 PM CEST Xuebing Wang wrote:
> Hi Simon,
>=20
> Thanks a lot for your reply.
>=20
> With ath9k chip and ath9k driver, do you think it is possible to use
> "proprietary modulation" (slightly modified), so wireshark + wlan in
> monitor mode won't be able to detect wireless frames batman-adv network
> sends?
>=20
> Xuebing Wang
>=20
> On 2019/4/1 =E4=B8=8B=E5=8D=885:59, Simon Wunderlich wrote:
> > Hi Xuebing,
> >=20
> > at least for Ad-Hoc mode, you can't hide the SSID without changing the
> > kernel driver (mac80211). Encrypting the beacon doesn't help here, as t=
he
> > SSID needs to be clear text eventually even if management frames get
> > encrypted.
> >=20
> > Cheers,
> >=20
> >         Simon
> >=20
> > On Saturday, March 30, 2019 11:50:27 AM CEST Xuebing Wang wrote:
> >> Hi community,
> >>=20
> >> We have batman-adv + OpenWRT + ath9k chip + ath9k driver reliably
> >> running for about 2 years. The biggest batman-adv mesh network is with
> >> 100+ nodes.
> >>=20
> >> As this is a closed network, we have a new requirement which is to make
> >> our batman-adv mesh network invisible, although the current SSID is ju=
st
> >> some meaningless characters.
> >>=20
> >> One thought is hidden_ssid. But, it seems hidden_ssid is only supported
> >> for AP mode (not IBSS mode).
> >>=20
> >> 802.11w does not protect Beacon frame (because it is before four-ways
> >> handshake).
> >>=20
> >> As this is a closed network, what about encrypting Beacon (maybe all
> >> management frames later) using a hard-coded key in wpa_supplicant?
> >>=20
> >> Thanks for your help.
> >>=20
> >> Xuebing Wang


--nextPart3131022.RyoOysFVOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlyrAfMACgkQoSvjmEKS
nqEqWhAArPLO18THiA+xAObHlbpIT2L+tc2EVJQ9H2rxmlCuogIr33bcHNLQuJP3
M7xqQkuIVwfCT7zyXjWo+fXT3dPJzLMxANRLI1qqOfSukmJ0UVRjPE2QvJAAVNO6
wFxCzl90cUlivCjS8t2ew1R3kEdtLL2Ykmj/+uMBmyKScsV6Imf6PWReqVR83mGl
ZHoxVviubOgq9ryYGTOOHtMTUSI2PEtdsRl/GYcpk1SA1OwJQ4aT9u7Gw89DEhkd
ij4L7xdK2CKSgkTawFFoxbNv1uwzItKeqX3hE8V/StWOngFeFXGpZ4NLLIGyZg08
sa3T+Ue5gqOelLJLK/qtKIJcP8FRdIc3k0kykb6Y88PmS7gbxc/XmPRDwShrmkM6
gYEXh8UaVyxBZNJ9faTj+XTcdnmQODon3/GoXkiHVHwLO1ADVFWAPWoD3qJHDKqu
swhfV4mMSLKNlt2VcrSA8wWgDNYa7qcTDxnQFrdX4ESpIPxDB4rqawrwMJzSvFnS
XM0j7eKdXRzVkU7JC31VzW2CRQ3WBXlM/kjngd2Cbrhc0LYpbOIQZ892rx+q06lH
A18cMZPapS8YZC4N8FsI26upQiqp41BCrIAG0EgAZbepMppBvtoqRhty1OH3tA0Y
iPPiukFMj0bgo8AedKaW9FvIBWI389qdrl+epcRSM3YHylVixCM=
=E8ty
-----END PGP SIGNATURE-----

--nextPart3131022.RyoOysFVOU--

