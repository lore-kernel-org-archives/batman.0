Return-Path: <daniel@makrotopia.org>
Message-ID: <52E5063E.3080408@makrotopia.org>
Date: Sun, 26 Jan 2014 13:57:34 +0100
From: Daniel <daniel@makrotopia.org>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>	<52DF7556.9090200@makrotopia.org>
 <86y527oqpl.fsf_-_@coulee.tdb.com>	<52E003DD.6040302@meshcoding.com>
 <52E02EDC.3080805@wirelesspt.net> <86iotbo9hw.fsf@coulee.tdb.com>
 <52E05E0F.7010203@wirelesspt.net> <52E08DFE.9030604@makrotopia.org>
In-Reply-To: <52E08DFE.9030604@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
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

I now built OpenWrt trunk/BB r39365 with batman-adv 2013.4.0 instead of
2014.0.0, tried with all possible settings, no memory leak what-so-over, happy
uptimes of more than a day by now :)
all other system components and settings are exactly identical to my previous
setup with batman-adv 2014.0.0.

On 01/23/2014 04:35 AM, Daniel wrote:
> On 01/23/2014 01:10 AM, cmsv wrote:
>> what version are you using ?

> out-of-memory every 20 minutes or so on OpenWrt trunk/BB r39365 on tl-wr841nd-v8
> with batman-adv 2014.0.0 from openwrt's routing feed with "batman-adv: fix
> batman-adv header overhead calculation" and "batman-adv: fix soft-interface MTU
> computation" on top.
> A sample node is (occasionally) reachable via DN42 at 104.61.99.104 (feel free
> to ask for ssh or any kind of logs, serial access, remote gdb or whatever)


