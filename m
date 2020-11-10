Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Eth backhaul on mt7621 routers
From: haas@yahoo.com
Date: Tue, 10 Nov 2020 13:54:24 -0000
Message-ID: <20201110135424.1209.48828@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,
I've got BATMAN eth backhaul working on various qualcomm routers, but I've run into a problem on mt7621-based routers. Is this a known issue? I'm using the "master" of openwrt, which is kernel 5.4 at the moment.

Please see my post here describing the problem:
https://forum.openwrt.org/t/br-lan-not-working-on-mt7621-in-master-with-batman/77316

What's strange is that traffic flows fine over the eth backhaul between the two nodes, but only if it originates on the nodes themselves. Interfaces bridged to the bat0 interface can not send traffic over the eth backhaul. They do so just fine when bat0 is sending the traffic over a wireless mesh instead.

And there are even odder features such as arps getting through fine, and pings succeeding just after an arp packet, etc. See the forum thread for details please.

Any help would be greatly appreciated. I'm not sure how to debug this further.

