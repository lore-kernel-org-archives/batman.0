Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 11 Aug 2010 16:52:57 +0200
References: <mailman.1.1281002401.15834.b.a.t.m.a.n@lists.open-mesh.org>
	<201008111320.14389.sven.eckelmann@gmx.de>
	<4C62B25A.3030206@web.de>
In-Reply-To: <4C62B25A.3030206@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1363039.5ct9Hm6gV1";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008111653.05417.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
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
Cc: Tim <Timbo2001@web.de>

--nextPart1363039.5ct9Hm6gV1
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 11 August 2010 16:23:22 Tim wrote:
> On 11.08.2010 13:20, Sven Eckelmann wrote:
> [...]
>=20
> > what you could try is to setup the stuff by yourself using
> >=20
> >   http://open-mesh.net/wiki/batman-adv-quick-start-guide  and test which
> >   command
> >=20
> > may cause the problem (when it is batman-adv related).
>=20
> I tried to configure it as described in the guide and I think I some
> kind of found the problem:
>=20
> Before being able to add wlan0 to the batman interfaces, I need to
> create the interface wlan0 and to remove "option disabled 1" from
> /etc/config/wireless, because otherwise wlan will be disabled by default.
>=20
> Way1: When removing "option disabled 1" first and then doing
> "/etc/init.d/network restart" I get the following message:
> "root@OpenWrt:/# /etc/init.d/network restart
> udhcpc (v1.15.3) started
> Sending discover...
> Configuration file: /var/run/hostapd-phy0.conf
> Segmentation fault
> Failed to start hostapd for phy0
> root@OpenWrt:/# Sending discover...
> Sending discover..."

So you mean that the device has radio0 and wlan0, but not bat0 configured? =
And=20
still it crashes? Is batman-adv loaded or unloaded completely in that=20
situation (check `lsmod` output)?

It is not clear to me how batman-adv is involved when it is not loaded. But=
 it=20
is somewhat active when it is only loaded, but bat0 is not configured...=20
because it has netdev notification enabled - which means that it gets infor=
med=20
about added and removed (and some other things) devices. It is maybe relate=
d=20
to that.

If it is loaded, but doesn't get configured when it crashes then please onl=
oad=20
batman-adv using `rmmod batman-adv` and try to restart the network (without=
=20
the batman-adv stuff loaded or configured).

By the way, you seem to have shell access after that segfault. Could you=20
please post the `dmesg` output after that segfault - thanks.

And please don't forget to write the complete version number of batman-adv=
=20
which you are using (I can guess it using the backfire branch, but it is sa=
fer=20
to get that information from you).

Best regards,
	Sven

--nextPart1363039.5ct9Hm6gV1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMYrlKAAoJEF2HCgfBJntGCOYQAK/Q4tkOM54ySVc+ViLVIFht
M2/l7y2eEtpFvgMNsgzftr6pSumxwFFNoExu3yzso3S5nnGwUqOTfKnSfpFiZT9Y
QmGl7NOLi0YVSq5iLiH7V/CuecbvcjSSFxdXE3scCeJTyDQAQcwFmz6HOGIBJsfu
VjIAbLXlW2CZtxSCTVf6HnmV53wYJqWHg9UKmTRUpIgb1hicd7OtD9WJE3g10zV4
StUi2GoaFvtAMdmK/L2omUhnfBed2qBHhszgscaE7jBpkHMT9ow8odzJldFVKatz
hmxfCgmMkcYdTZ5BeCldPB19G35b72iB0AfWsmjlITeq+7w7gw3b0FE06SPyV65h
wOuXx2W3dpKdCVN29eAGnJbXW4DKxHNwzivulUi9eUkNtR7Aai1Jbiwoxenlwfs1
Bnv9L8W0wWRfvaD/Rw48mV7dYZE2ns2ZGOSIZENnVR00MGdbO2RbVcw6QXsvmCG7
TUWnrG7Pzsxzv9tVGTizvgYSjfBkotEEB6OuW+FD7BE+KFZ4jQ85ehPNDSg7GNd5
N/FEiDEHtk0OHtr5sh0WDVDqEtJP8U4iXWIpJepP/m7Z2M8M55dd2L+5zOVV2TZo
TCUcpz1O2J3XRfAX3L2+AWed54jawz2dl6/tCjYkAw8eo1yDZboVNrLs1qLdwkJ3
xXC4VfmAINlE/hdu1M9C
=8oQH
-----END PGP SIGNATURE-----

--nextPart1363039.5ct9Hm6gV1--
