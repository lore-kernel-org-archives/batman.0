Return-Path: <gui@altermundi.net>
Message-ID: <5275E492.2000608@altermundi.net>
Date: Sun, 03 Nov 2013 06:52:18 +0100
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] alfred hook to run when new information is received?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hey Simon,
until sarcasmarec ideas come true... ;)
[(2013/10/14) marec: d0tslash: we should release some more daemons]
we're doing our best to convince current daemons to turn *more* evil, in 
the meanwhile

turns out, we're trying to propagate dnsmasq dhcp leases over the 
network with alfred
[1]: 
http://lists.thekelleys.org.uk/pipermail/dnsmasq-discuss/2013q4/007750.html

with the current 'alfred-facters' 5-minute cronjob (or any cronjob, 
yeah) we can send a reload signal to dnsmasq at an acceptably short 
interval. Nevertheless, something more realtime would be highly 
desirable in this case

some kind of hook inside the C code, that gets called when alfred gets 
updated information from any other node, and the hook runs a script (or 
maybe all facters in facters_dir?)

in other words, instead of polling alfred every X interval to see if 
there's any new info, make alfred react as soon as it receives 
propagated info, so that it calls facter scripts and they can use that 
info ASAP.

What do you think? Sounds useless? doable? Lightweight? Almighty?

gui :)
