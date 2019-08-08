Return-Path: <moritzwarning@web.de>
From: Moritz Warning <moritzwarning@web.de>
Subject: batman_v default throughput
Message-ID: <dc998970-a36c-cbb5-8de5-2ed2a3833d57@web.de>
Date: Thu, 8 Aug 2019 23:05:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
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

Hi,

the Freifunk network in Ulm has a batman_V network of >80 nodes. [0]

For the map, we use the link throughput value from batman-adv to calculate a link value (capped at 40 MBit/s for 100%).
The default for VPN connections seem to be 1 MBit/s - when batman-adv doesn't know the throughput from the driver.

Is there a way to the set this throughput or can batman-adv measure it?

Thanks!

[0]: https://map11.freifunk-ulm.de/meshviewer
