Date: Mon, 26 Jan 2009 22:24:12 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090126212412.GA16326@pandem0nium>
References: <238a15490901231630s7d460687x6a95238f7308998a@mail.gmail.com>
	<200901240942.07893.lindner_marek@yahoo.de>
	<238a15490901260934i1f4dcd30u7404cd79fff7a29c@mail.gmail.com>
	<200901270341.31896.lindner_marek@yahoo.de>
	<238a15490901261228t3b1ae9d1l1ced88b416698731@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <238a15490901261228t3b1ae9d1l1ced88b416698731@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Help in batman advanced configuration
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gargi,

your setup looks correct from what you've pasted. Some questions to find
the reason:

1. Have you set "up" all the interfaces by doing "ifconfig <dev> up"?=20

2. If you set IPs on br0 of open-mesh1 and br0 of open-mesh2 manually,=20
can they ping each other?=20

3. If yes (and configured within the subnet of PIX):=20
Can you ping PIX from open-mesh2?

4. If you do udhcpc on open-mesh2, do you receive the packet on br0 on
open-mesh1? Please check with tcpdump, this should work. If yes, do you
also receive it on the PIX? (Maybe the answer is getting lost somewhere).

BTW, i've set up similar scenarios yet, this is supposed to work. ;)

best regards,
	Simon



On Mon, Jan 26, 2009 at 02:28:44PM -0600, Gargi Purohit wrote:
> On Mon, Jan 26, 2009 at 1:41 PM, Marek Lindner <lindner_marek@yahoo.de> w=
rote:
> > On Tuesday 27 January 2009 01:34:16 Gargi Purohit wrote:
> >> I hope other than setting the interface "ath0" in
> >> /proc/net/batman-advanced/interfaces - i dont
> >> need any other configuration changes.
> >>
> >> Since I can batping between the two routers i guess the layer 2
> >> connectivity is established between
> >> these guys - am just wondering if they should be able to forward
> >> requests like dhcp over multiple hop
> >> (1 hop and above)....
> >
> > Yes, a working batping indicates that the connection between both modul=
es is
> > given. The DHCP request should be forwarded without problems. Your setu=
p is
> > misconfigured somewhere.
> >
> > Could you please show the output of "brctl show br0" and "cat
> > /proc/net/batman-adv/interfaces" on both nodes. You can check where the=
 dhcp
> > request dies by using tcpdump or batdump.
>=20
> On node 1 (Which is wired)
> ---------------------------------------
>=20
> root@open-mesh:~# brctl show br0
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.00180a0145b0       no              bat0
>                                                         ath1
>                                                         ath2
>                                                         eth0
> root@open-mesh:~# cat /proc/net/batman-adv/interfaces
> ath0
>=20
> root@open-mesh:~# cat /proc/net/batman-adv/originators
>   Originator     (#/255)           Nexthop [outgoingIF]:   Potential
> nexthops ... [B.A.T.M.A.N. Adv 0.1-beta rv1103, MainIF/MAC:
> ath0/00:18:0a:01:45:b0]
> 00:18:0a:01:44:d0  (255) 00:18:0a:01:44:d0 [      ath0]: 00:18:0a:01:44:d=
0 (255)
>=20
> On node 2 (Which is connected wirelessly to node 1 - eth0 is down)
> -------------------------------------------------------------------------=
-------------------------
> root@open-mesh:/proc/net# brctl show br0
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.00ff678aa75f       no                    ath1
>                                                         bat0
>                                                         ath2
> root@open-mesh:/proc/net# cat /proc/net/batman-adv/interfaces
> ath0
>=20
> root@open-mesh:/proc/net# cat /proc/net/batman-adv/originators
>   Originator     (#/255)           Nexthop [outgoingIF]:   Potential next=
hops ..
> . [B.A.T.M.A.N. Adv 0.1-beta rv1103, MainIF/MAC: ath0/00:18:0a:01:44:d0]
> 00:18:0a:01:45:b0  (255) 00:18:0a:01:45:b0 [      ath0]: 00:18:0a:01:45:b=
0 (255)
>=20
> root@open-mesh:/proc/net#
>=20
>=20
>=20
> > Regards,
> > Marek
> >
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJfin8rzg/fFk7axYRArD6AJsFopD8+ZhlwhJWN6jNnGAo83qHPgCdFgHp
t/I6o0/TASreYNzzrjw65fY=
=rn7h
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
