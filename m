Return-Path: <j.zimmer@telegrid.com>
From: "Joseph Zimmer" <j.zimmer@telegrid.com>
In-Reply-To: <3376805.a4VXV4btx9@sven-edge>
Date: Fri, 8 May 2015 12:21:28 -0400
Message-ID: <DCC9EBC4A6F744AFBE5395ED9B31C073@telegridtech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] FW: using Batman-adv
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@lists.open-mesh.org>

> There is another suggestion: You could increase the multicast rate to =
a
high
> value, e.g. 36 MBit/s or even higher. Higher rates only work with good
> signals, and since batman-adv uses broadcasts (which is multicast for
> WiFi), this will have a direct effect on your network.

I received input mentioning the multicast rate. =20
Since the mcast_rate modification looked straight forward I choose to =
try it
out right away.
=20
I did see an improvement in the behavior of our network. By improvement =
I
mean that I see the network routing through adjacent nodes using hops,
verified by trace route, and achieved higher throughput values.  A value =
of
36000 was used for the mcast_rate but anything higher broke the system =
(Not
sure why). I used that value since my research indicated that the value =
was
in Kbps and Simon pointed out 36 Mbits.

Thanks for the help,

Joseph=20

-----Original Message-----
From: B.A.T.M.A.N [mailto:b.a.t.m.a.n-bounces@lists.open-mesh.org] On =
Behalf
Of Sven Eckelmann
Sent: Friday, May 08, 2015 2:34 AM
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [B.A.T.M.A.N.] FW: using Batman-adv

On Thursday 07 May 2015 19:25:11 Simon Wunderlich wrote:
[....]
> There is another suggestion: You could increase the multicast rate to =
a
high
> value, e.g. 36 MBit/s or even higher. Higher rates only work with good
> signals, and since batman-adv uses broadcasts (which is multicast for
> WiFi), this will have a direct effect on your network.
[...]
> Batman-adv is open source, and so is mac80211 and hopefully the WiFi
driver
> you use. However, it'd really suggest to start with tuning the =
multicast
> rate.
> :)

I definitely agree here. This should tested before trying to hack the TQ
calculation with some own RSSI based submetric.

The mcast_rate trick is currently only shown in an old OpenWrt wiki page
[1].
Maybe it should also be mentioned in the main OpenWrt configuration page
[2].
I will leave this to the interested reader... or I will change it when I
have some time to confirm it with a current OpenWrt.

Kind regards,
	Sven


[1]
http://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-conf=
ig-
sophisticated
[2]
http://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-conf=
ig

