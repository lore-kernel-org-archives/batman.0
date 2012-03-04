Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4F52D3B6.5060402@codigosur.org>
Date: Sat, 03 Mar 2012 23:30:14 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <4F51CA9D.2090404@codigosur.org> <4F51EF0B.5070501@codigosur.org>
	<4F51F168.7000605@codigosur.org>
	<201203031932.15663.lindner_marek@yahoo.de>
In-Reply-To: <201203031932.15663.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] routing loops on interconnected routers / adhoc
 + ethernet
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 03/03/2012 08:32 AM, Marek Lindner wrote:
> On Saturday, March 03, 2012 18:24:40 Nicol=E1s Ech=E1niz wrote:
>> On 03/03/2012 07:14 AM, Nicol=E1s Ech=E1niz wrote:
>>> On 03/03/2012 05:43 AM, Marek Lindner wrote:
>>>> You should not have loops either way but it is easy to build loops in =

>>>> complicated setups. At first we should understand your setup and=20
>>>> configuration. Drawing a little picture that shows what interface is
>>>> connected  to what other interface also can help.
>>>
>>>
>>>
>>> alright, I'll try some ascii art, but I'm afraid you'll find out my
>>> english is better :P
>>
>> holy s... I knew this wouldn't work
>>
>> I've uploaded the image here:
>> http://www.lavecindaria.org.ar/picture/esquema-de-enlaces/
>=20
> I got your drawing. Would it possible to also post the output of:
>  * brctl show
>  * batctl if
>  * batctl o
>=20
> We don't need it from all nodes. cisterna, marisa-mr and marisa-blt shoul=
d be=20
> enough.

Here you go:

############## marisa-mr ###############

root@marisa-mr:~# brctl show
bridge name	bridge id		STP enabled	interfaces
br-lan		8000.54e6fcb9cb39	no		eth1
							bat0
root@marisa-mr:~# batctl if
eth0: active
wlan0: active

