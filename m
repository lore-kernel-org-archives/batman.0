Return-Path: <a@unstable.cc>
References: <20180511185723.20138-1-mareklindner@neomailbox.ch>
 <20180522211214.GG15580@otheros>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <15be2a15-3b59-b4da-2893-170599256331@unstable.cc>
Date: Fri, 7 Sep 2018 18:13:07 +0800
MIME-Version: 1.0
In-Reply-To: <20180522211214.GG15580@otheros>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nrqHgCMzS1KXu1vzjNuhZH2rGr4STkvgN"
Subject: Re: [B.A.T.M.A.N.] [RFC maint v2] batman-adv: fix adding VLANs with
 partial state
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nrqHgCMzS1KXu1vzjNuhZH2rGr4STkvgN
Content-Type: multipart/mixed; boundary="vO8u7k9S9p7BZdatMTtL5FnugLoaXD08P";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <15be2a15-3b59-b4da-2893-170599256331@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [RFC maint v2] batman-adv: fix adding VLANs with
 partial state
References: <20180511185723.20138-1-mareklindner@neomailbox.ch>
 <20180522211214.GG15580@otheros>
In-Reply-To: <20180522211214.GG15580@otheros>

--vO8u7k9S9p7BZdatMTtL5FnugLoaXD08P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

see comments below

On 23/05/18 05:12, Linus L=C3=BCssing wrote:
> On Sat, May 12, 2018 at 02:57:23AM +0800, Marek Lindner wrote:
>> Whenever a new VLAN is created on top of batman virtual interfaces
>> the batman-adv kernel module creates internal structures to track
>> the status of said VLAN. Amongst other things, the MAC address of
>> the VLAN interface itself has to be stored.
>>
>> Without this change a VLAN and its infrastructure could be created
>> while the interface MAC address is not stored without triggering
>> any error, thus creating issues in other parts of the code.
>>
>> Prevent the VLAN from being created if the MAC address can not
>> be stored.
>>
>> Fixes: 952cebb57518 ("batman-adv: add per VLAN interface attribute fra=
mework")
>>
>> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
>=20
> I tested this patch but so far could not spot any issues either in
> dmesg or logread.
>=20
> I've added these patches to a branch for Gluon here:
>=20
> https://github.com/T-X/gluon/tree/tt-vlan-patched
>=20
> And used these images (warning, they have my SSH public added):
>=20
> https://metameute.de/~tux/Freifunk/firmware/ffh-tt-patched/
>=20
> I've tested with an isolated two nodes setup for now.
>=20
>=20
> I started playing with restarting the network multiple times:
>=20
> ~~~~~
> root@freifunk-b0487ae7f31e:~# rm /tmp/vlan-test.log; trap '' SIGPIPE; f=
or i in `seq 1 30`; do echo "Starting network restart $i" >> /tmp/vlan-te=
st.log; /etc/init.d/network restart; sleep 5; if batctl tl | grep " 0 \["=
; then echo "BROKEN - aborting" >> /tmp/vlan-test.log; batctl tl >> /tmp/=
vlan-test.log; sleep 3; echo "waiting..." >> /tmp/vlan-test.log; batctl t=
l >> /tmp/vlan-test.log; break; fi; done; echo "finished" >> /tmp/vlan-te=
st.log
> ~~~~~
>=20
> And the result is the following - which looks odd?

I don't fully understand the script...you check for $(grep " 0 \[")
returning success and then print BROKEN? in any case, please continue
reading below..

>=20
> ~~~~~
> root@freifunk-b0487ae7f31e:~# cat /tmp/vlan-test.log=20
> Starting network restart 1
> Starting network restart 2
> Starting network restart 3
> BROKEN - aborting
> [B.A.T.M.A.N. adv 2018.1, MainIF/MAC: primary0/66:c6:34:9d:58:43 (bat0/=
b0:48:7a:e7:f3:1e BATMAN_IV), TTVN: 1]
> Client             VID Flags    Last seen (CRC       )
> 9a:86:17:9c:5f:4f   -1 [.P.X..]   0.000   (0x0ce60e81)
> b0:48:7a:e7:f3:1e    0 [.PN...]   0.000   (0x00000000)
> b0:48:7a:e7:f3:1e   -1 [.PN...]   0.000   (0x0ce60e81)
> waiting...
> [B.A.T.M.A.N. adv 2018.1, MainIF/MAC: primary0/66:c6:34:9d:58:43 (bat0/=
b0:48:7a:e7:f3:1e BATMAN_IV), TTVN: 2]
> Client             VID Flags    Last seen (CRC       )
> b0:48:7a:e7:f3:1e    0 [.P....]   0.000   (0xc4c7d9cf)
> b0:48:7a:e7:f3:1e   -1 [.P....]   0.000   (0x62afdc24)
> finished
> ~~~~~
>=20
> However, this oddity seems to be temporary, now the local TT looks
> just fine, without having rebooted the node:
>=20
> ~~~~~
> root@freifunk-b0487ae7f31e:~# batctl tl
> [B.A.T.M.A.N. adv 2018.1, MainIF/MAC: primary0/66:c6:34:9d:58:43 (bat0/=
b0:48:7a:e7:f3:1e BATMAN_IV), TTVN: 4]
> Client             VID Flags    Last seen (CRC       )
> 33:33:ff:40:f8:dc   -1 [.P....]   0.000   (0xd118c666)
> b0:48:7a:e7:f3:1e    0 [.P....]   0.000   (0xc4c7d9cf)
> 33:33:00:00:00:02   -1 [.P....]   0.000   (0xd118c666)
> 33:33:ff:00:00:01   -1 [.P....]   0.000   (0xd118c666)
> 33:33:00:02:10:01   -1 [.P....]   0.000   (0xd118c666)
> 01:00:5e:00:00:01   -1 [.P....]   0.000   (0xd118c666)
> b0:48:7a:e7:f3:1e   -1 [.P....]   0.000   (0xd118c666)
> 33:33:ff:e7:f3:1e   -1 [.P....]   0.000   (0xd118c666)
> 33:33:00:00:00:01   -1 [.P....]   0.000   (0xd118c666)
> ~~~~~
>=20
> Or is it expected that a TT VLAN entry with an "N" flag will have
> the CRC set to 0x00000000?

Yes. TT entries marked with "N" are "New", which means they are part of
the table but have not been "committed" yet and thus not included in the
CRC computation. They will be included (and lose the "N" flag) at the
next commit upon OGM generation.

>=20
> I also noticed that the VLAN 0 is added to bat0 by 8021q right
> after bat0 gets created and activated:
>=20
> ~~~~~
> Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7852.985327] batman_adv: b=
at0: Adding interface: primary0
> Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7852.990712] batman_adv: b=
at0: Interface activated: primary0
> Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7853.025080] 8021q: adding=
 VLAN 0 to HW filter on device bat0
