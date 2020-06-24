Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <927533E5-C265-44BF-B271-1A7A9A084447@xecoenergy.com>
 <8393812.UZvHzlbVaM@sven-edge> <E3FD8A72-966A-4CBB-A036-8C0A4152983D@xecoenergy.com>
 <2094569.NUmnuQNPM9@sven-edge> <FE41926B-5684-45D8-B9AE-17D46DA1C8C7@xecoenergy.com>
In-Reply-To: <FE41926B-5684-45D8-B9AE-17D46DA1C8C7@xecoenergy.com>
From: Mark Birss <markbirss@gmail.com>
Date: Wed, 24 Jun 2020 23:01:30 +0200
Message-ID: <CADg1mwK62tGw8kkXSYpZ2H2XOmCWa21L29YnJ3AyNih15+1vMw@mail.gmail.com>
Subject: Re: batadv gw_mode client 0?
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi

I don't want to hi-jack your initial conversation here.

I just recently been using BATMAN-adv over ethernet

So yes BATMAN_V shows link speed throughput 1000Mbps  for me instead
of #255 with BATMAN-VI

I wanted to ask about debugging also, what other debug if any options
are there that i can use ?

I have enabled


echo "CONFIG_BATMAN_ADV_DEBUG=y" >> .config
echo "CONFIG_BATMAN_ADV_DEBUGFS=y" >> .config
echo "CONFIG_BATMAN_ADV_BLA=y" >> .config
echo "CONFIG_BATMAN_ADV_DAT=y" >> .config
echo "CONFIG_BATMAN_ADV_MCAST=y" >> .config
echo "CONFIG_BATMAN_ADV_NC=n" >> .config
echo "CONFIG_BATMAN_ADV_BATMAN_V=y" >> .config
echo "CONFIG_BATMAN_ADV_SYSFS=y" >> .config
echo "CONFIG_BATMAN_ADV_TRACING=y" >> .config


echo 255 > /sys/class/net/bat0/mesh/log_level
cat /sys/kernel/debug/batman_adv/bat0/log



since i want to understand why on wifi mesh seems to crash for me ath10k


