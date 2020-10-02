Return-Path: <mailing.m1@kkk-web.de>
Date: Fri, 2 Oct 2020 09:40:07 +0000 (UTC)
From: MK <mailing.m1@kkk-web.de>
Message-ID: <958cd34d-3e84-4e7e-8349-15513a1eba0b@kkk-web.de>
In-Reply-To: <1713150.I2ok1Jj7fX@ripper>
References: <5e4c619d-bdb1-2fa7-57cc-e5d71ea13f08@kkk-web.de> <5095353.evS3lK4dNX@sven-edge> <4fc7de29-7692-58b1-994b-4a3d623c075a@kkk-web.de> <1713150.I2ok1Jj7fX@ripper>
Subject: Re: Does batman choose DHCP server by random?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Hi Sven.

Thanks for the hints!
I deleted MACs manually. So this is not a bug ;)

Regards
Martin

02.10.2020 11:25:43 Sven Eckelmann <sven@narfation.org>:

> On Friday, 2 October 2020 10:29:16 CEST MK wrote:
> [...]
>> $ batctl gwl
>> [B.A.T.M.A.N. adv openwrt-2019.2-4, MainIF/MAC: fastd_mesh/ (bat0/
>> BATMAN_V)]
>> Router=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ( throughput) Next Hop=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 [outgoingIf]=C2=A0 Bandwidth
>> (=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.0)=C2=A0 [fastd_mesh]: 10.=
0/10.0 MBit
>> (=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.0)=C2=A0 [fastd_mesh]: 10.=
0/10.0 MBit
>> (=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.0)=C2=A0 [fastd_mesh]: 10.=
0/10.0 MBit
>> (=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.0)=C2=A0 [fastd_mesh]: 10.=
0/10.0 MBit
>> (=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.0)=C2=A0 [fastd_mesh]: 10.=
0/10.0 MBit
>> *=C2=A0 (=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.0)=C2=A0 [fastd_me=
sh]: 10.0/10.0 MBit
>>=20
>> Star means choosen gateway?
>=20
> Yes, this is the chosen gateway. And the "1.0" here means most likely tha=
t the
> throughput to this gateway is for some reason always the same - so it has=
 no
> good way to figure out the best gateway.
>=20
> Please make sure that you either only use links that provide an expected
> throughput for its peers - OR use the throughput_override [1] on interfac=
es
> which cannot provide an automated expected throughput for its peers. Also
> make sure that you don't forget this setting on one side of the connectio=
n.
>=20
> And can you please explain how you were able to get this output without t=
he
> router mac address? Because this is a bug and I cannot reproduce it at th=
e
> moment.
>=20
> Kind regards,
> Sven
>=20
> [1] https://www.open-mesh.org/projects/batman-adv/wiki/Tweaking#throughpu=
t_override
>=20
