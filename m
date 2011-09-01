Return-Path: <tracer@robotech.de>
Message-ID: <4E5F3F31.7000402@robotech.de>
Date: Thu, 01 Sep 2011 10:15:45 +0200
From: Tobias <tracer@robotech.de>
MIME-Version: 1.0
References: <4E5D69E3.30403@robotech.de>
	<CAKeC-QGag_c+g93MbiJWL9HB3iOczbfbatYUAA1wEEFSyvyd2g@mail.gmail.com>
	<20110831160712.GC25149@ritirata.org>
	<201108311816.23147.lindner_marek@yahoo.de>
	<20110831161833.GD25149@ritirata.org>
	<4E5E69DB.5060007@robotech.de>
	<20110831215506.GA27165@ritirata.org>
In-Reply-To: <20110831215506.GA27165@ritirata.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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

Am 31.08.2011 23:55, schrieb Antonio Quartulli:
>> [     25706] Creating new global tt entry: 00:02:81:b9:4c:c8 (via
>> 0a:18:84:1e:f6:05)
>> [     25707] Creating new global tt entry: 18:84:1e:f6:05:01 (via
>> 0a:18:84:1e:f6:05)
>> [     25707] Creating new global tt entry: 04:11:80:e4:a8:c8 (via
>> 0a:18:84:1e:f6:05)
> Here there is something strange..Do you know where do these macs belong
> (00:02:81:b9:4c:c8, 04:11:80:db:48:c8, 18:84:1e:f6:05:01)? Do you have clients
> connected to the mesh through the batman-adv nodes?
>
> Cheers,
> Antonio
I just looked on every node in the network and can't find any nodes with 
these macs.
ifconfig | grep -i "4c:c8\|05:01\|48:c8" ; arp  | grep -i 
"4c:c8\|05:01\|48:c8"

ATM there are only the mesh-nodes, one internet-router and a camera 
connected. The router is in the middle and the camera on one end. (3-4 
hops from the internet-router)

Well, i can't reach the camera right now - i have to reset the node maybe...

When everything is working i get a HD-picture from the camera every 
second. So the connection is good (when it's working...)

I notices another mac 04:11:81:b9:42:c8 and looked in the log of node bat54:
root@fon-53:~# batctl l | grep "42:c8"
[     87390] Creating new global tt entry: 00:02:81:b9:42:c8 (via 
5e:e6:fc:ae:55:a8)
[     87390] Deleting global tt entry 00:02:81:b9:42:c8 (via 
5e:e6:fc:ae:55:a8): originator time out

the via is from bat51 - unfortunately i dont have loggin on that node - 
i'll install a different image later

funny thing is bat49 which is directly connected to bat51...
root@1043-49:~# batctl o
[B.A.T.M.A.N. adv 2011.3.0, MainIF/MAC: wlan2/9e:0c:6d:ee:7c:ba (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
             bat60    7.640s   ( 79)             bat51 [     
wlan2]:             bat59 (  7)             bat51 ( 79)
             bat58    0.160s   ( 75)             bat51 [     
wlan2]:             bat60 (  0)             bat59 ( 10)             
bat51 ( 75)
             bat51    0.190s   (230)             bat51 [     
wlan2]:             bat59 (  0)             bat51 (230)
             bat67    4.750s   ( 83)             bat51 [     
wlan2]:             bat59 (  0)             bat51 ( 83)
             bat53    0.330s   ( 86)             bat51 [     
wlan2]:             bat60 (  0)             bat59 ( 12)             
bat51 ( 86)
             bat52    4.070s   (137)             bat51 [     
wlan2]:             bat59 (  4)             bat51 (137)
             bat54    0.610s   ( 83)             bat51 [     
wlan2]:             bat59 (  7)             bat51 ( 83)
             bat59    9.220s   ( 93)             bat51 [     
wlan2]:             bat59 ( 10)             bat51 ( 93)
             bat55   14.470s   ( 81)             bat51 [     
wlan2]:             bat59 (  6)             bat51 ( 81)

...does hear different broadcasts:
root@1043-49:~# batctl l | grep "42:c8"
[     80123] Creating new global tt entry: 04:11:81:b9:42:c8 (via 
0a:18:84:1e:f6:05)
[     80124] Deleting global tt entry 04:11:81:b9:42:c8 (via 
0a:18:84:1e:f6:05): originator time out
[     80168] Creating new global tt entry: 00:02:81:b9:42:c8 (via 
0a:18:84:1e:f6:05)
[     80168] Deleting global tt entry 00:02:81:b9:42:c8 (via 
0a:18:84:1e:f6:05): originator time out
[     80182] Creating new global tt entry: 00:02:81:b9:42:c8 (via 
0a:18:84:1e:f6:05)
[     80183] Deleting global tt entry 00:02:81:b9:42:c8 (via 
0a:18:84:1e:f6:05): originator time out
[     80197] Creating new global tt entry: 00:02:81:b9:42:c8 (via 
0a:18:84:1e:f6:05)
[     80198] Deleting global tt entry 00:02:81:b9:42:c8 (via 
0a:18:84:1e:f6:05): originator time out

These "via"-mac points back to bat53 but in the log of bat53 i only see 
that they are comming "via" bat51.

There is nothing connected to bat51 or bat53 - both are wifi-only and 
nobody can connect to them atm (except the mesh)

Why does it create a global tt entry and delete it a second later?

Tobias


