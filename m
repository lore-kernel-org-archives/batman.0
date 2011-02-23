Return-Path: <Stefan@Radtke.eu>
Message-ID: <4D654722.4030506@Radtke.eu>
Date: Wed, 23 Feb 2011 18:42:58 +0100
From: "Dr. Stefan Radtke" <Stefan@Radtke.eu>
MIME-Version: 1.0
References: <4D64BAFF.9050006@Radtke.eu>
In-Reply-To: <4D64BAFF.9050006@Radtke.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Problem after configuring a bridge
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello Antonio, Sven,

thanks for your comments. With your help I could set it up. The mistake 
was in fact the ip-address on bat0.

I removed all IP addresses and set them to the bridge. That worked !

For those who might run into the same problem, here is the correct setup:
http://www.radtke.eu/tmp/Leitzberg-Mesh-corrected.gif

But a question is remaining: once the mesh was running, I wanted to turn 
on enrcyption but this seems not working in ad-hoc mode with OpenWRT . 
If I select Access Point mode for wlan0 the WPA2 encryption works....but 
this is not supported with batman-adv since the wifis need to run in 
ad-hoc mode. Any hint for this if I want to run the mesh encrypted ?

P.D. Same happens if I run IEEE 802.11s mode (without batman-adv). Works 
well but encryption setting doesn't work.

Best regards, Stefan





On 23.02.2011 08:45, Dr. Stefan Radtke wrote:
> Hello *,
>
> I set up batman-adv-2010  on OpenWRT (backfire 10.3.x). Mesh 
> interface  is wlan0 and another non-batman-LAN is connected to eth0. 
> non-batman clients should connect via the eth0 interface. (Full 
> description and network diagram here: 
> https://forum.openwrt.org/viewtopic.php?pid=129226#p129226 ).
>
> After setting up batman-adv 2010.x with
>
> batctl if add wlan0
> ifconfig wlan 0 0.0.0.0
> ifconfig bat0 192.168.10.2    (previous ip address of wlan0)
> ifconfig bat0 up
>
> I have to configure a bridge  (according to quick start guide 
> http://www.open-mesh.org/wiki/batman-adv-quick-start-guide) because I 
> want batman-adv to announce MAC-addresses connected to eth0 (see 
> network diagram):
>
> brctl addbr mesh-bridge
> brctl addif mesh-bridge eth0
> brctl addif mesh-bridge bat0
> ifconfig eth0 up
> ifconfig bat0 up
> ifconfig mesh-bridge up
>
>
> Although the translation tables (global and local) seem fine in this 
> moment, at the same momentof bringing up the bridge I cannot send any 
> more packets through bat0 or ent0.
> Both don't even reply to a ping.
>
> Network setup and outputs of ifconfig 
> onhttp://www.open-mesh.org/wiki/batman-adv-quick-start-guide
> Any hint is appreciated.
>
> Stefan
>
>
>
