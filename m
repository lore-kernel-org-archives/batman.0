Return-Path: <gui@altermundi.net>
Message-ID: <5388C01D.1030202@altermundi.net>
Date: Fri, 30 May 2014 14:30:05 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <53889421.7040000@udio.cujae.edu.cu>
In-Reply-To: <53889421.7040000@udio.cujae.edu.cu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] I need some help with BATMAN configuration
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

On 30/05/14 11:22, Lucy Coya wrote:
> Hi everyone,
> My name is Lucy Coya, I´m a telecommunications engineer and I need some
> help with my BATMAN configuration. I´m using batman-adv-2014-2.0 and
> batctl-2014-2.0
> I´m trying to use BATMAN protocol in a very very simple routing scenario
> at first to study the protocol. I have:
> -Two Laptops using two wireless interfaces each (wlan0 in AP mode and
> wlan1 in Ad Hoc mode).
> 
> I meshed the two wireless interfaces in ad hoc mode according to the
> wiki steps and it worked fine,so I can ping the interfaces. Now I´m
> trying to make that two clients connected to the AP interfaces can ping
> each other through the mesh network. I tried creating a bridge between
> wlan0 and wlan1 as the wiki says but no ping :-(. I don´t know what to

you should bridge wlan0 (the AP interface) with bat0
and add wlan1 (adhoc) to bat0 with "batctl if add"

in ascii art that'd be:
br-lan
 \ wlan0
 \ bat0
    \ wlan1

in bash commands that'd be

# add adhoc interface to bat0
batctl if add wlan1

# remove addresses from slave interfaces
ip addr flush dev wlan0
ip addr flush dev wlan1
ip addr flush dev bat0

# bridge ap interface with bat0
brctl addif br-lan wlan0
brctl addif br-lan bat0

# add the ip address to the bridge
ip addr add dev br-lan 2001:db8::1/64


cheers!

gui

> do so any help would be awesome!!! Thanks
> Sorry if my English is bad :-)
> 
> Lucy
> 
> 
> 
> 50 Aniversario de la Cujae. Inaugurada por Fidel el 2 de diciembre de
> 1964  http://cujae.edu.cu
> 
> 
