Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: John Sager <john@sager.me.uk>
Subject: Delay starting TCP connections across the mesh
Message-ID: <b2fd830e-1ffd-9575-a406-941d38d6cd7d@sager.me.uk>
Date: Mon, 27 Jul 2020 11:15:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Batman_adv list <b.a.t.m.a.n@lists.open-mesh.org>

I'm experimenting with a mesh network in the house. It has 4 nodes running 
batman_adv (BATMAN_IV) on stock OpenWrt 19.07.3 (i.e batman-adv-2019.2) on 
TP-Link WR902AC devices. The nodes mesh on 'mesh point' links on 2.4GHz and 
one node connects to the home wired network.

In the scenario, I have a laptop connected to the AP on one of the mesh 
nodes (not the gateway). I make a ssh connection from this to a host on the 
wired network. There is a consistent delay of about 8 seconds before the 
'password' prompt comes back from the remote host.

I rebuilt OpenWrt 19.07.3 for that device, and ticked all the debug options 
for batman-adv. Running tcpdump on both soft and hard interfaces, and 
trace-cmd to capture the debug info, I find the following:

The DNS request and response for the remote host name, and the consequent 
ARP request and response go through within milliseconds. However the TCP SYN 
is received by the bat0 interface but is not forwarded on the mesh0 
interface. SYN re-sends after 1 sec, then 2 sec are not forwarded either. 
Only the 3rd re-send (after another 4 sec) gets forwarded and then the ssh 
session proceeds normally.

Looking at the code, and after adding extra batadv_dbg() calls, I discover 
that the 'orig_node' returned by 'batadv_transtable_search()' on the dest 
address is NULL so the SYN gets thrown away by 'batadv_send_skb_unicast()'.

It is only after receiving an OGM message with a TT update for the remote 
host MAC from the gateway node that the local translation table gets 
populated with the remote host's MAC. I should say that I've set the 
'orig_interval' to 3000 to reduce batman traffic, so that probably has an 
effect on the delay.

I do wonder why the ARP response is not used to populate the translation 
table immediately, as an ARP response is always going to be followed 
immediately by returning IP packets. The ARPs are snooped for the 
distributed ARP table anyway so why not use that information for the 
translation table too?

regards,

John Sager