root@marisa-mr:~# batctl o
[B.A.T.M.A.N. adv 2011.4.0, MainIF/MAC: wlan0/54:e6:fc:b9:cb:38 (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
  nicoyjesi_adhoc    0.140s   (231)   marisa-blt_eth0 [      eth0]:
cisterna_wlan1 (179)    cisterna_wlan0 (180)  marisa-blt_adhoc (188)
marisa-blt_eth0 (231)       nogal_wlan0 (131)
      nogal_wlan0    0.620s   (245)   marisa-blt_eth0 [      eth0]:
cisterna_wlan1 (191)    cisterna_wlan0 (188)  marisa-blt_adhoc (199)
marisa-blt_eth0 (245)       nogal_wlan0 (139)
   cisterna_wlan0    0.640s   (245)   marisa-blt_eth0 [      eth0]:
marisa-blt_adhoc (199)   marisa-blt_eth0 (245)    cisterna_wlan1 (220)
     nogal_wlan0 (118)    cisterna_wlan0 (215)
   cisterna_wlan1    0.390s   (222)    cisterna_wlan1 [     wlan0]:
marisa-blt_adhoc (199)   marisa-blt_eth0 (  0)    cisterna_wlan1 (222)
       czuk_wlan1    0.440s   (143)   marisa-blt_eth0 [      eth0]:
  nogal_wlan0 ( 84)  marisa-blt_adhoc (117)   marisa-blt_eth0 (143)
cisterna_wlan0 (153)    cisterna_wlan1 (138)
  marisa-blt_eth0    0.240s   (253)   marisa-blt_eth0 [      eth0]:
cisterna_wlan1 (202)    cisterna_wlan0 (201)  marisa-blt_adhoc (208)
   nogal_wlan0 (123)   marisa-blt_eth0 (253)
 marisa-blt_adhoc    0.450s   (209)  marisa-blt_adhoc [     wlan0]:
  nogal_wlan0 (119)    cisterna_wlan1 (187)    cisterna_wlan0 (186)
marisa-blt_adhoc (209)


############## marisa-blt ###############

root@marisa-blt:~# brctl show
bridge name	bridge id		STP enabled	interfaces
br-lan		8000.00156d3e2c4f	no		wlan0
							bat0
root@marisa-blt:~# batctl if
eth0: active
wlan0-1: active

root@marisa-blt:~# batctl o
[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: eth0/00:15:6d:3f:2c:4f (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
  nicoyjesi_adhoc    0.620s   (170)       nogal_wlan0 [   wlan0-1]:
cisterna_wlan1 (144)    cisterna_wlan0 (139)        czuk_wlan1 (  0)
   nogal_wlan0 (170)
   marisa-mr_eth0    0.950s   (129)    marisa-mr_eth0 [      eth0]:
marisa-mr_eth0 (129)
      nogal_wlan0    0.040s   (182)       nogal_wlan0 [   wlan0-1]:
marisa-mr_wlan0 ( 77)        czuk_wlan1 (  0)    cisterna_wlan1 (153)
 cisterna_wlan0 (149)    marisa-mr_eth0 ( 74)       nogal_wlan0 (182)
   cisterna_wlan0    0.780s   (238)    cisterna_wlan1 [   wlan0-1]:
marisa-mr_wlan0 (118)    marisa-mr_eth0 (110)       nogal_wlan0 (131)
     czuk_wlan1 (  0)    cisterna_wlan1 (238)    cisterna_wlan0 (231)
   cisterna_wlan1    0.420s   (238)    cisterna_wlan1 [   wlan0-1]:
marisa-mr_wlan0 (116)        czuk_wlan1 (174)    cisterna_wlan1 (238)
  marisa-mr_wlan0    0.000s   (138)   marisa-mr_wlan0 [   wlan0-1]:
   czuk_wlan1 (  0)       nogal_wlan0 (109)    cisterna_wlan1 (113)
cisterna_wlan0 (112)   marisa-mr_wlan0 (138)    marisa-mr_eth0 (133)
       czuk_wlan1    0.940s   (214)    cisterna_wlan1 [   wlan0-1]:
marisa-mr_wlan0 (103)    marisa-mr_eth0 ( 95)    cisterna_wlan0 (210)
 cisterna_wlan1 (214)        czuk_wlan1 (204)


############## cisterna ###############

root@cisterna:~# brctl show
bridge name	bridge id		STP enabled	interfaces
br-lan		8000.54e6fcb9bee7	no		eth0
							bat0
root@cisterna:~# batctl if
wlan0: active
wlan1: active

root@cisterna:~# batctl o
[B.A.T.M.A.N. adv 2011.4.0, MainIF/MAC: wlan0/54:e6:fc:b9:be:e8 (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
  nicoyjesi_adhoc    0.390s   (217)   marisa-mr_wlan0 [     wlan0]:
   czuk_wlan1 ( 58)        czuk_wlan1 (175)   marisa-mr_wlan0 (207)
marisa-mr_wlan0 (217)  marisa-blt_adhoc (205)  marisa-blt_adhoc (209)
      nogal_wlan0    0.850s   (223)   marisa-mr_wlan0 [     wlan0]:
   czuk_wlan1 (186)        czuk_wlan1 ( 62)       nogal_wlan0 (  0)
marisa-mr_wlan0 (216)   marisa-mr_wlan0 (223)  marisa-blt_adhoc (214)
marisa-blt_adhoc (216)
  marisa-mr_wlan0    0.050s   (250)   marisa-mr_wlan0 [     wlan0]:
   czuk_wlan1 ( 67)        czuk_wlan1 (201)  marisa-blt_adhoc (213)
marisa-blt_adhoc (215)   marisa-mr_wlan0 (239)   marisa-mr_wlan0 (250)
       czuk_wlan1    0.600s   (255)        czuk_wlan1 [     wlan1]:
marisa-mr_wlan0 (170)   marisa-mr_wlan0 (178)        czuk_wlan1 ( 85)
marisa-blt_adhoc (172)  marisa-blt_adhoc (168)        czuk_wlan1 (255)
  marisa-blt_eth0    0.090s   (232)   marisa-mr_wlan0 [     wlan0]:
   czuk_wlan1 (198)        czuk_wlan1 ( 66)   marisa-mr_wlan0 (225)
marisa-mr_wlan0 (232)  marisa-blt_adhoc (231)  marisa-blt_adhoc (227)
 marisa-blt_adhoc    0.730s   (231)  marisa-blt_adhoc [     wlan0]:
marisa-mr_wlan0 (216)   marisa-mr_wlan0 (227)        czuk_wlan1 ( 63)
     czuk_wlan1 (188)  marisa-blt_adhoc (231)  marisa-blt_adhoc (226)

######################################


> Please configure these nodes, so that they theoretically
> would produce the routing loop although it is not necessary to wait
> for the loop itself. As I understand it that loop occurs from time to
> time only?

By "from time to time" I meant that not every packet gets trapped in the
loop, but it's easily reproducible.

With marisa-mr_wlan0 activated, I get a looped traceroute just by
repeating the command a few times.

And here's a loop:

# batctl tr czuk_wlan1
traceroute to czuk_wlan1 (f8:d1:11:0b:76:4b), 50 hops max, 20 byte packets
 1: nogal_wlan0 (00:15:6d:d6:24:7a)  0.128 ms  0.133 ms  0.136 ms
 2: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  6.755 ms  4.468 ms  5.130 ms
 3: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  2.119 ms  1.603 ms  1.180 ms
 4: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  1.794 ms  1.544 ms  1.596 ms
 5: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  9.078 ms  6.598 ms  1.844 ms

[...]

44: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  10.385 ms  11.837 ms  13.225 ms
45: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  9.998 ms  11.833 ms  19.300 ms
46: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  10.659 ms  12.662 ms  11.318 ms
47: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  11.114 ms  17.455 ms  10.274 ms
48: marisa-mr_wlan0 (54:e6:fc:b9:cb:38)  17.981 ms  20.367 ms  14.605 ms
49: marisa-blt_eth0 (00:15:6d:3f:2c:4f)  11.862 ms  12.518 ms  14.096 ms


transfer speed (measured with iperf) between marisa and czuk drops to
0.5Mbit/s with this setup, from the 10Mbit/s we get when there are no loops.

The whole network experience is very poor in this setup, ssh sessions
lag a lot and drop from timeout, pings fail regularly and transfer speed
is impossible.

When marisa-mr_wlan0 is disabled, pings loose 0% end-to-end even with
big packets an 0.1s interval and transfer speed is quite good, around
5Mbit/s end to end and 30Mbit/s on the best links.


One other thing that took some time to learn (the hard way) is that the
network won't fully recover when we revert the changes in marisa-mr.
Loops are gone and pings are normal, but transfer speed sucks.
All related nodes (marisa-mr, marisa-blt, cisterna and czuk) need to be
restarted for the transfer speed to get back to normal. We assumed this
is some kind of problem with the wireles modules, ath9k and ath9k_htc
that we use, but it's just an assumption.



Let me know if you find anything unusual in the setup I sent you.


--
NicoEch=E1niz



>=20
> Regards,
> Marek

