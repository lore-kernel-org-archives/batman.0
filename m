Return-Path: <Timbo2001@web.de>
Message-ID: <4C62B25A.3030206@web.de>
Date: Wed, 11 Aug 2010 16:23:22 +0200
From: Tim <Timbo2001@web.de>
MIME-Version: 1.0
References: <mailman.1.1281002401.15834.b.a.t.m.a.n@lists.open-mesh.org>
	<4C627FCF.4090303@web.de>
	<201008111320.14389.sven.eckelmann@gmx.de>
In-Reply-To: <201008111320.14389.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: Timbo2001@web.de
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
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

On 11.08.2010 13:20, Sven Eckelmann wrote:
[...]

> what you could try is to setup the stuff by yourself using
>   http://open-mesh.net/wiki/batman-adv-quick-start-guide  and test which command
> may cause the problem (when it is batman-adv related).
>    
I tried to configure it as described in the guide and I think I some 
kind of found the problem:

Before being able to add wlan0 to the batman interfaces, I need to 
create the interface wlan0 and to remove "option disabled 1" from 
/etc/config/wireless, because otherwise wlan will be disabled by default.

Way1: When removing "option disabled 1" first and then doing 
"/etc/init.d/network restart" I get the following message:
"root@OpenWrt:/# /etc/init.d/network restart
udhcpc (v1.15.3) started
Sending discover...
Configuration file: /var/run/hostapd-phy0.conf
Segmentation fault
Failed to start hostapd for phy0
root@OpenWrt:/# Sending discover...
Sending discover..."

When rebooting the whole device it freezes as already described.

Way 2: When adding the interface wlan0 before enableing radio0 and then 
doing "/etc/init.d/network restart" the following output appears:
"config interface wlan0
         option type     interface
         option ifname   "wlan0"
         option proto    none

root@OpenWrt:/# /etc/init.d/network restart
udhcpc (v1.15.3) started
'radio0' is disabled
'radio0' is disabled
root@OpenWrt:/# Sending discover...
Sending discover...
Sending discover..."

That's clear, enabeling the interface without radio0 running is impossible.
After that the devices reboots as it should.
Enableing radio0 after that and then doing "etc/init.d/network restart" 
the output changes a little bit:

"root@OpenWrt:~# /etc/init.d/network restart
Received SIGTERM
Entering released state
udhcpc (v1.15.3) started
Sending discover...
Configuration file: /var/run/hostapd-phy0.conf
Segmentation fault
Failed to start hostapd for phy0
root@OpenWrt:~# Sending discover...
Sending discover..."

So for me the problem seems to be related to radio0. Trying that with 
the image I compiled without adding batman-adv, enabeling radio0 is 
working fine.

With best regards,
Tim
