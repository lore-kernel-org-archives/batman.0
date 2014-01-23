Return-Path: <daniel@makrotopia.org>
Message-ID: <52E08DFE.9030604@makrotopia.org>
Date: Thu, 23 Jan 2014 04:35:26 +0100
From: Daniel <daniel@makrotopia.org>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>	<52DF7556.9090200@makrotopia.org>
 <86y527oqpl.fsf_-_@coulee.tdb.com>	<52E003DD.6040302@meshcoding.com>
 <52E02EDC.3080805@wirelesspt.net> <86iotbo9hw.fsf@coulee.tdb.com>
 <52E05E0F.7010203@wirelesspt.net>
In-Reply-To: <52E05E0F.7010203@wirelesspt.net>
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

On 01/23/2014 01:10 AM, cmsv wrote:
> 
> 
> On 01/22/2014 06:57 PM, Russell Senior wrote:
>>>>>>> "cmsv" == cmsv  <cmsv@wirelesspt.net> writes:
>>
>> cmsv> I had the same problem which caused reboots but after the last
>> cmsv> batman-adv update i am not seeing it.  all my devices are have
>> cmsv> mb ram i am using network coding and 1560 MTU
>>
>> Which version are you running?
>>
>>
> 
> Righ now with openwrt AA DISTRIB_REVISION="r39154" and batctl 2014.0.0
> [batman-adv: 2014.0.0]
> 
> Routers are dir 601 dir 615* tl wr703n and it is not happening
> I synced the feed less than 48h ago and recompiled.
> 
> what version are you using ?

out-of-memory every 20 minutes or so on OpenWrt trunk/BB r39365 on tl-wr841nd-v8
with batman-adv 2014.0.0 from openwrt's routing feed with "batman-adv: fix
batman-adv header overhead calculation" and "batman-adv: fix soft-interface MTU
computation" on top.
A sample node is (occasionally) reachable via DN42 at 104.61.99.104 (feel free
to ask for ssh or any kind of logs, serial access, remote gdb or whatever)



