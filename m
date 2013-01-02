Return-Path: <ff@stephan.homeunix.net>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1085)
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
In-Reply-To: <50E31C20.6010604@altermundi.net>
Date: Thu, 3 Jan 2013 00:28:02 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <ABCFB139-9D63-48DB-8C1F-8A0D6E10AD02@stephan.homeunix.net>
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <50E31C20.6010604@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] Unterstanding gateway-mode - why do nodes have a
	"sticky" gateway
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

Hello,

Am 01.01.2013 um 18:25 schrieb NicoEch=E1niz:

> On 12/30/2012 10:16 PM, Jan L=FChr wrote:
>> Hello,
>>=20
>> I started using batman-adv's gateway mode. Sadly, I ran into some =
trouble - A client is connected to two gateways via vpn (fastd):
>> # batctl gw_mode
>> client (selection class: 1)
>>=20
>> # batctl gwl
>>      Gateway      (#/255)           Nexthop [outgoingIF]: gw_class =
... [B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/f6:ec:38:e9:72:35 =
(bat0)]
>>   6a:4b:93:de:00:84 (255) 6a:4b:93:de:00:84 [  mesh-vpn]: 207 - =
48MBit/48MBit
>> =3D> aa:31:0e:4a:0f:1d (254) aa:31:0e:4a:0f:1d [  mesh-vpn]:  39 - =
1024KBit/1024KBit
>>=20
>> # batctl o
>> [B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/f6:ec:38:e9:72:35 =
(bat0)]
>>  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   =
Potential nexthops ...
>> aa:31:0e:4a:0f:1d    0.500s   (255) aa:31:0e:4a:0f:1d [  mesh-vpn]: =
aa:31:0e:4a:0f:1d (255)
>> 6a:4b:93:de:00:84    0.940s   (255) 6a:4b:93:de:00:84 [  mesh-vpn]: =
6a:4b:93:de:00:84 (255)
>>=20
>> The client should use 6a:4b:93:de:00:84 as a gatway, since it =
provides much higher data rates - however, it is stuck at =
aa:31:0e:4a:0f:1d.
>=20
>=20
> I have observed the same behavior.


That's quite frustrating. Can I debug, when and why batman-adv actually =
chooses as specific gateway?

Thanks,
Keep smiling
yanosz=
