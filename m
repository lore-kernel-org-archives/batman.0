Return-Path: <linus.luessing@web.de>
Date: Thu, 6 Aug 2009 22:51:28 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20090806205128.GB4425@Linus-Debian>
References: <200908051533.26117.lindner_marek@yahoo.de>
	<SNT107-W364D4E251434A47E75E6C7A60A0@phx.gbl>
	<SNT107-W36378936CB704146168424A60A0@phx.gbl>
	<200908062226.21948.lindner_marek@yahoo.de>
	<SNT107-W15FB756F128D90901F56F5A60A0@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <SNT107-W15FB756F128D90901F56F5A60A0@phx.gbl>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Some handholding for batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick!

We've also started experimenting with batman-adv and a Linksys WRT54GL in o=
ur little project in December with Kamikaze 8.0.9. What we figured out, tha=
t with the kernel version provided in this firmware-build, it was not possi=
ble to create any useful setup as the broadcom-wifi-driver lost way too man=
y packets in ad-hoc-mode and sometimes even crashed.

So, if you're really in a hurry, the quickest way would probably to get som=
e Dlink DIR-300s for about 25=E2=82=AC. We're succesfully using them here, =
the wifi seems way better and also more "advanced" configurations can be cr=
eated because of the ability to splitting the atheros-wifi-device into seve=
ral interfaces. We're currently mainting our firmware in our git-repository=
 on http://krtek.asta.uni-luebeck.de:8080/repos/LuebeckFreifunkFirmware/. S=
ome more additional information about our project itself can be found on ht=
tp://luebeck.freifunk.net. So far, we're quite satisfied how it works so fa=
r. So we're going to add some more last-minute patches in the next couple o=
f days, as we've scheduled a practical setup with this firmware for the wee=
kend form the 14th to 16th of August.

If you still have your reasons for trying to setup the mesh network with Li=
nksys routers, then you should probably plan some more time for this, as I'=
m not aware of anyone getting batman-adv + WRT54GL working so far. Neverthe=
less, I've been trying to catch up a little about the latest driver develop=
ments and according to http://linuxwireless.org the new bt43 driver sounds =
very useable, they're saying that adhoc should work now with the driver rew=
rite. From 2.6.25-kernels on, the bt43 driver has been included in the kern=
el-tree and has been updated frequently. Therefore I'd suggest, that you co=
uld give a self-compiled image from the OpenWRT-trunk a try. For details on=
 how to do that, check out the OpenWRT-documentation or the ugly build-scri=
pts in our projects repo. Furthermore, you might also wanna try the latest =
stable kernel release 2.6.30, the trunk is currently configured to use the =
2.6.28-kernel version for broadcom firmwares. Anyway, it looks like the con=
fig-files for the 2.6.30 broadcom build have already been ported from the 2=
=2E6.28-kernel and installed, so that you'd only have to change 'LINUX_VERS=
ION:=3D2.6.28.10' to 'LINUX_VERSION:=3D2.6.30.4' in 'trunk/target/linux/brc=
m47xx/Makefile' for trying the the (almost) latest 'n' greates broadcom-wif=
i-driver. I would also be very curious to get to know how those latest driv=
ers work, I myself still have an unused Linksys WRT54GL here at home. So yo=
ur contribution in testing that stuff would be highly appreciated :).


Thirdly you can still use an official release from OpenWRT (like the Kamika=
ze 8.0.9) with the 2.4-kernel, where the wifi should be working stable. Of =
course, as Marek already had pointed out, you wouldn't be able to use batma=
n-adv there, you'd have to use the normal batmand which is "just" doing lay=
er 3 routing. But as far as I know, the disadvantage of this option would b=
e, that you'd either have to install the batmand on all machines using the =
mesh-network, so your laptops as well for instance, or by setting the 'entr=
y'-routes manually on those clients, as they're otherwise not able to find =
the machines behind the other router on a different subnet/ip-range. Please=
 might the experts correct me, if I'm saying anything wrong about batmand, =
I haven't been playing around with this one that much :).

Cheers, Linus

