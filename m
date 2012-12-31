Return-Path: <ff@stephan.homeunix.net>
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Dec 2012 02:16:16 +0100
Message-Id: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
Mime-Version: 1.0 (Apple Message framework v1085)
Subject: [B.A.T.M.A.N.] Unterstanding gateway-mode - why does node have a
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello,

I started using batman-adv's gateway mode. Sadly, I ran into some =
trouble - A client is connected to two gateways via vpn (fastd):
# batctl gw_mode
client (selection class: 1)

# batctl gwl
      Gateway      (#/255)           Nexthop [outgoingIF]: gw_class ... =
[B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/f6:ec:38:e9:72:35 =
(bat0)]
   6a:4b:93:de:00:84 (255) 6a:4b:93:de:00:84 [  mesh-vpn]: 207 - =
48MBit/48MBit
=3D> aa:31:0e:4a:0f:1d (254) aa:31:0e:4a:0f:1d [  mesh-vpn]:  39 - =
1024KBit/1024KBit

# batctl o
[B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/f6:ec:38:e9:72:35 =
(bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   =
Potential nexthops ...
aa:31:0e:4a:0f:1d    0.500s   (255) aa:31:0e:4a:0f:1d [  mesh-vpn]: =
aa:31:0e:4a:0f:1d (255)
6a:4b:93:de:00:84    0.940s   (255) 6a:4b:93:de:00:84 [  mesh-vpn]: =
6a:4b:93:de:00:84 (255)

The client should use 6a:4b:93:de:00:84 as a gatway, since it provides =
much higher data rates - however, it is stuck at aa:31:0e:4a:0f:1d.
Why is that? How can I make the client choosing 6a:4b:93:de:00:84?

Thanks in advance,
Keep smiling
yanosz


