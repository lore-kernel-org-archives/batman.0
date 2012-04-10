Return-Path: <martin@hundeboll.net>
Message-ID: <4F8416C8.6010701@hundeboll.net>
Date: Tue, 10 Apr 2012 13:17:28 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
	<201204041007.02852.lindner_marek@yahoo.de>
	<4F840C67.7060707@hundeboll.net>
	<201204101405.16743.lindner_marek@yahoo.de>
In-Reply-To: <201204101405.16743.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Add interface to keep stats
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On 04/10/2012 01:05 PM, Marek Lindner wrote:
> On Tuesday, April 10, 2012 13:33:11 Martin Hundebøll wrote:
>> On 04/04/2012 10:07 AM, Marek Lindner wrote:
>>> On Monday, April 02, 2012 14:48:15 Martin Hundebøll wrote:
>>>> @@ -265,6 +266,18 @@ static int vis_data_open(struct inode *inode,
>>>> struct file *file) return single_open(file, vis_seq_print_text,
>>>> net_dev);
>>>>
>>>>    }
>>>>
>>>> +static int bat_stats_open(struct inode *inode, struct file *file)
>>>> +{
>>>> +	struct net_device *net_dev = (struct net_device *)inode->i_private;
>>>> +	return single_open(file, bat_stats_show, net_dev);
>>>> +}
>>>
>>> Did you consider using bat_priv->stats or ethtool->get_ethtool_stats() ?
>>
>> Wouldn't that require patching netdevice.h? And in that case, is there any
>> chance to get batman-adv specific counters into the generel netdev stats
>> structure?
>
> No, I did not mean we should patch netdevice.h. The kernel has traffic
> counters we might be able to re-use for our purpose. Especially
> get_ethtool_stats() allows to export custom counters to userspace.
> The kernel developers don't like duplicating existing infrastructure. At least
> we should know what the kernel offers and come up with a reasonable
> explanation why they don't help us.

Sounds like get_ethtool_stats() could do the job - I will look into that.
  
>>>> +static int bat_stats_clear_open(struct inode *inode, struct file *file)
>>>> +{
>>>> +	struct net_device *net_dev = (struct net_device *)inode->i_private;
>>>> +	return single_open(file, bat_stats_clear, net_dev);
>>>> +}
>>>
>>> How about writing 0 to the stats file resets the counters, thus avoiding
>>> a second file ?
>>
>> That is possible, but then I would have to write the debugfs-handling
>> myself, instead of using the nice macro defined in bat_debugfs.c. It's a
>> tradeoff between code size and number of files in debugfs.
>
> Alternatively, you could extend the existing macro to also set a file handler
> for writes instead of assuming only reads. :-)
  
Definitely an option :)
  
>>> If you add an ifdef around the definition here would be no need to malloc
>>> bat_stats separately, right ?
>>
>> Do we prefer IFDEFs in the definition over mallocs? (I guess so by your
>> comment). If thats the case, then no problem with me.
>
> The types.h is full of ifdefs already. It helps to keep the structs smaller
> when functionality is not compiled into the module.

As long as we agree on ifdefs. They weren't there until BLAII and DAT added them, but I don't have a problem with'em. Let's see how long this patch-set will live, as I expect to use the get_ethtool_stats(), if possible.

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net
