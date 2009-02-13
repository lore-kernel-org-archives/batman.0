MIME-Version: 1.0
In-Reply-To: <200902130029.48657.lindner_marek@yahoo.de>
References: <238a15490902111906g23358005v35fd57d8df857154@mail.gmail.com>
	<20090212125347.GA4074@pandem0nium>
	<238a15490902120658h4edb144bvc17db63a5b4a6f0a@mail.gmail.com>
	<200902130029.48657.lindner_marek@yahoo.de>
Date: Fri, 13 Feb 2009 14:58:03 -0600
Message-ID: <238a15490902131258r3f44f405m75ce70b7fff09738@mail.gmail.com>
From: Gargi Purohit <gaargie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Using batman L2 on multiple wireless cards
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

> Yes, batman has the concept of "main interface" (the first given interface) to
> reduce overhead but on the node that has 2 interfaces you should see both
> interfaces in the originator table (on a more distant host this might be
> different).
> Could you post the important lines from originators and explain the
> corresponding setup ?

Ok...now I get that...However I think not always I am able to
reproduce this scenario.  I have node A, node B, node C - each with 2
radios

--ch60---| A |---ch56---------ch56---| B |---ch40-------ch40---| C |---ch48
      (1C)..........(22)...............(20)............(21).................(1D).........(23)...

The terminating mac addresses for the radios are shown in ( )

My originator tables for node a, b, c are as follows:
For Node A
=======
root@OpenWrt:/# cat /proc/net/batman-adv/originators
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential nexthops .
00:02:6f:52:80:20  (255) 00:02:6f:52:80:20 [      ath1]: 00:02:6f:52:80:20 (255)
00:02:6f:52:80:1d  (177) 00:02:6f:52:80:20 [      ath1]: 00:02:6f:52:80:20 (177)
00:02:6f:52:80:21  (255) 00:02:6f:52:80:20 [      ath1]: 00:02:6f:52:80:20 (255)

For Node B
=======
root@OpenWrt:/# cat /proc/net/batman-adv/originators
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential nexthops .
00:02:6f:52:80:22  (255) 00:02:6f:52:80:22 [      ath1]: 00:02:6f:52:80:22 (255)
00:02:6f:52:80:1d  (250) 00:02:6f:52:80:1d [      ath0]: 00:02:6f:52:80:1d (250)
00:02:6f:52:80:1c  (255) 00:02:6f:52:80:22 [      ath1]: 00:02:6f:52:80:22 (255)

For Node C
=======
root@OpenWrt:/# cat /proc/net/batman-adv/originators
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential nexthops .
00:02:6f:52:80:1c  (241) 00:02:6f:52:80:21 [      ath0]: 00:02:6f:52:80:21 (241)
00:02:6f:52:80:21  (255) 00:02:6f:52:80:21 [      ath0]: 00:02:6f:52:80:21 (255)

I am wondering why

Node A: Cannot reach mac 23
Node B: Cannot reach mac 23
Node C: Cannot reach 20, 22

Should they be able to reach out "each of the radios" on "a node" or
"just one of the radios" on "the node". Sometimes they can and some
times they dont seem to..

For instance...
I am not sure if it is more of a radio issue than software problem...
