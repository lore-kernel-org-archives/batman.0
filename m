Return-Path: <cmsv@wirelesspt.net>
Message-ID: <52DF166A.7080309@wirelesspt.net>
Date: Tue, 21 Jan 2014 19:52:58 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
 <52D631FB.9070106@hundeboll.net> <52D66D45.4060301@wirelesspt.net>
 <52D66DE4.3050300@meshcoding.com> <52DED209.5000207@wirelesspt.net>
 <52DF0A14.3030705@meshcoding.com> <52DF0B77.3070106@meshcoding.com>
 <52DF0D4E.5070207@wirelesspt.net> <52DF0ECE.7000707@meshcoding.com>
 <52DF10D1.4080207@wirelesspt.net> <52DF1156.6000606@meshcoding.com>
In-Reply-To: <52DF1156.6000606@meshcoding.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2014.0.0 released
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

inline:

On 01/21/2014 07:31 PM, Antonio Quartulli wrote:
> On 22/01/14 01:29, cmsv wrote:
>>
>>
>> On 01/21/2014 07:20 PM, Antonio Quartulli wrote:
>>> On 22/01/14 01:14, cmsv wrote:
>>>>
>>>>
>>>> On 01/21/2014 07:06 PM, Antonio Quartulli wrote:
>>>>> On 22/01/14 01:00, Antonio Quartulli wrote:
>>>>>> On 21/01/14 21:01, cmsv wrote:
>>>>>>> Yes i understand that but it keeps on increasing.
>>>>>>> [   28.600000] batman_adv: bat0: The MTU of interface adhoc0 is too
>>>>>>> small (1546) to handle the transport of batman-adv packets. Packets
>>>>>>> going over this interface will be fragmented on layer2 which could
>>>>>>> impact the performance. Setting the MTU to 1560 would solve the problem.
>>>>>>
>>>>>> Have you tried applying this patch before testing it once again?
>>>>>>
>>>>>> http://git.open-mesh.org/batman-adv.git/commit/746d6436f88899a79c1cb3b27af0614510368bb7
>>>>>>
>>>>>
>>>>> Actually this patch is already part of the batman-adv package in openwrt.
>>>>> Therefore the question turns in: did you update the batman-adv package
>>>>> before performing your second test?
>>>>
>>>> the second test was done today and  yesterday's i updated bataman-adv.
>>>
>>> Yes but we are creating confusion.
>> Maybe. Lets see.
>>>
>>> In the second test you *enabled* network coding, therefore it is normal
>>> that the overhead grew up. This happens because NC uses more bytes for
>>> its header.
>>
>>
>> In both tests NC was enabled. I have NC enabled by default before and
>> after the update.
>> In fact is all tests NC is enabled by default and i undestand the
>> increase to 1546 but to 1560 it surprised me.
>> Should i still see the increase to 1560  or should it stayed at 1546
>> which would be 1532 ?
>>
>>
> 
> [Please don't remove the batman-adv mailing list from the CC field.]
> 
unintentional mistake of too many buttons around :P

> 
> The first test you have performed was without the patch that fixes the
> value reported in that message.
> 
> 
> 
> Now that the patch is applied you have to see 1560 when NC is enabled
> and 1532 when it is disabled.

Doing some tests and with NC disabled:

 uci show batman-adv | grep network_coding
batman-adv.bat0.network_coding=0

after reboot:

# dmesg | grep MTU
[   28.030000] batman_adv: bat0: The MTU of interface adhoc0 is too
small (1546) to handle the transport of batman-adv packets. Packets
going over this interface will be fragmented on layer2 which could
impact the performance. Setting the MTU to 1560 would solve the problem.

 uci show network | grep mtu
network.mesh0.mtu=1546

changing the mtu to 1560 when NC is disabled:

# uci show batman-adv | grep network_coding
batman-adv.bat0.network_coding=0

# dmesg | grep MTU
no output/result

# ifconfig | grep MTU
          UP BROADCAST RUNNING MULTICAST  MTU:1560  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1440  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1440  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

Frist result if the adhoc interface with 1560

correct me if i am mistaken but according to you it should be 1532 ?

Changing it to 1532 still keeping network coding disabled.

uci set network.mesh0.mtu=1532
uci commit network
reboot

 uci show network| grep mtu
network.mesh0.mtu=1532

 uci show batman-adv | grep network_coding
batman-adv.bat0.network_coding=0

# dmesg | grep MTU
[   28.020000] batman_adv: bat0: The MTU of interface adhoc0 is too
small (1532) to handle the transport of batman-adv packets. Packets
going over this interface will be fragmented on layer2 which could
impact the performance. Setting the MTU to 1560 would solve the problem.

# dmesg | grep MTU
[   28.020000] batman_adv: bat0: The MTU of interface adhoc0 is too
small (1532) to handle the transport of batman-adv packets. Packets
going over this interface will be fragmented on layer2 which could
impact the performance. Setting the MTU to 1560 would solve the problem.

# ifconfig | grep MTU
          UP BROADCAST RUNNING MULTICAST  MTU:1532  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1440  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1440  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1


Changing now the MTU to 1560

uci set network.mesh0.mtu=1560
uci commit network
reboot

Keeping batman-adv.bat0.network_coding=0

# uci show network| grep mtu
network.mesh0.mtu=1560

# ifconfig | grep MTU
          UP BROADCAST RUNNING MULTICAST  MTU:1560  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1440  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1440  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

# dmesg | grep MTU
no complaints.


if i enable network coding and the mtu to 1560 no complaints either.

> Can you confirm?

confirmed ?
>
> 
> cheers,