On Thu, Aug 06, 2009 at 03:47:26PM +0000, nick farrow wrote:
>=20
> Hi Marek,
>=20
> =20
>=20
> Thanks for clearing this up.
>=20
> =20
>=20
> With no broadcom support in 2.6 then there is no kmod driver for batman.
>=20
> =20
>=20
> It looks like its back to the earlier version of that did work (batman 0.=
2-rv478-1) just that it did not forward same subnet arps. I realise that pe=
rformance is not going to be great with this but it will work
>=20
> =20
>=20
> To do this do I basically setup one subnet for the batman nodes to run in=
, then further subnets for the hosts at each wrt batman mesh node, then jus=
t configure each batmand node to announce the host subnet?
>=20
> =20
>=20
> So for a 3 node mesh, break the default bridge, assign a static network a=
ddress to the eth0, assign a different subnet address to wl0
>=20
> i.e
>=20
> mesh node 1
>=20
> eth0 172.16.1.1/24
>=20
> wl0 192.168.1.1
>=20
> run with batmand -a 172.16.1.0 wl0
>=20
> =20
>=20
> mesh node 2
>=20
> eth0 172.16.2.1/24
>=20
> wl0 192.168.1.2
>=20
> run with batmand -a 172.16.2.0 wl0
>=20
> =20
>=20
> etc
>=20
> =20
>=20
> Does this look correct to allow say 172.16.1.2 on the ethernet of mesh1 t=
o ping 172.16.2.2 on the ethernet of mesh2?
>=20
> =20
>=20
> Thanks again for sticking with this
>=20
> =20
>=20
> nick
>=20
> =20
>=20
> =20
>=20
> =20
> > From: lindner_marek@yahoo.de
> > To: b.a.t.m.a.n@lists.open-mesh.net
> > Date: Thu, 6 Aug 2009 22:26:21 +0800
> > Subject: Re: [B.A.T.M.A.N.] Some handholding for batman-adv
> >=20
> >=20
> > Hi,
> >=20
> > > There seem to be 2 versions of advanced batman - batman-adv and
> > > kmod-batman-advanced, however for the k8.09.1/brcm 2.4 release there =
does
> > > not seem to be the kmod driver. So I have installed the batman-adv
> > > (batmand-adv_r1176-1_mipsel.ipk and battools) there is no batctl here.
> >=20
> > batman-adv was the first attempt to write a layer 2 routing daemon.=20
> > Unfortunately, due to the fact that it was written as user space applic=
ation=20
> > it came with a big performance penalty. We ported the code into kernel =
space=20
> > by writing the batman-adv kernel module. Since the module is stable the=
 daemon=20
> > is deprecated. The OpenWRT package was removed - not sure why you still=
 can=20
> > install it.
> >=20
> > batctl comes with the batman-adv kernel module as it has nothing to do =
with=20
> > the user space daemon.
> >=20
> > The kernel module requires linux 2.6 (nobody backported it to 2.4 yet).=
 Unless=20
> > you use the open source wifi drivers for the WRT you are stuck with the=
 binary=20
> > only wl driver which runs on linux 2.4 only. That is why you can't sele=
ct=20
> > kmod-batman-advanced.
> >=20
> > Regards,
> > Marek
> >=20
> >=20
> >=20
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@lists.open-mesh.net
> > https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20
> _________________________________________________________________
> Windows Live Messenger: Celebrate 10 amazing years with free winks and em=
oticons.
> http://clk.atdmt.com/UKM/go/157562755/direct/01/

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBAgAGBQJKe0JPAAoJEBKw7u43QNpf8woP/2HeEjSmwDf7tD66wRLQl3Ua
3owwIojKLRv0PF4QrSvrluK+5UDJhbpuVcSIr/CgQU0RF6ovsCiIZZAssHZ0jh9T
/mYXq/A68NjW1BZ5DOPG4IX7aHaOBefE1eofBgRIJIHInYCON/mL9HxEf03DSMq1
ubpRFsThzeW5aWl18nFu2AiOaZ5yDJ+RQntRf4y5KcQC2Y8wv3NcscwZH0XEr7yJ
I5Tk8RNvL3qfDdxkxgMjTZk3fuMrY6m1+wZUlI1XrYfpX2k/8q4JlEr65A9jYvab
eKB0gDuo4+Y775qqdGvxYciIepqAFp8IXPht4dcwRfD7iqqTTSnfC4KRC6Ku0gWw
tB9DTGGbI0Ht0ovMrVi2mVos+TxLHXHi+w8kxdJWmm/eyY0MceuoFaR1QdvnfJVL
XLzJKhzlp3MmqXd6lk32fgU+Dr+FeLYbgRJin6AQsH6TUAB0LcLDARagOsBwJ/TR
+qIJV9MhyqhG5EaWgR7sr2wrdJrcwDemM70am1eOczcl0L/b75Y1u68/dsuWqx9M
ukoOGa56Nl1A9bPLhJdj4o35v8t6/j0RKrp5sHnsMuga2SF5o61c8Kp3K30JtrFd
okxq771XBYBztxZpG4CYAENVhOCrJQGhIM97bKpz7yFrdifh+HBuya61xjzO1ZpI
SruEEDhWMkeZuIj/5GOG
=auf1
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
