Return-Path: <feanpg@gmail.com>
Message-ID: <52020C25.9080705@gmail.com>
Date: Wed, 07 Aug 2013 10:58:13 +0200
From: Fernando Pizarro <feanpg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] DAT issue
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hi all!

I'm playing with OpenWRT and BATMAN advance and I had configured one 
essid to serve dynamic vlans via freeradius reply attributes.

I have a bridge (br0) with bat0, wireless and ethernet interface, and 
hostapd creates a new bridge by vlan (brvlanX) with vlanX and wlan1.X 
succefully. Br0 has configured a VLAN and IP to connect with every other 
nodes. There is the same explanation, but schematic:

Wireless:

phy0 -> wlan0 -> bat0
phy1 -> wlan1 -> wlan1.1
                      \ --> wlan1.N

Hostapd bridge:

wlan1 -> brvlan1 -> {wlan1.1; vlan1}
       \ --> brvlanN -> {wlan1.N; vlanN}

Ethernet bridge:

br0 -> {bat0; eth0; wlan1}
    \ --> br0.X == IP/NETMASK

When I look at batman dat table there aren't any registry, but variuos 
stations are connected. Why is that? What's wrong in my config?

Thanks a lot.
Fernando.
