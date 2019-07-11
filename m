Return-Path: <kurschev@gmail.com>
MIME-Version: 1.0
From: Ricardo Cerrato <kurschev@gmail.com>
Date: Wed, 10 Jul 2019 22:44:07 -0500
Message-ID: <CAH-WULkD2g8KvzWT0=CxcvF5ja54p3qW_OZukM52gtoTkQXb_w@mail.gmail.com>
Subject: How to run batman-adv on interfaces in AP / Station mode?
Content-Type: text/plain; charset="UTF-8"
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

Hello all!

I recently configured a mesh with two nodes running Debian and
batman-adv and two wireless adapters TP-LINK TL-WN422G configured in
IBSS mode, and to allow non-mesh clients (like my cellphone) to use
the mesh I had to use another wireless adapter (same TL-WN422G)
configured in AP mode and bridged to the mesh interface (bat0).
Recently I found in the FAQ:

"Can batman-adv run on interfaces in AP / Station / etc mode ?
Q: Can BATMAN advanced run on interfaces in AP / Station mode?
A: Yes, because batman-adv doesn't know anything about stuff below the
ethernet interface. So you could also use it over layer 2 ethernet
tunnels, wifi ap, wifi sta, wifi adhoc, ethernet or even write a
virtual interface which prints everything on paper and scans the paper
on the remote machine (but you should be fast or increase the ogm
interval)."

I guess it is possible use the same adapter as AP and mesh client..
I my tests I found the AP mode and IBSS modes are mutually exclusive,
but I didn't find examples on how to create a mesh without IBSS...

Could you provide and example of configuration or some information
about how to do this?

I would like to create a mesh and allow non-mesh clients (like any
mobile) to connect and use a messenger service that will run over that
mesh and it would be great if every node of the mesh (using one
TL-WN422G adapter) can be also an AP for any client.

The adapters have the following supported modes and combinations:

Supported interface modes:
 * IBSS
 * managed
 * AP
 * AP/VLAN
 * monitor
 * mesh point
 * P2P-client
 * P2P-GO
 * outside context of a BSS

valid interface combinations:
 * #{ managed, P2P-client } <= 2, #{ AP, mesh point, P2P-GO } <= 2,
   total <= 2, #channels <= 1

I'm using Debian Stretch on the nodes

Thanks in advance!
