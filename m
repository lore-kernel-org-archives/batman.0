Return-Path: <roland.volkmann@t-online.de>
From: Roland Volkmann <roland.volkmann@t-online.de>
Message-ID: <56F5AF2F.6060904@t-online.de>
Date: Fri, 25 Mar 2016 22:35:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

when having Nodes with wired Mesh-Links, or on point-to-point 
connections, rebroadcasts on the same interface are unnecessary, because 
all Nodes receive the broadcast packets at the same time.

On non-gateway nodes (Freifunk-Routers) running firmware "Gluon", there 
is a patch from Linus Lüssing adding the feature/option 
"mesh_no_rebroadcast" to batman-adv, which is enabled by default on 
mesh_vpn interface. Because of the good experience reducing traffic also 
on other wired mesh links (Mesh-on-LAN / Mesh-on-WAN), this option will 
also be enabled there by default with the upcoming Gluon v2016.2.

Gatways are not running Gluon, but typically Debian Linux, and there the 
option "mesh_no_rebroadcast" does not exist on batban-adv.

Are there some (other) features already implemented in batman-adv to 
prevent rebroadcast of unnecessary mesh packets?

If not, what is the chance to have the functionality implemented by the 
mentioned patch as part of the original code base?

Background:

At Freifunk-Stuttgart we have multiple distributed gateways connected by 
layer2-tinc, which is logically the same situation as using LAN-Cables 
and physical Switch. Avoiding rebroadcast will reduce traffic between 
the gateways.

Additional info:

On 12.03.2015 Ticket #207 was opened by Ruben Kelevra relating the same 
issue, but immediately closed due to formal error.


Best regards,
Roland.

