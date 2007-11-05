Date: Mon, 5 Nov 2007 22:14:19 +0100
Message-ID: <000b01c81ff0$d7ed14b0$87c73e10$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Subject: [B.A.T.M.A.N.] 0.3-beta-rv779 and rv780
Reply-To: pele@balorda.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: B.A.T.M.A.N@open-mesh.net

My test setup comprises 3 dual-radio (a and bg) units running openwrt
kamikaze 7.09.

For some reason (or another?) my middle unit keeps re-creating the gate0
every few seconds. Sometimes it loses it completely and sometimes it keeps
it for 10 seconds or so. The furthest node from the gw keeps it's tunnel
permanently configured (which is nice).

Basically, node-to-node traffic is ok, very stable and very nice but
node-through-gw is flaky.
 
This above is with bg-only radios.

Also I have tried using a dual-radio setup. I have tried to set bg-radios to
one subnet and a-radios to a different one, I have also
Tried setting them all on the same subnet but all hell breaks loose. I don't
know if it's loops or what but it doesn't seem usable to me.


Yes I know I'm playing with 0.3beta and exp but I believe this would be a
far more usable setup than olsr 5.3 that I also tried.

Any help appreciated in solving this issue.

Pele

