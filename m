Return-Path: <fly@d00m.org>
Message-ID: <53A44C26.7010406@d00m.org>
Date: Fri, 20 Jun 2014 16:58:46 +0200
From: Bastian <fly@d00m.org>
MIME-Version: 1.0
References: <53A43E1A.1060800@sns.it>
In-Reply-To: <53A43E1A.1060800@sns.it>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Bridge changing source mac address prevents
 batman-adv from connecting
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

Hi,

we have a similar situation at freifunk-berlin. Because of problems with 
weather-radar we are forced to use DFS/802.11h compliant hardware. We 
chose ubnt nanostations with AirOS in WDS/transparent-bridge mode.
If you want to *bridge* two networks, you need some form of WDS. Basic 
AP<->STA does not have enough fields for additional MAC-addresses of 
devices behind the STA.

So either you run OpenWRT with batadv+bmx6 on both NanoStations, or you 
use AirOS in WDS-mode on both NanoStations and run batadv+bm6 with 
ethernet-node behind those NS5. Mixing AirOS and OpenWRT (with or 
without bridge mode) will - as far as i know - always break anything 
that relies on correct MAC-adresses, like batman-adv or IPv6-NDP.

Regards.
Bastian


On 06/20/2014 03:58 PM, Ilario Gelmetti wrote:
> Hi all!
> I'm using batman-adv (2014.2.0) on two devices running OpenWrt
> (LibreMesh) connected using a third device running a proprietary
> firmware in bridge mode (AirOS), this is the topology:
> http://i.imgur.com/ELMi5RC.png
>
> mac3E80 OpenWrt batman----cable----macE3E7 AirOS station----wireless--
> --macE434 AP OpenWrt batman
>
> using tcpdump on the OpenWrt devices I can see batman packets flowing:
> on mac3E80 I can see:
> http://sprunge.us/iePM
> while on macE434 I can see:
> http://sprunge.us/DIAX
> as you can see the problem is that macE434 sees packets from mac3E80
> *approaching with the wrong mac address*, the mac address of macE3E7 so
> I think it discards the packages when source mac address is different
> from mac address specified inside the packet.
> Is this only a security check?
> How could I get things work?
> Thanks,
> Ilario
>
>

