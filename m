Return-Path: <Stefan@Radtke.eu>
Message-ID: <4D64BAFF.9050006@Radtke.eu>
Date: Wed, 23 Feb 2011 08:45:03 +0100
From: "Dr. Stefan Radtke" <Stefan@Radtke.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Problem after configuring a bridge
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello *,

I set up batman-adv-2010  on OpenWRT (backfire 10.3.x). Mesh interface  
is wlan0 and another non-batman-LAN is connected to eth0. non-batman 
clients should connect via the eth0 interface. (Full description and 
network diagram here: 
https://forum.openwrt.org/viewtopic.php?pid=129226#p129226 ).

After setting up batman-adv 2010.x with

batctl if add wlan0
ifconfig wlan 0 0.0.0.0
ifconfig bat0 192.168.10.2    (previous ip address of wlan0)
ifconfig bat0 up

I have to configure a bridge  (according to quick start guide 
http://www.open-mesh.org/wiki/batman-adv-quick-start-guide) because I 
want batman-adv to announce MAC-addresses connected to eth0 (see network 
diagram):

brctl addbr mesh-bridge
brctl addif mesh-bridge eth0
brctl addif mesh-bridge bat0
ifconfig eth0 up
ifconfig bat0 up
ifconfig mesh-bridge up


Although the translation tables (global and local) seem fine in this moment, at the same momentof bringing up the bridge I cannot send any more packets through bat0 or ent0.
Both don't even reply to a ping.

Network setup and outputs of ifconfig onhttp://www.open-mesh.org/wiki/batman-adv-quick-start-guide  

Any hint is appreciated.

Stefan

