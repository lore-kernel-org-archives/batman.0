Return-Path: <gui@altermundi.net>
Message-ID: <51CB7254.7030907@altermundi.net>
Date: Wed, 26 Jun 2013 19:59:32 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <CAKON4Ox2+uFUWR5ZBQ8yHdWZWW0zrxAgkd8iv-QG3DtTnVKJWQ@mail.gmail.com>
 <51CB60F0.6090604@wirelesspt.net>
 <CAKON4Ozy3ObsYRYTF71i4Ys7A4H5228xywXfjZxvfwrepUyjTQ@mail.gmail.com>
In-Reply-To: <CAKON4Ozy3ObsYRYTF71i4Ys7A4H5228xywXfjZxvfwrepUyjTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] single radio routers and ap/adhoc interfaces
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

On 06/26/2013 07:39 PM, jonsmirl@gmail.com wrote:
>
> It looks like OpenWRT trunk is broken. I just sent this out on the
> OpenWRT list but I haven't received a response yet. When I loaded
> Steve image the hardware worked as expected.

Bleeding edge often hurts :-/

(Thanks for sending that report to openwrt-devel!)

The last trunk i tried and didn't find blocker bugs was r36139
With r36655 we experienced severe instability of ath9k wifi, and rolled 
back to r36139. Haven't tried more recent trunks than that yet.

hope that helps :)

about ap/sta mode:

On 06/26/2013 03:46 PM, Antonio Quartulli wrote:> On Wed, Jun 26, 2013 
at 02:38:16PM -0400, jonsmirl@gmail.com wrote:
 >> Is it a bad idea to run batman over the STA/AP mode type interfaces?
 >
 > batman-adv supports it. From the batman-adv prospective there is no 
problem. The
 > important thing is that you know what you are doing and that you take 
care of
 > properly configuring the underlying layer (e.g. Isolation of the 
client should
 > be enabled, imho).

We agree :) we use this approach with *ath9k_htc* devices (usb dongles) 
which still suffer bugs in adhoc mode.

http://blog.altermundi.net/article/batman-adv-ap-mode-with-isolation-enabled/

Cheers!
