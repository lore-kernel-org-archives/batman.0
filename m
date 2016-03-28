Return-Path: <roland.volkmann@t-online.de>
References: <56F5AF2F.6060904@t-online.de> <1575797.YB1vrtWgyD@sven-edge>
 <56F5C782.6050009@t-online.de> <6005839.o5jWIFZeG0@voltaire>
From: Roland Volkmann <roland.volkmann@t-online.de>
Message-ID: <56F934F9.5000508@t-online.de>
Date: Mon, 28 Mar 2016 15:43:21 +0200
MIME-Version: 1.0
In-Reply-To: <6005839.o5jWIFZeG0@voltaire>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, b.a.t.m.a.n@lists.open-mesh.org

Hi Marek,

> if you are advocating in favor of this patch I see no real need to wait for
> Linus. Maybe you can help us understand what this patch does and why it is
> useful. These were the questions raised in https://patchwork.open-mesh.org/patch/4384/ and remain unanswered till today.
>
> I am also unclear why this old patch is re-hashed once more since we merged a
> patch 3 years ago achieving the same goal without a manual knob. Can somebody
> shed some light on this ?
>
> The patch in question:
> commit cc1fde312b6d3c010784a80aff9e942e3b16d015
> Author: Matthias Schiffer <mschiffer@universe-factory.net>
> Date:   Sat Mar 9 23:14:23 2013 +0100
> Subject: batman-adv: send each broadcast only once on non-wireless interfaces

this patch/commit addresses another issue than the "new" request 4384: 
it limits the number of broadcasts to be transmitted on an interface, 
with the limit automatically adjusting depending of type of interface.

Request 4384 allows to suppress broadcast packets completely on the 
interface, where the node has received them (no rebroadcast). This is 
typical behavior of physical switches, where broadcasts are sent out to 
all ports except the one, where the packet was received.

In Freifunk-Environments we have various types of links, and you cannot 
determine automatically the interfaces, where you need rebroadcast and 
where rebroadcasts should be suppressed. Some examples:

When having Nodes meshing on WLAN (one WLAN Interface per Node) you need 
rebroadcasts. If using fastd-VPN connections or tinc without forwarding 
enabled and without full meshing you also need rebroadcast.

But when connecting nodes with LAN-Cable and physical switch, or using 
tinc with forwarding enabled, or having point-to-point connections, 
especially WiFi longshots or PowerLAN-Adapters or other low bandwidth 
connections, the rebroadcasts will waste bandwith and/or air time.

Therefore we would prefer to have this setting as a manual setting, 
default to rebroadcast being enabled.

This patch is present in Gluon for quite some time now and considered 
stable. In practice we can save significant bandwith and ressources on 
the Nodes in local mesh clouds having mesh-on-lan with multiple nodes 
(and clients). Because of this experience on non-gateway nodes we also 
want to use this feature on gateways without gluon, if multiple gateways 
are meshed.

If you need more information, please let me know.

Best regards,
Roland.

