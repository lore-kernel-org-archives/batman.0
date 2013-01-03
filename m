Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Jan 2013 22:58:15 +0800
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301030957.04081.lindner_marek@yahoo.de>
 <4687DDE1-A80F-46C5-B6BC-99763C1D856F@stephan.homeunix.net>
In-Reply-To: <4687DDE1-A80F-46C5-B6BC-99763C1D856F@stephan.homeunix.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301032258.15573.lindner_marek@yahoo.de>
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

On Thursday, January 03, 2013 19:03:11 Jan L=FChr wrote:
> c) Disable regular gateway, force node to switch to backup
> kif:~# batctl gw_mode client
>=20
> Gateway-List is:
> reifunk-b0487acb2d58:~# batctl gwl
>       Gateway      (#/255)           Nexthop [outgoingIF]: gw_class ...
> [B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/b2:48:7a:cb:2d:59 (bat0)]
> =3D> aa:31:0e:4a:0f:1d (255) aa:31:0e:4a:0f:1d [  mesh-vpn]:  39 -
> 1024KBit/1024KBit
>=20
> d) Re-enable regular gateway
> root@kif:~# /usr/local/sbin/batctl gw server 100Mbit/100Mbit

Ah! You failed to mention this part in your initial email.

The behavior is easily explained: batman-adv does not switch gateway whenev=
er=20
a new gateway is found (even if it is a better gateway) unless the selectio=
n=20
class is on fast or late switching.

Cheers,
Marek
