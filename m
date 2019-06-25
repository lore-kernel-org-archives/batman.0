Return-Path: <faycel.benhajkhalifa@eisox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jun 2019 10:21:40 +0200
From: faycel.benhajkhalifa@eisox.com
Subject: Problem with routing table
Message-ID: <22df3eaaaf123e7eb767ec7c0959cbfd@eisox.com>
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

Hello
I have a problem with setting up the routing table
the use case
I have 4 node with batman batctl 2018.1 [batman-adv: 2018.1] on openwrt 
18.06.1
2 nodes that serve the internet (connected directly with cable)
when a node that shares the internet is dead the other node can't ping 
the internet  unless the dead node no longer exists in its database 
neighbors (it does not appear in the results of batctl o and batctl n ) 
on average it takes a little more than 200 s to reconnect to the 
internet.
my questions are:
   Is it possible to update the routing table faster?
   Does it have anything to do with 200s to detect that a node and dead ?
thank you
cordially
faycel bhk
