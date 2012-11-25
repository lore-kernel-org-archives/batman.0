Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAEPAu5oarOFFtlUPu/NsHLsBAAAAAA==@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAEPAu5oarOFFtlUPu/NsHLsBAAAAAA==@gmail.com>
From: Gui Iribarren <gui@altermundi.net>
Date: Sun, 25 Nov 2012 13:59:40 -0300
Message-ID: <CAHD-aq+mvhxjYyuNmYC+ZMgB+m43R3+XMqB3o7N5fu6TbSJmZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] trigger events
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

The gateway server dis/appearance is handled by /etc/hotplug.d/net/
framework, i'm currently working on a general script to handle that
using uci config,


In the meanwhile, you can find more info in batman-adv wiki page

http://www.open-mesh.org/wiki/batman-adv/Uevent

or if you are in a hurry, check a hacky script

https://bitbucket.org/guidoi/batmesh/src/tip/batman-adv-auto-gw-mode/files/etc/hotplug.d/net/99-batman-gw

On Sun, Nov 25, 2012 at 12:52 PM, Walter Robert Ditzler
<ditwal001@gmail.com> wrote:
> hi all,
>
> i am wondering if events in batman-adv can be triggered such as:
>
> - get message when: host/batman-adv lost connection
> - get message when: host/batman-adv is connected to min. 1 gateway server
>
> if yes, even whith other events, does anyone have an example how to read the
> event in a bash script for further processing?
>
> thanks a lot,
>
> walter.
>
