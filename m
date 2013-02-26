Return-Path: <gui@altermundi.net>
Message-ID: <512C8BAF.3010704@altermundi.net>
Date: Tue, 26 Feb 2013 07:17:19 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <CAFevQmMNTep6A0-+0dCc4-qX3ty+Mo7EUFR4CE2WohgRdA3ZjA@mail.gmail.com>
In-Reply-To: <CAFevQmMNTep6A0-+0dCc4-qX3ty+Mo7EUFR4CE2WohgRdA3ZjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] netifd batman-adv proto
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

On 02/01/13 10:11, Filippo Sallemi wrote:
> Hi all,
>
> I've writed a batman-adv proto in according on new netifd system of
> attitude adjustement release.
> With this script the batman-adv configuration could be moved on
> /etc/config/network file istead of /etc/config/batman-adv and the
> /lib/batman-adv/config.sh is no longer required.
>
> es.
>
> config interface mesh
>      option proto bat
>      option device bat0
>      option interfaces 'wlan0 wlan1'
>      option gw_mode server
>      ...
>
> if someone think that my work could be useful and can provide a better
> and elegant integration on openwrt please keep in touch.

hey filippo,
is that code published anywhere?
a pastebin or pad would suffice

from your description it looks very promising, so i'm curious to have a 
look at it, if it can be used to extend the current netifd integration 
in openwrt :)

Thanks a lot, cheers!

Gui

>
> --
> Filippo Sallemi
>