> Sun Feb 25 14:20:28 2018 daemon.notice netifd: Interface 'bat0' is enab=
led
> Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7853.038815] device bat0 e=
ntered promiscuous mode
> Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7853.043649] br-client: po=
rt 3(bat0) entered forwarding state
> Sun Feb 25 14:20:28 2018 kern.info kernel: [ 7853.049388] br-client: po=
rt 3(bat0) entered forwarding state
> Sun Feb 25 14:20:28 2018 daemon.notice netifd: Network device 'bat0' li=
nk is up
> Sun Feb 25 14:20:28 2018 daemon.notice netifd: Interface 'bat0' has lin=
k connectivity=20
> Sun Feb 25 14:20:28 2018 daemon.notice netifd: Interface 'bat0' is sett=
ing up now
> Sun Feb 25 14:20:28 2018 daemon.notice netifd: Interface 'bat0' is now =
up
> ~~~~~
>=20
> Which looks like it might have the potential for a race condition?
> Also the "HW filter" remark by 8021q seems a bit odd as this is a
> virtual interface, doesn't it?

This is nothing related to batman-adv, but it's just an internal VLAN
that I never fully understood why it is created.

What race condition are you talking about?

Cheers,


--=20
Antonio Quartulli


--vO8u7k9S9p7BZdatMTtL5FnugLoaXD08P--

--nrqHgCMzS1KXu1vzjNuhZH2rGr4STkvgN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAluSTzQACgkQB6U8WA7y
zXQwORAAtPVNiUFNpT1DeeIwf3iw1VcuIcD3Pu4jjP2CCHilEZEybmhBXjQ6IZV5
SL1YXToTrIuMnRN9swelBIUqryUpV/zcBz2THeJouU4huko2jIHZRgE0VPl68DCx
muFMT+MatEGCXenjnbXlCf3k26sTymNeP419iwF8MdoewW1OM6q5pbAGlNuMl9TV
bhcLntmgbTqL7PHouzIH4HvF71tfXqInfZ2oiBFW7GWcceApT0WS1a0XtfN1LRMX
QM7CmqjogTGLknJQgrmRy/UT7jsjOb8FmNmejE1YEAH+gA0iwKZi7v39ky9Tgelk
eF9p6XF893PxeUJ6Cvk9/ZaVSfdXX1MPsm4QIVLBJi5vVBQPFO/7MkHbvD5ynvII
9TyJSifMpM/53LyZXGFtMP1GPgPpoYjiy4cJB9oo7SvEy2os+cB+qu2aRCChkaoc
M9lC41cBRS6B7WrjGs03SSjoUwp8Ts0foIlZJu9I6RYUVYO6+8fNPAQ8MjhrwlU4
DAhd97vyX2EIicWcDYZYuKtG0OT0K4KmDSe76pwZnZXA0hajB5yW83xUGHZJI/or
hRX+F9WnfPTO3BRgk03gA72Y71DPZ8jx5SFjlNBWaJeKBPZKKEYRMCixh7DZQjz9
/pvaQ3pSYEfuBS1rsZqZLBi4C3SvYmO5q0qOkubBT0fuBU4OBd0=
=m0T9
-----END PGP SIGNATURE-----

--nrqHgCMzS1KXu1vzjNuhZH2rGr4STkvgN--
