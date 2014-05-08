Return-Path: <fabrice.dossin@amoobi.com>
MIME-Version: 1.0
In-Reply-To: <5364ABB1.6050109@meshcoding.com>
References: <CAPXi+9-j-u6YbvhMjhLPxVOcdYPd0HVThH=SH7PacvakeYenDw@mail.gmail.com>
 <533CF7F5.1000801@meshcoding.com>
 <CAPXi+9_ovpYZMDreNBFCffakiCMWnzHHC_1MaOxYy5A_veqJ7w@mail.gmail.com>
 <CAPXi+9-4y3wG3=0OoL8hbWQAO6Gummaa4tM=cKMapNQRjxiO9w@mail.gmail.com>
 <CAPXi+99VgVyf7O8j8J+fLAF4AaKOFRxJTX1xpdnP3Q1JkBZE4Q@mail.gmail.com>
 <5364ABB1.6050109@meshcoding.com>
From: Fabrice Dossin <fabrice.dossin@amoobi.com>
Date: Thu, 8 May 2014 10:44:42 +0200
Message-ID: <CAPXi+9-OGqyBGrBS2P57-YmCA1exjo91S9JQQkftkOuDAWXDMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] batctl oops on batctl gateways call
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

Good news, thank you very much.

On 3 May 2014 10:41, Antonio Quartulli <antonio@meshcoding.com> wrote:
> FYI, we are rather confident that this patch
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-May/011920.html
> fixes the problem you have seen.
>
> Cheers,
>
> On 12/04/14 23:15, Fabrice Dossin wrote:
>> Hi,
>> I could not reproduce this. I keep you update if I see this again.
>> Best regards,
>> Fabrice
>>
>> On 3 April 2014 10:21, Fabrice Dossin <fabrice.dossin@gmail.com> wrote:
>>> (Sorry, reformatting again, leaving text mode)
>>>
>>>
>>> Hi,
>>>
>>> Sorry, my mail client did this behind my  back. I did resend the stack
>>> here under for readability.
>>>
>>> For now, it has append only one time on one node. This particular node
>>> does not have any other node in his range. I execute a "batctl
>>> gateways" each 5 minutes for monitoring. I will let you know if it
>>> appends again today or if I found information for reproducibility.
>>>
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.500226] Unable to handle kernel
>>> NULL pointer dereference at virtual address 00000022
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.508175] pgd = d4918000
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.514355] [00000022] *pgd=138f9831,
>>> *pte=00000000, *ppte=00000000
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.521733] Internal error: Oops: 17
>>> [#5] PREEMPT ARM
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.527131] Modules linked in: tun
>>> ipt_MASQUERADE iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4
>>> nf_nat nf_conntrack iptable_filter ip_tables x_tables ipv6 bcm2708_rng
>>> bcm2708_wdog batman_adv(O) rtc_ds1307 qmi_wwan option usb_wwan arc4
>>> usbserial cdc_wdm rt2800usb rt2800lib rt2x00usb rt2x00lib mac80211 cfg80211
>>> crc_ccitt sr_mod cdrom leds_gpio led_class rt5572sta(O) spi_bcm2708
>>> i2c_bcm2708 btusb bluetooth rfkill
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.544610] CPU: 0 PID: 7261 Comm:
>>> batctl Tainted: G      D    O 3.10.30+ #1
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.550263] task: d49f3180 ti: d38d0000
>>> task.ti: d38d0000
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.556017] PC is at
>>> batadv_orig_router_get+0x50/0x9c [batman_adv]
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.561587] LR is at
>>> batadv_orig_router_get+0x10/0x9c [batman_adv]
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.566974] pc : [<bf35e218>]    lr :
>>> [<bf35e1d8>]    psr: 20000013
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.566974] sp : d38d1ea8  ip :
>>> 0000000a  fp : dda60600
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.577350] r10: cccccccd  r9 :
>>> ddab7000  r8 : dda60600
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.582439] r7 : 00000000  r6 :
>>> 00000000  r5 : d4826e00  r4 : 00000000
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.587535] r3 : d4ac0000  r2 :
>>> 00000000  r1 : 00000000  r0 : 00000002
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.592468] Flags: nzCv  IRQs on  FIQs
>>> on  Mode SVC_32  ISA ARM  Segment user
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.597357] Control: 00c5387d  Table:
>>> 14918008  DAC: 00000015
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.602319] Process batctl (pid: 7261,
>>> stack limit = 0xd38d01b0)
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.607230] Stack: (0xd38d1ea8 to
>>> 0xd38d2000)
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.611903] 1ea0:
>>> d49f3180 d49c2580 00000000 bf35a62c 000000ff bf368ed8
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.616816] 1ec0: bf368ee0 bf368eec
>>> dc89b000 dbe3cd08 ddab7000 dc83bba0 dbd10900 00000000
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.621720] 1ee0: 00100073 00000000
>>> d25a0aa0 00000000 00000000 00000001 d38d1f20 00000001
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.626477] 1f00: dda60600 c00f653c
>>> d1f20790 d38d1f80 00001000 b6f18000 dda60628 00000000
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.631263] 1f20: 00000000 00000000
>>> 00001000 dc83bba0 00000001 d25a0aa0 b6f18000 d38d0000
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.636092] 1f40: d38d1f80 00001000
>>> d38d0000 00001000 bea8eb54 c00d7530 00000000 00000003
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.640834] 1f60: 00000000 00000000
>>> 00000000 d25a0aa0 b6f18000 00000000 00001000 c00d77c4
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.645450] 1f80: 00000000 00000000
>>> ffffffff 00916008 fbad2488 00000000 00000003 c000dd68
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.650123] 1fa0: 00000000 c000dbc0
>>> 00916008 fbad2488 00000003 b6f18000 00001000 00000000
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.654758] 1fc0: 00916008 fbad2488
>>> 00000000 00000003 00000000 00021450 b6f1f000 bea8eb54
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.659333] 1fe0: 00000000 bea8e8c8
>>> b6d945f8 b6de52bc 60000010 00000003 00000000 00000000
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.664121] [<bf35e218>]
>>> (batadv_orig_router_get+0x50/0x9c [batman_adv]) from [<bf35a62c>]
>>> (batadv_gw_client_seq_print_text+0xac/0x220 [batman_adv])
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.673531] [<bf35a62c>]
>>> (batadv_gw_client_seq_print_text+0xac/0x220 [batman_adv]) from [<c00f653c>]
>>> (seq_read+0x1d0/0x4cc)
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.678287] [<c00f653c>]
>>> (seq_read+0x1d0/0x4cc) from [<c00d7530>] (vfs_read+0x98/0x17c)
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.683071] [<c00d7530>]
>>> (vfs_read+0x98/0x17c) from [<c00d77c4>] (SyS_read+0x3c/0x70)
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.687982] [<c00d77c4>]
>>> (SyS_read+0x3c/0x70) from [<c000dbc0>] (ret_fast_syscall+0x0/0x30)
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.692822] Code: e8bd8038 e593000c
>>> e3500000 0afffff8 (e5902020)
>>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.718781] ---[ end trace
>>> 1e5ba977f5516301 ]---
>>>
>>> Regards,
>>> Fabrice
>>>
>>>>
>>>>> Hi Fabrice,
>>>>>
>>>>> On 02/04/14 13:50, Fabrice Dossin wrote:
>>>>>> Dear all,
>>>>>>
>>>>>> Hello.
>>>>>> I am not sure it has been notified so I post this issue here.
>>>>>> It is my first post, so tell me if I do it bad...
>>>>>>
>>>>>
>>>>> no problem, it's fine! Maybe sending the stack trace without adding new
>>>>> lines is better, but this is fine anyway :)
>>>>>
>>>>> Are you able to reproduce this problem somehow? Or it happened only once
>>>>> under no particular conditions?
>>>>>
>>>>> Cheers,
>>>>>
>>>>>
>>>>> --
>>>>> Antonio Quartulli
>>>>>
>>>
>>
>
> --
> Antonio Quartulli
>



-- 
Fabrice Dossin
Co-founder
Amoobi

T. +32.67.883.799 - M. +32.487.73.37.71
E. fabrice.dossin@amoobi.com
S. www.amoobi.com
Skype. fabrice.dossin

Postal Address: Rue de l'industrie, 20 - 1400 Nivelles - Belgium
