Return-Path: <ordex@autistici.org>
Date: Thu, 1 Sep 2011 17:55:46 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110901155545.GA840@ritirata.org>
References: <4E5D69E3.30403@robotech.de>
	<CAKeC-QGag_c+g93MbiJWL9HB3iOczbfbatYUAA1wEEFSyvyd2g@mail.gmail.com>
	<20110831160712.GC25149@ritirata.org>
	<201108311816.23147.lindner_marek@yahoo.de>
	<20110831161833.GD25149@ritirata.org>
	<4E5E69DB.5060007@robotech.de>
	<20110831215506.GA27165@ritirata.org>
	<4E5F3F31.7000402@robotech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4E5F3F31.7000402@robotech.de>
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

Hello,

On Thu, Sep 01, 2011 at 10:15:45 +0200, Tobias wrote:
> I just looked on every node in the network and can't find any nodes with 
> these macs.
> ifconfig | grep -i "4c:c8\|05:01\|48:c8" ; arp  | grep -i 
> "4c:c8\|05:01\|48:c8"
> 
> ATM there are only the mesh-nodes, one internet-router and a camera 
> connected. The router is in the middle and the camera on one end. (3-4 
> hops from the internet-router)

ok. It seems there is a bug somewhere :-)
Can you again copy/paste this creating/deleting part of the node log and tell me
which is the correct bat0 MAC address of the node announcing the change?

E.g:
on fon-53 you have this log:
 > [     87390] Creating new global tt entry: 00:02:81:b9:42:c8 (via 
 > 5e:e6:fc:ae:55:a8)
 > [     87390] Deleting global tt entry 00:02:81:b9:42:c8 (via 
 > 5e:e6:fc:ae:55:a8): originator time out

then go on node 5e:e6:fc:ae:55:a8 and write down its bat0 MAC address, please.
Moreover, is bat0 bridged with any other interface (e.g. bat0 + eth0 within br0?)

> Why does it create a global tt entry and delete it a second later?

1 second is the OGM interval. It seems there is some inconsistency in the CRC
check which is done on OGM receive (1 per sec). In case of inconsistency the
node asks for an update. When receiving the response the node deletes the whole
table (in this case) and refill it with the information contained in the
response message.

Cheers, 
Antonio
