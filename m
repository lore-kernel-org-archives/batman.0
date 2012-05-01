Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 May 2012 21:34:26 +0200
Message-ID: <4457592.cWIfhQBfiK@sven-desktop.home.narfation.org>
In-Reply-To: <20120501200645.Horde.4u5hTaeWCxtPoDRF8GF27AA@beta.mail.sapo.pt>
References: <20120501200645.Horde.4u5hTaeWCxtPoDRF8GF27AA@beta.mail.sapo.pt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13231331.pIMGaupqkB";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Batman-adv simple configuration example
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


--nextPart13231331.pIMGaupqkB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Some questions here can be answered by reading the documentation section under 
http://www.open-mesh.org/wiki/batman-adv/ - I will not mention it in this 
text. Please just check it out and read about things like "gateway support" 
and so on.

Many, many, many things in this mail are not batman-adv related. Most of them 
are either OpenWRT specific or normal linux routing stuff. So I will not 
extensively answer to this kind of questions.

On Tuesday 01 May 2012 20:06:45 Pedro Nuno Costa Rodrigues wrote:
> In this moment i'm trying to setup a basic 2 nodes using batman-adv...
> I'm using UBUNTU 10.10 - linux.
> I'm using OPENWRT in 2 routers.
> The routers are 2 linksys wrt54gs (v1.1 and v3).

Did you check that adhoc between both routers work without batman-adv? (bcast 
and unicast)

> When i do:
> 
> root@OpenWrt:~# batctl if
> br-lan: active
> wlan0: active

Please don't add bridges to batman-adv unless you absolutely know what you are 
doing.

And never add bridges to an batman-adv interface that has the same batman-adv 
interface as port.

[...]
> the same thing happens... why?  ----- the gw definition and the vm
> definition is mandatory to router 2 access internet? or doesn't matter?

No, vm is for the visualization server/client configuration (i doubt that you 
are using it with two nodes). The gateway is only for a special dhcp handling 
when you have multiple dhcp servers running and want that clients use the dhcp 
server with the "best" connection.

> here is is my /etc/config files for router 2, that is supossed to work
> as a batman-adv gateway client:
> 
> root@OpenWrt:~# vi /etc/config/batman-adv
> config 'mesh' 'bat0'
>          option 'interfaces' 'wifi lan'
>          option 'aggregated_ogms' '1'
>          option 'ap_isolation' '0'
>          option 'bonding' '0'
>          option 'fragmentation' '1'
>          #option 'gw_bandwidth'
>          option 'gw_mode' 'client'
>          option 'gw_sel_class' '2'
>          option 'log_level' 'all'
>          option 'orig_interval' '1000'
>          option 'vis_mode' 'client'
> 
> is the file ok?

Propably not... see the part about "lan" bridge interface above.

> when i do in node 2:
> 
> root@OpenWrt:~# batctl if
> br-lan: active
> wlan0: active

Same here.

[....]
> the gw and vm doesn't start/boot with the start configuration... it's
> the same problem...
> why this happens? it's crucial for the batman-adv works correctly?

I am no OpenWRT developer, so I can't tell you anything about the startup 
problems in OpenWRT. But the meaning of vm and gw was explained above and is 
not really needed to "have internet access".


