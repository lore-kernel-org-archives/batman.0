Return-Path: <andrey.palade@googlemail.com>
MIME-Version: 1.0
From: Andrei Palade <andrey.palade@googlemail.com>
Date: Mon, 16 May 2016 19:05:26 +0100
Message-ID: <CAMhRkFz_rcFpa1P7BC2WG7o6omg8s9Vsw_9QX1dB3Wa4vBGiCw@mail.gmail.com>
Subject: Node movement
Content-Type: text/plain; charset=UTF-8
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

I installed batman-adv on 4-Raspberry Pi Model 3, and I now want to
emulate an out of reach situation. Instead of physically moving the
PIs into another room, I want to use some mechanism that will do this
for me. I ran the following command on node D:

ip6tables -A INPUT -m mac --mac-source XX:XX:XX:XX:XX:XX -j DROP

where the MAC source is the MAC address of wlan0 of node A.

For instance, I have A, B, C, D each running batman-adv, I want to
route all the traffic from node A to node D through node C. Now I
can't login into D, and the route tables do not show any change (i.e.,
batctl o).

Did I approached this correctly? Basically what I want to do is from
A, B, C, D, to be able to route packages from A to D through C,
instead of physically moving D out of reach of A. How do I do this,
and how can I check if it works?


-- 
Andrei
