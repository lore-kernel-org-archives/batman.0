Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 7 Jan 2013 07:42:27 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130107064227.GA10699@pandem0nium>
References: <50E9FAD0.8000004@futurec.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <50E9FAD0.8000004@futurec.net>
Subject: Re: [B.A.T.M.A.N.] wpa-none through openwrt config
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ray,

On Sun, Jan 06, 2013 at 02:29:36PM -0800, Ray Gibson wrote:
> Hello,
>=20
> I'm trying to get wpa-none happy on my bullet m5's running
> batman-adv (aa-rc1 with batman-adv 2012.3.0).  I can make it work by
> running wpa_supplicant manually with the correct options but am
> interested in having it work through the uci config files.  Is this
> possible?  The wpa_supplicant.sh script seems to want to force
> wpa-psk with any options that force wpa_supplicant, which generate a
> relatively useless supplicant config file for ibss. This also makes
> wlan0 get the default 1500 MTU.
>=20
> Here's my "semi-working" wpa_supplicant.conf file, after I increase
> the MTU then batman talks properly and sees the other node.
> semi-working because even though batctl o sees the other node it
> can't ping it unless the psk is commented out.. :-\
>=20
> ctrl_interface=3D/var/run/wpa_supplicant
> ctrl_interface_group=3D0
> eapol_version=3D1
> ap_scan=3D2
> fast_reauth=3D1
> #IBSS/ad-hoc mode with WPA2/AES encryption
> network=3D{
>     ssid=3D"batmesh"
>     bssid=3D20:aa:bb:cc:dd:ee
>     mode=3D1
>     scan_ssid=3D1
>     frequency=3D5765
>     fixed_freq=3D1
>     mcast_rate=3D18
>     htmode=3DHT20
>     proto=3DWPA
>     key_mgmt=3DWPA-NONE
>     pairwise=3DNONE
>     group=3DCCMP
>     psk=3D"xxxxxxxx"
> }

Have you made sure that WPA-NONE works without batman-adv? It appears
that openwrt currently doesn't support WPA-NONE at all driver-wise, at
least this bug report suggests it (don't know if its a problem in wpa_suppl=
icant,
madwifi, or any other driver):

https://dev.openwrt.org/ticket/9190

You can try running WPA-NONE, set some IPs and let the nodes ping each othe=
r.
If this works, batman-adv should[tm] work too.

Cheers,
	Simon

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlDqblMACgkQrzg/fFk7axZ/aACgvQPQY7oG2Zz6E7uellW93cE5
E+AAoIZPh++CRqArkEwzoDBCecmfoozp
=HXQU
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