> Here is my  network file for router 1 and 2 ( the only difference is
> "lan option ipaddr" and the "wifi option ipaddr"...
> Question: is necessary to wifi (wlan0) have static ipaddr or it shouldn't?
> The mtu size is ok?

MTU is not ok because you added br-lan with the mtu 1500. The mtu of wifi 
should be ok.

[...]
> #### LAN configuration
> config interface lan
>          option type     bridge
>          option ifname   "eth0.0 bat0 wlan0"

This looks like a local packet loop created by your bat0 in bridge, bridge in 
bat0 cycle. It is also weird that you have wlan0 as adhoc interface for batman 
and as client interface. Maybe you want to split it into two different ones.

One for adhoc+batman-adv and one for client access (AP mode)

[...]
> root@OpenWrt:/etc/config# vi dhcp
> config dnsmasq
>          option domainneeded     1
>          option boguspriv        1
>          option filterwin2k      0  # enable for dial on demand
>          option localise_queries 1
>          option rebind_protection 1  # disable if upstream must serve
> RFC1918 addresses
>          option rebind_localhost 1  # enable for RBL checking and
> similar services
>          #list rebind_domain example.lan  # whitelist RFC1918
> responses for domains
>          option local    '/lan/'
>          option domain   'lan'
>          option expandhosts      1
>          option nonegcache       0
>          option authoritative    1
>          option readethers       1
>          option leasefile        '/tmp/dhcp.leases'
>          option resolvfile       '/tmp/resolv.conf.auto'
>          #list server            '/mycompany.local/1.2.3.4'
>          #option nonwildcard     1
>          #list interface         br-lan
>          #list notinterface      lo
>          #list bogusnxdomain     '64.94.110.11'
> 
> config dhcp lan
>          option interface        lan
>          option start    51               #########for router 2 is start 101
> option limit    70               #########for router 2 is limit 130 #option
> leasetime       12h
> 
> config dhcp wan
>          option interface        wan
>          option ignore   1
> 
> config dhcp wifi
>          option interface wifi
>          option start    51                #########for router 2 is start
> 101 option limit    70                #########for router 2 is limit 130

Why is there a special wifi configuration here? You have a br-lan config that 
already includes the wifi interface.

> Finally here is my /etc/config/wireless file:
> 
> I also have some questions here...
> Is necessary the both routers have the same BSSID? Is mandatory to
> have BSSID, or isn't mandatory to aggregate a batman-adv mesh network?

batman-adv isn't interested in the bssid. It just needs a common broadcast 
domain for its ethernet frames.

The interface is in adhoc mode... this means that the bssid here is the 
cellid. Both nodes will only be in the same "network" when the cellids are the 
same.

[...]

Just my two cents. You should try to analyze parts of your setup without doing 
the complete setup at ones. So, check the different links, send some ping 
packets here and find the problematic part. Otherwise it is extreme hard to 
debug this thing.

Kind regards,
	Sven
--nextPart13231331.pIMGaupqkB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPoDrCAAoJEF2HCgfBJntGXqEQAKhBYSVO+H8zX/2a0b0lEA5U
1fgI+s1MfYWE6WXRe071XafLcIjzUqzb+bcNXyeq9QJQ+u7n++5b+1UVd3RS41Fw
mI8xXqzKL4GO7DPWptI+vRp9Seyza86WyUQdDeopTfcDRuLcdnnbdMOTULmVHQme
HlNsRQ/+juSUAynLpbSSVwXCWpQB8wm3irngro3L2y5cl+3qt0uyoYXvc/xZalwn
XC+2z8fOh2igMOEKbwlCSpFXwvySla/0w+W/uqlOcWjUIG9Tg7/++l0xF1fdtth0
4fpC4JIA/I2d81Y1avOCrG+3xYSuF0o4VNh59OCkjeV0ELKsbJayCmddwNsBEnnT
9J95rtJqX08vzuyU6a9fUj9DmHj1oVfgbnIo9qCbqen2/X1uO81biSoPTnQ2aBrL
cjwnXeX3PwS9t4V2bRaL1Xta/sYTYDfLN7d8D+Swyl/kJb10SVXhTE3U8eQdurk3
cUoL5GfxfEpgAW9FNN8NCP9fOl8uBRzJD9SmQicRQTlSZlIL6H7d+b/DfFH95j93
mLifo99Jq+2oc3UoKZvSPq3TEhTB/pG6Dg14DqMe+3TB2eXbnk84zRhBeacHlpG4
qTMSMcm1v3Ze1NRVW14QQbGcY+oeb6TQ4Q4OfytGEUGOw6uZJZ2sN2DnfZjSiJyp
Yox9qBqks0HK2Yu68ZwN
=NTqf
-----END PGP SIGNATURE-----

--nextPart13231331.pIMGaupqkB--

