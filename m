Return-Path: <jonsmirl@gmail.com>
MIME-Version: 1.0
In-Reply-To: <51CB60F0.6090604@wirelesspt.net>
References: <CAKON4Ox2+uFUWR5ZBQ8yHdWZWW0zrxAgkd8iv-QG3DtTnVKJWQ@mail.gmail.com>
 <51CB60F0.6090604@wirelesspt.net>
Date: Wed, 26 Jun 2013 18:39:04 -0400
Message-ID: <CAKON4Ozy3ObsYRYTF71i4Ys7A4H5228xywXfjZxvfwrepUyjTQ@mail.gmail.com>
From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] single radio routers and ap/adhoc interfaces
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
To: cmsv@wirelesspt.net
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Jun 26, 2013 at 5:45 PM, cmsv <cmsv@wirelesspt.net> wrote:
> I am not sure what are you trying to do with the info yuo have showed...
> but it kind looks that someone is not reading important documentation.
>
> AR72* should not cause you any problems.
> You need to consult openwrt wiki for driver support and not batman-adv
> wiki. Driver support is openwrt business.

It looks like OpenWRT trunk is broken. I just sent this out on the
OpenWRT list but I haven't received a response yet. When I loaded
Steve image the hardware worked as expected.

----------------------------------------------------

IBBS seems to have dropped out of the valid mode combinations...
This is preventing use of batman on dual AP/adhoc nodes.

On an older AR9331 build..

root@TP-20:/etc# uname -a
Linux TP-20 3.3.8 #204 Tue Jun 18 08:55:58 EST 2013 mips GNU/Linux

iw list
valid interface combinations:
* #{ managed, WDS, P2P-client } <= 2048, #{ IBSS, AP, mesh point, P2P-GO } <= 8,
  total <= 2048, #channels <= 1

Now on the current openwrt trunk...

root@OpenWrt:/etc/config# iw list
Wiphy phy0
......

valid interface combinations:
* #{ managed, WDS, P2P-client } <= 2048, #{ AP, mesh point, P2P-GO }
<= 8, #{ IBSS } <= 1,
  total <= 2048, #channels <= 1, STA/AP BI must match
* #{ AP } <= 1,
  total <= 1, #channels <= 1, STA/AP BI must match, radar detect
widths: { 20 MHz (no HT), 20 MHz }


--
Jon Smirl
jonsmirl@gmail.com
