Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 18 Dec 2015 14:43:48 +0100
Message-ID: <1571704.ljWJ4IIlsa@sven-desktop>
In-Reply-To: <CAKrZ8yd4vy36ZXuEa4iN80mvuE92Pa1inG6BQwXsL+2gUBsgqQ@mail.gmail.com>
References: <CAKrZ8yfKQi8qBzmC7BrEA6Sfug9JB4hb5q_M6p20Ay-V35-F4A@mail.gmail.com>
 <C3123DAF-BBD2-4477-81B6-B3F57169DE3C@vfn-nrw.de>
 <CAKrZ8yd4vy36ZXuEa4iN80mvuE92Pa1inG6BQwXsL+2gUBsgqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] Super high package loss and weak connection
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

On Friday 18 December 2015 14:23:24 no name wrote:
> Hello Ruben thanks for your help!
> 
> root@BASE2:~# batctl o
> [B.A.T.M.A.N. adv 2015.2, MainIF/MAC: wlan0/40:a5:ef:06:8d:74 (bat0
> BATMAN_IV)] Originator      last-seen (#/255)           Nexthop
> [outgoingIF]: Potential nexthops ...
> 7c:dd:90:79:e6:19    7.700s   (107) 7c:dd:90:79:e6:19 [     wlan0]:
> 7c:dd:90:79:b5:f2 ( 33) 00:23:54:b4:c4:6f ( 27) 7c:dd:90:79:e6:19
> (107)
> 7c:dd:90:79:b5:f2    6.840s   (104) 7c:dd:90:79:b5:f2 [     wlan0]:
> 00:23:54:b4:c4:6f ( 15) 7c:dd:90:79:e6:19 ( 46) 7c:dd:90:79:b5:f2
> (104)
> 00:23:54:b4:c4:6f    4.580s   ( 66) 7c:dd:90:79:e6:19 [     wlan0]:
> 7c:dd:90:79:b5:f2 ( 31) 7c:dd:90:79:e6:19 ( 66) 00:23:54:b4:c4:6f (
> 45)
> 
> This is the output from batctl o

These number look really bad. Looks like the wifi links between the nodes are 
basically not working. You can check the signal of the links via `iw dev wlan0 
station dump` but there is (most likely) nothing which can be done from the 
batman-adv side. First you have to fix your wifi links.

I have no idea what these LOGILINK WL0084B are using or how good they are 
(they look rather crappy regarding the antennas but please correct me).  If 
you want to try a different mode (in case Adhoc is broken in this driver) then 
you can try to use meshpoint (802.11s) without the routing enabled. I think 
this was done like this:

    iw phy phy0 interface add $MESH_IFACE type mp
    iw dev $MESH_IFACE set mesh_param mesh_ttl 1
    iw dev $MESH_IFACE set mesh_param mesh_fwding 0
    iw dev $MESH_IFACE mesh join $MESH_ID

Kind regards,
	Sven