On Wed, Jun 24, 2020 at 10:42 PM Rob Cowart <rob.cowart@xecoenergy.com> wrote:
>
>
>
> > On Jun 24, 2020, at 3:13 PM, Sven Eckelmann <sven@narfation.org> wrote:
> >
> > On Wednesday, 24 June 2020 22:02:38 CEST Rob Cowart wrote:
> > [....]
> >> Is anything wrong with these?
> >
> > Most likely not, but someone on the mailing list with deeper knowledge on
> > B.A.T.M.A.N. V's echo location protocol could actually check whether non-
> > symmetric settings on different nodes could create problems or not. Or if
> > having both ELP and OGM2 interval set to the same value could have negative
> > side effects.
> >
> >
> >> Our gateway:
> >>
> >> pi@raspberrypi:~/xeco-master/enola-daemon $ cat /sys/class/net/wlan0/batman_adv/elp_interval
> >> 500
> >> pi@raspberrypi:~/xeco-master/enola-daemon $ cat /sys/class/net/bat0/mesh/orig_interval
> >> 1000
> >>
> >> nodes:
> >> pi@raspberrypi:~ $ cat /sys/class/net/wlan0/batman_adv/elp_interval
> >> 30000
> >> pi@raspberrypi:~ $ cat /sys/class/net/bat0/mesh/orig_interval
> >> 30000
> > [...]
> >
> > On Wednesday, 24 June 2020 21:23:09 CEST Rob Cowart wrote:
> >> IF             Neighbor              last-seen
> >> b8:27:eb:4e:73:6d   25.330s (        1.0) [     wlan0]
> >> b8:27:eb:ff:0e:b6   23.320s (        1.0) [     wlan0]
> >> b8:27:eb:08:13:37   18.850s (        1.0) [     wlan0]
> >> b8:27:eb:aa:1e:6d   37.010s (        1.0) [     wlan0]
> >> b8:27:eb:35:c6:77   63.590s (        1.0) [     wlan0]
> >> b8:27:eb:e9:34:41   18.280s (        1.0) [     wlan0]
> >> b8:27:eb:84:ca:90   30.560s (        1.0) [     wlan0]
> >> b8:27:eb:1e:eb:cd   27.410s (        1.0) [     wlan0]
> >> b8:27:eb:cb:80:34   23.100s (        1.0) [     wlan0]
> >
> > Btw. it looks to me like B.A.T.M.A.N. V is a really bad choice for your setup.
> > All links have the throughput value 1.0 Mbit/s. This sounds to me like the
> > wifi driver doesn't provide the required expected_throughput. And so you have
> > a REALLY, REALLY, REALLY bad metric when you are using 1.0 everywhere. So if
> > you want to continue experimenting with B.A.T.M.A.N. V then you should try to
> > get this fixed in your wifi driver or just switch to B.A.T.M.A.N. IV with
> > increased multicast rate.
> Are there any docs that talk about what B.A.T.M.A.N. V vs B.A.T.M.A.N. IV is good for?  The decision to upgrade was made before I got here, I'm not sure anyone understood that IV would still be supported/expected to be used.
> >
> >
> >> Lots of stuff I don't understand here, looks like loopback is very busy?
> >
> > Not sure what you mean here with loopback. I will just leave the whole output
> > here in case somebody else on the mailing list wants to figure it out.
> >
> >> pi@raspberrypi:~/xeco-master/enola-daemon $ sudo batctl td wlan0
> >> 15:01:52.075412 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 704843962, v 15, interval 500ms, length 20
> >> 15:01:52.076036 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.076507 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.076854 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.077456 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.077937 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.078028 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.078657 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.079155 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.079246 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.079894 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.080480 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.080965 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.081435 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.081904 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.081995 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.082435 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.082539 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.082957 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >> 15:01:52.415359 BAT b8:27:eb:fb:4e:58: OGM2 via neigh b8:27:eb:fb:4e:58, seq 500807384, throughput MAX, ttl 50, v 15, length 60, tvlv_len 40
> >>      TVLV TTv1: OGM DIFF [.] ttvn=1 vlan_num=1 entry_num=0
> >>              VLAN ID -1, crc 0xf0cfd284
> >>      TVLV GWv1: down 10.0Mbps, up 2.0Mbps
> >>      TVLV DATv1: enabled
> >> 15:01:52.423153 BAT b8:27:eb:fb:4e:58: OGM2 via neigh b8:27:eb:aa:1e:6d, seq 500807384, throughput 15.0Mbps, ttl 49, v 15, length 60, tvlv_len 40
> >>      TVLV TTv1: OGM DIFF [.] ttvn=1 vlan_num=1 entry_num=0
> >>              VLAN ID -1, crc 0xf0cfd284
> >>      TVLV GWv1: down 10.0Mbps, up 2.0Mbps
> >>      TVLV DATv1: enabled
> >> 15:01:52.424280 BAT b8:27:eb:fb:4e:58: OGM2 via neigh b8:27:eb:cb:80:34, seq 500807384, throughput 14.9Mbps, ttl 49, v 15, length 60, tvlv_len 40
> >>      TVLV TTv1: OGM DIFF [.] ttvn=1 vlan_num=1 entry_num=0
> >>              VLAN ID -1, crc 0xf0cfd284
> >>      TVLV GWv1: down 10.0Mbps, up 2.0Mbps
> >>      TVLV DATv1: enabled
> >> 15:01:52.428556 BAT b8:27:eb:fb:4e:58: OGM2 via neigh b8:27:eb:84:ca:90, seq 500807384, throughput 15.0Mbps, ttl 49, v 15, length 60, tvlv_len 40
> >>      TVLV TTv1: OGM DIFF [.] ttvn=1 vlan_num=1 entry_num=0
> >>              VLAN ID -1, crc 0xf0cfd284
> >>      TVLV GWv1: down 10.0Mbps, up 2.0Mbps
> >>      TVLV DATv1: enabled
> >> 15:01:52.575301 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 704843963, v 15, interval 500ms, length 20
> >> 15:01:52.575486 BAT b8:27:eb:fb:4e:58: ELP via iface b8:27:eb:fb:4e:58, seq 0, v 15, interval 0ms, length 200
> >
> > Kind regards,
> >       Sven
