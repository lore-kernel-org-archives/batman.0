Return-Path: <gui@altermundi.net>
Message-ID: <517AE648.2010000@altermundi.net>
Date: Fri, 26 Apr 2013 22:40:40 +0200
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <517AD5DB.1040600@wirelesspt.net>
In-Reply-To: <517AD5DB.1040600@wirelesspt.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Batman-adv and Uevent (gateway/client modes)
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
To: cmsv@wirelesspt.net
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 04/26/2013 09:30 PM, cmsv wrote:
> I have reached a point where i need to start using the uevent
> functionality to work around some network scenarios when the gateways
> lose internet access but i am having a bit of a difficult time
> understanding how to do it since making use of uevents which is
> something new to me.
>
> The explanation here is not helping much either
> http://www.open-mesh.org/projects/batman-adv/wiki/Uevent
>
> and i understand that i might need to go to the basics to understand it
> and learn how to code.
>
> My need to use uevents to change a nodes behaviour is to change a node
> from server to client and vice versa when it loses connectivity to the
> WAN (not for example losing connectivity to the dsl router that is
> actually the gateway but that has the node as a LAN client)
>
> I am assuming that uevents will allow me to work with this physical
> setup correct?
>
> As far as i understand now and if i am not mistaken when a gateway loses
> WAN connectivity the node that is making use of uevents will change  the
> node from "server" to "client" on batman-adv .

That won't happen automatically, you need some userspace script to 
handle the event and change batman-adv gw mode

Please check

https://colectivo.altermundi.net/projects/altermesh-packages/repository/show/batman-adv-auto-gw-mode

which in turn depends on

https://colectivo.altermundi.net/projects/altermesh-packages/repository/show/watchping

you should read the source code of batman-adv-auto-gw-mode (just a few 
lines / files) and i'll comment a bit about it along this email,

you can grab the "binaries" (actually ipk-packaged bash scripts) and try 
them right away

http://chef.mesh.altermundi.net/downloads/r36139/ar71xx/packages/batman-adv-auto-gw-mode_2013-04-11-237-1_ar71xx.ipk
http://chef.mesh.altermundi.net/downloads/r36139/ar71xx/packages/watchping_2013-04-11-237-1_ar71xx.ipk


mind you, the default behaviour of sending the hostname in dhcp requests 
has changed in recent trunk builds, so this feature might not work 
reliable; but on the other hand, that might not make any difference in 
your scenario :) (you don't seem to care about hostnames)



> Now my question is if i can also make it to change the dhcp setup from
> dhcp server to inactive and receive it´s dhcp service from another
> gateway node

>
> In theory  something like this would be executed on openwrt when a
> gateway node detects no connectivity to the wan:
>
> uci set batman-adv.bat0.gw_mode=client ;
> uci commit batman-adv ;
> batman-adv reboot ;
> uci set dhcp.lan.force=0 ;
> uci set dhcp.lan.ignore=1 ;
> uci commit dhcp ;
> /etc/init.d/dnsmasq restart ;
>
> when it detects wan connectivity it will want to become a server and
> will auto execute:
>
> uci set batman-adv.bat0.gw_mode=server ;
> uci commit batman-adv ;
> batman-adv reboot ;
> uci set dhcp.lan.force=1 ;
> uci set dhcp.lan.ignore=0 ;
> uci commit dhcp ;
> /etc/init.d/dnsmasq restart ;
>
> A small script can even be made in order so simplify things either
> automatically or manually and lets call it:
> gateway-mode
> client-mode

this would equiv to

/etc/watchping/wan-ok.d/batman-gw
/etc/watchping/wan-fail.d/batman-gw

>

> Upon detecting no WAN connectivity the script will be activated.
>
> Am i on the right track so far (at least in theory) ?
>
> Now the second part is how to detect WAN connectivity which is different
> from noticing that there is no connectivity to the actual gw router that
> has the node on it's LAN.
>
> I thought about a ping test to a few address from which after 100% loss
> reply from all; something or Uevent will activate the gateway/client
> mode script but it creates another problem ahead.
>
> In a quick conversation with ordex on irc i understand that i have to
> invoke the wiki docs uevent functions with the parameters i want at the
> moment i decide.
> This can be the gateway/client mode script

Yes, in my case /etc/hotplug.d/net/99-batman-gw

>
> correct ?
>
> Since uevent is something new to me; can someone recommend some freshman
> tutorial that may take me in the right direction. I have no clue where
> or how to start looking to code it and also when coded; where will it be
> added.
>
> I also would like to ask anyone that has uevent working how they are
> using it for the same type of need and maybe even share some recipe.
>
>
>
>
>

