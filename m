Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Sat, 6 Nov 2021 22:17:59 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: Unable to get DHCP after join wlan0 WIFI mesh network
Message-ID: <YYbxB7TBPAaEQc49@sellars>
References: 
 <CA+HNRgC0FKMtSiDOZR3E_T_77C0QXv+r9kqncKNO5-ARwj4ZYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: 
 <CA+HNRgC0FKMtSiDOZR3E_T_77C0QXv+r9kqncKNO5-ARwj4ZYA@mail.gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Nov 05, 2021 at 04:22:11PM -0700, Dweb Fan wrote:
> 4. I follow the document
> https://www.kernel.org/doc/Documentation/networking/batman-adv.txt,
> but seems like unable to see batman related files/folders under
> /sys/class/net/wlan0. Here is output:
> $ ls /sys/class/net/wlan0

Hm, seems this link is outdated. Not sure who can update this or
when it is going to be updated. Here is a more recent version of
this file:

https://www.kernel.org/doc/html/latest/networking/batman-adv.html

sysfs and debugfs supported is deprecated for a while. Instead
batctl and "ip link" should be used.

Regards, Linus
