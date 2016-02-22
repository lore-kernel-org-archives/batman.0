Return-Path: <laurent@wifibot.com>
From: laurent <laurent@wifibot.com>
Message-ID: <56CAE7C9.1070006@wifibot.com>
Date: Mon, 22 Feb 2016 11:49:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] BATMAN-V for robotics
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello,

After some failure last year to us BATMAN-ADV on picostation plugged in 
a mobile robot. I have re flashed last week the last open-wrt with the 
last stable batman-adv (2006.0).
I still have some problem making a single hop fast.  I have 3 nodes A B 
C, I put the robot (nodeB) very close to node C and A is fare from B and 
C.  B is still connecting directly to A. sometime If I wait for a very 
long time
the route became A - C - B , what I exactly want. I have this behavior 
since 2010 and on each version I test on picostation.

To resume, when the robot along 2 nodes and it takes a very long time 
before he got a new route to increase his range.

I understand but I could be wrong, that the metric calculation in 
BATMAN-IV is not good for mobile application because of some radio that 
keeps the link until the last minute before beginning to increase their 
packet errors ?

BATMAN-V seems to be more promising because of the new metric 
calculation based on link throughput we get from the driver, and also 
because we can override the data throughput value to force a route (we 
are imagining using GPS for that).

I really want to test BATMAN-V,  I tried to switch to BATMAN-V but it 
was not on the available routing algorithm list. Do I need to compile a 
devel version on open-wrt ?

Thank you,

Best Regards,

Laurent
