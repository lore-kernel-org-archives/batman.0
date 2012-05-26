Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 26 May 2012 22:54:57 +0800
References: <4fc0a063.2a04440a.04d9.ffffbef5@mx.google.com>
In-Reply-To: <4fc0a063.2a04440a.04d9.ffffbef5@mx.google.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201205262254.58262.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Can't create new originator
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: "puyou.lu" <puyou.lu@gmail.com>


Hi,


> I saw strange batman logs while testing a batman-adv mesh. Batman-adv
> module was continuously generating the same logs including a " Creating
> new originator: b0:c6:9b:80:01:43". But b0:c6:9b:80:01:43 never appears in
> the output of 'batctl o': admin@HND-Mesh:~# batctl o
> [B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: wlan0/b0:c6:9b:80:01:5b (bat0)]
>   Originator      last-seen (#/255)           Nexthop
> [outgoingIF]:   Potential nexthops ... b0:c6:9b:80:01:5c    0.010s   (255)
> b0:c6:9b:80:01:5c [     wlan0]: b0:c6:9b:80:01:5f (209) b0:c6:9b:80:01:6b
> (231) b0:c6:9b:80:01:6b (227) b0:c6:9b:80:01:5c (255) b0:c6:9b:80:01:5c
> (  0) b0:c6:9b:80:01:45    3.830s   (223) b0:c6:9b:80:01:5f [     wlan0]:
> b0:c6:9b:80:01:5c (209) b0:c6:9b:80:01:6b (  0) b0:c6:9b:80:01:6b (  0)
> b0:c6:9b:80:01:5f (223) b0:c6:9b:80:01:6b    4.520s   (255)
> b0:c6:9b:80:01:6b [     wlan0]: b0:c6:9b:80:01:5f (206) b0:c6:9b:80:01:5c
> (245) b0:c6:9b:80:01:6b (255) b0:c6:9b:80:01:6b (251)
> b0:c6:9b:80:01:3b    1.570s   (237) b0:c6:9b:80:01:5f [     wlan0]:
> b0:c6:9b:80:01:5c (226) b0:c6:9b:80:01:6b (  0) b0:c6:9b:80:01:6b (  0)
> b0:c6:9b:80:01:5f (237) b0:c6:9b:80:01:5f    3.520s   (255)
> b0:c6:9b:80:01:5f [     wlan0]: b0:c6:9b:80:01:6b (231) b0:c6:9b:80:01:6b
> (227) b0:c6:9b:80:01:5c (244) b0:c6:9b:80:01:5f (255)
> 
> Now I can nerver reach b0:c6:9b:80:01:43. Anyone tell me why this happens?

according to your logs OGMs from b0:c6:9b:80:01:43 are received via nodes that 
are not in your routing table either:
 * b0:c6:9b:80:01:57
 * b0:c6:9b:80:01:6c

Therefore you see the warning: Drop packet: OGM via unknown neighbor!
Batman-adv can't create a route to a an originator without having a next hop. 

Do all nodes in your network run the same batman-adv version (2012.0.0) ?

Regards,
Marek

