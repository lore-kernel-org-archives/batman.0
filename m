Return-Path: <jens@viisauksena.de>
Message-ID: <568D7073.5010207@viisauksena.de>
Date: Wed, 06 Jan 2016 20:52:19 +0100
From: jens <jens@viisauksena.de>
MIME-Version: 1.0
References: <CA+HVqbtX5OX01kGjA7yhYnTFM18kN2ZetvKtkuK3Ptoxrtkp9A@mail.gmail.com>
 <3614408.8CNzbHmZCJ@sven-edge>
In-Reply-To: <3614408.8CNzbHmZCJ@sven-edge>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Compiling Batman-adv on Kernel 4.4+
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, fred.veldini@gmail.com

guess its something similar as described here ..
https://cccfr.de/wiki/freifunk:batman-adv?s[]=batman#ab_kernel_317-rc1
the call of your described function needs more arguments, which ones
that are .. you have to find out

On 06.01.2016 20:05, Sven Eckelmann wrote:
> On Wednesday 06 January 2016 12:19:04 fred veldini wrote:
>> I sent an email to the list a while ago, not sure if anyone received the
>> message.
> Usually I ignore mails which are send to me directly about batman-adv without 
> Cc'ing the mailing list. But I trust that you (at least) tried to send a mail.
>
> But I never saw your mail in the queue of pending mails (maybe Marek did). 
> Please send your mails next time as plain text and not with html content.
>
> At least I could find that your mail bounced on Jan 4 17:17:17. So you should 
> have been informed that it was rejected (for whatever reason).
>
>> I'm running into an issue compiling the latest batman-adv code on the
>> latest kernel,
> [...]
>> /mnt/builds/batman-Jan-5-2016/batman-adv-6219a1b/net/batman-adv/hard-interfa
>> ce.c:469:2: error: too few arguments to function
>> 'netdev_master_upper_dev_link' In file included from
>> /mnt/builds/batman-Jan-5-2016/batman-adv-6219a1b/compat-include/linux/netdev
>> ice.h:25:0, from include/linux/etherdevice.h:26,
>>                  from
> You don't use an official kernel and the compat layer of batman-adv can only 
> support major releases or Linus' development tree. But you can try to change 
> the netdev_master_upper_dev_link compat layer under compat-
> include/linux/netdevice.h. Try replacing all "KERNEL_VERSION(4, 5, 0)" with 
> "KERNEL_VERSION(4, 4, 0)" or whatever the LINUX_VERSION_CODE of your 
> development kernel is.
>
> I guess this is causing the problem because you use changes which are for 
> Linux 4.5 but your kernel still uses the LINUX_VERSION_CODE for Linux 4.4
>
> Kind regards,
> 	Sven

-- 
make the world nicer, please use PGP encryption

