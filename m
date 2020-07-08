Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: Batman_V Originator Loop Issue
From: lavincent15@gmail.com
Date: Wed, 08 Jul 2020 14:44:07 -0000
Message-ID: <20200708144407.1176.97484@diktynna.open-mesh.org>
In-Reply-To: <5716273.fDpRzsxG9E@prime>
References: <5716273.fDpRzsxG9E@prime>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

"can you please describe which nodes are connected to the LAN and which are
not? You say "one is connected to LAN" and the others are "operating as an"

00:30:1a:4e:b8:26 is the only node that is connected via eth0 to my LAN. All three nodes are running mesh point and AP on mesh0 and wlan0 respectively.

"If multiple nodes are connected and bridged to the same LAN, bridge loop
avoidance should be enabled - you have that in your config, but you could
double check with "batctl bl" and then "batctl bbt"/"batctl
cl" (please post
these tables if you think this could be connected).
You could also try disabling distributed arp table and multicast mode, just to
make sure this is not shooting us in the foot here. Those optimizations are
not really needed for such a small network."

I see. Since I only have one node connected to LAN via eth0, I do not need bla. I just tried disabling multicast, bla, and arp table. So far so good! It's working. Thank you so much for the help!
