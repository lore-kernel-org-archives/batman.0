Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <50E31C20.6010604@altermundi.net>
Date: Tue, 01 Jan 2013 14:25:52 -0300
From: =?ISO-8859-1?Q?NicoEch=E1niz?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
In-Reply-To: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Unterstanding gateway-mode - why does node have
 a "sticky" gateway
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

On 12/30/2012 10:16 PM, Jan L=FChr wrote:
> Hello,
>=20
> I started using batman-adv's gateway mode. Sadly, I ran into some trouble=
 - A client is connected to two gateways via vpn (fastd):
> # batctl gw_mode
> client (selection class: 1)
>=20
> # batctl gwl
>       Gateway      (#/255)           Nexthop [outgoingIF]: gw_class ... [=
B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/f6:ec:38:e9:72:35 (bat0)]
>    6a:4b:93:de:00:84 (255) 6a:4b:93:de:00:84 [  mesh-vpn]: 207 - 48MBit/4=
8MBit
> =3D> aa:31:0e:4a:0f:1d (254) aa:31:0e:4a:0f:1d [  mesh-vpn]:  39 - 1024KB=
it/1024KBit
>=20
> # batctl o
> [B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/f6:ec:38:e9:72:35 (bat0)]
>   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Pot=
ential nexthops ...
> aa:31:0e:4a:0f:1d    0.500s   (255) aa:31:0e:4a:0f:1d [  mesh-vpn]: aa:31=
:0e:4a:0f:1d (255)
> 6a:4b:93:de:00:84    0.940s   (255) 6a:4b:93:de:00:84 [  mesh-vpn]: 6a:4b=
:93:de:00:84 (255)
>=20
> The client should use 6a:4b:93:de:00:84 as a gatway, since it provides mu=
ch higher data rates - however, it is stuck at aa:31:0e:4a:0f:1d.


I have observed the same behavior.


