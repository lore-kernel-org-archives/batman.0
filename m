Return-Path: <gui@altermundi.net>
Message-ID: <53A44B0A.6090104@altermundi.net>
Date: Fri, 20 Jun 2014 11:54:02 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <53A43E1A.1060800@sns.it>
In-Reply-To: <53A43E1A.1060800@sns.it>
Content-Type: text/plain; charset=UTF-8
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

On 20/06/14 10:58, Ilario Gelmetti wrote:
> Hi all! I'm using batman-adv (2014.2.0) on two devices running
> OpenWrt (LibreMesh) connected using a third device running a
> proprietary firmware in bridge mode (AirOS), this is the topology: 
> http://i.imgur.com/ELMi5RC.png
> 
> mac3E80 OpenWrt batman----cable----macE3E7 AirOS
> station----wireless-- --macE434 AP OpenWrt batman
> 
> using tcpdump on the OpenWrt devices I can see batman packets
> flowing: on mac3E80 I can see: http://sprunge.us/iePM while on
> macE434 I can see: http://sprunge.us/DIAX as you can see the
> problem is that macE434 sees packets from mac3E80 *approaching with
> the wrong mac address*, the mac address of macE3E7 so


Yeah, AirOS in "WDS mode" does tricky stuff.

The problem is, in principle, you shouldn't be able to bridge a wifi
interface in client mode.

http://wiki.openwrt.org/doc/howto/clientmode?s[]=bridged&s[]=client

Your AirOS client device is expecting the AP to be in "4addr" mode,
which vanilla openwrt is not.

You should either
a) keep stock airOS on both client and ap, (what i've done so far,
when bumped into this problem)
b) flash openwrt to both "client" and "ap", and use adhoc between them
c) or dig into doing WDS on openwrt (i guess it's possible but i
haven't tried)

Nothing to do with batman-adv, though :)


> I think it discards the packages when source mac address is
> different from mac address specified inside the packet. Is this
> only a security check? How could I get things work? Thanks, Ilario
> 
> 
