Return-Path: <moritzwarning@web.de>
From: Moritz Warning <moritzwarning@web.de>
Subject: maximum hop count
Message-ID: <db951dbb-7ec9-6938-faa7-bf2b46eeda30@web.de>
Date: Thu, 16 Apr 2020 14:26:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

I run a simulation of 50 batman-adv instances connected on a chain topology:

[node-0] <-> [node1] <-> ... <-> [node49]

Despite there being no packet loss, the nodes at both ends (nodes 0 and 49) only see 32 other nodes.

The second outermost nodes see 33 other nodes and so on until the nodes that are at least 18 hops from both ends (nodes 17 and 32), which see all other 49 nodes.

The OGM TTL is set to 50 [1], but from this experiment, the TTL seems to be 32.

Can someone shed light on this observation?
The batman-adv version used is 2019.4.

Thanks,
Moritz


[0] https://github.com/mwarning/meshnet-lab
[1] https://git.open-mesh.org/batman-adv.git/blob/refs/heads/master:/net/batman-adv/main.h#l26
