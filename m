Return-Path: <srn@coolheads.com>
Reply-To: srn@coolheads.com
Subject: Re: can't find logged information
References: <24aa48bb-8f52-78be-28df-98ec2e2a054b@coolheads.com>
 <1594276.uRpPO4E4fP@prime>
 <60314915-68db-93c4-c35f-0a593015c7ba@coolheads.com>
 <1851274.gzzsXW5Q3G@prime>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <a687012a-8857-22f3-0623-d82bad19e7bc@coolheads.com>
Date: Tue, 11 Feb 2020 14:03:32 -0500
MIME-Version: 1.0
In-Reply-To: <1851274.gzzsXW5Q3G@prime>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

First a report about trace-cmd.=A0 It's not working right, I think, in the =

bleeding-edge ("trunk") distribution of OpenWRT that I'm using.

Then, in case you are inclined to respond, below are some=20
observations/questions about the loss-of-contact I'm experiencing in my=20
meshes.

---------------------------------------------

 =A0I tried setting 'batctl ll bla'.=A0 (I suspect something to do with=20
bridge loop avoidance may be what's killing our meshes.)=A0 After that,=20
the cat /sys/kernel/debug/batman_adv/bat0/log method works pretty well,=20
but the trace-cmd method produces little or nothing.

root@rpc152:~# trace-cmd stream -e batadv:batadv_dbg
trace-cmd: Invalid argument
 =A0 [cfg80211:cfg80211_tx_mlme_mgmt] function __le16_to_cpup not defined
trace-cmd: Invalid argument
 =A0 [cfg80211:cfg80211_rx_unprot_mlme_mgmt] function __le16_to_cpup not=20
defined
 =A0 [cfg80211:cfg80211_rx_mlme_mgmt] function __le16_to_cpup not defined
Hit Ctrl^C to stop recording

[the above lines appear to be coming from stderr]

[... here I wait a long time, and there's no output, so eventually I=20
grow impatient and I interrupt ...]

^C^Croot@rpc152:~#

----------------------------------------------

Sometimes after interrupting I get a few lines of bridge-loop-avoidance=20
log entries; here is such a case:

@rpc152:/root# trace-cmd stream -e batadv:batadv_dbg
trace-cmd: Invalid argument
 =A0 [cfg80211:cfg80211_tx_mlme_mgmt] function __le16_to_cpup not defined
trace-cmd: Invalid argument
 =A0 [cfg80211:cfg80211_rx_unprot_mlme_mgmt] function __le16_to_cpup not=20
defined
 =A0 [cfg80211:cfg80211_rx_mlme_mgmt] function __le16_to_cpup not defined
Hit Ctrl^C to stop recording
 =A0 C-c C-c=A0=A0=A0=A0=A0=A0=A0=A0=A0 <idle>-0=A0=A0=A0=A0 [000] 81408.63=
4044:=20
batadv_dbg:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 batman_adv bat0 batadv_bla_proces=
s_claim():=20
received a claim frame from another group. From: 0c:80:63:e1:59:40 on vi\
d 1 ...(hw_src 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <...>-4595=A0 [000] 81409.423996: batadv_db=
g:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
batman_adv bat0 batadv_bla_purge_claims(): timed out.
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <...>-4595=A0 [000] 81409.424016: batadv_db=
g:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
batman_adv bat0 batadv_bla_purge_claims(): 5c:1d:d9:54:09:8f, vid 32769
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <...>-4595=A0 [000] 81409.424034: batadv_db=
g:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
batman_adv bat0 batadv_bla_send_claim(): UNCLAIM 5c:1d:d9:54:09:8f on vid 1
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <...>-4595=A0 [000] 81409.424053: batadv_db=
g:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
batman_adv bat0 batadv_handle_unclaim(): UNCLAIM 5c:1d:d9:54:09:8f on=20
vid 1 (sent by 50:c7:bf:69:bb:17)...
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <...>-4595=A0 [000] 81409.424065: batadv_db=
g:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
batman_adv bat0 batadv_bla_del_claim(): 5c:1d:d9:54:09:8f, vid 1
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <...>-4595=A0 [000] 81409.424092: batadv_db=
g:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
batman_adv bat0 batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17=20
on vid 1
 =A0=A0=A0=A0=A0=A0=A0=A0=A0 <idle>-0=A0=A0=A0=A0 [000] 81418.874031: batad=
v_dbg:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
batman_adv bat0 batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(h\
w_src 43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <...>-4595=A0 [000] 81419.663601: batadv_db=
g:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=20
batman_adv bat0 batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17=20
on vid 1
@rpc152:/root#

------------------------------------------------

With the cat /sys/kernel/debug/batman_adv/bat0/log method of=20
log-reading, there's generally oodles of output.=A0 At first it comes all=20
in a rush, and then it continues more slowly but still pretty steadily:

@rpc152:/root# cat /sys/kernel/debug/batman_adv/bat0/log
[=A0 81068650] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81069440] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81078890] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81079680] batadv_bla_purge_claims(): timed out.
[=A0 81079680] batadv_bla_purge_claims(): 64:c7:53:e6:f8:ae, vid 32769
[=A0 81079680] batadv_bla_send_claim(): UNCLAIM 64:c7:53:e6:f8:ae on vid 1
[=A0 81079680] batadv_handle_unclaim(): UNCLAIM 64:c7:53:e6:f8:ae on vid 1 =

(sent by 50:c7:bf:69:bb:17)...
[=A0 81079680] batadv_bla_del_claim(): 64:c7:53:e6:f8:ae, vid 1
[=A0 81079680] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81079680] Send loopdetect frame for vid 32769
[=A0 81079680] batadv_bla_send_claim(): LOOPDETECT of ba:be:22:e0:3f:ec to =

ff:ff:ff:ff:ff:ff on vid 1
[=A0 81089130] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81089920] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81099370] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81100160] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81109610] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81110400] batadv_bla_purge_claims(): timed out.
[=A0 81110400] batadv_bla_purge_claims(): 5c:1d:d9:54:09:8f, vid 32769
[=A0 81110400] batadv_bla_send_claim(): UNCLAIM 5c:1d:d9:54:09:8f on vid 1
[=A0 81110400] batadv_handle_unclaim(): UNCLAIM 5c:1d:d9:54:09:8f on vid 1 =

(sent by 50:c7:bf:69:bb:17)...
[=A0 81110400] batadv_bla_del_claim(): 5c:1d:d9:54:09:8f, vid 1
[=A0 81110400] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81119850] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81120640] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81130090] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81130880] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81140330] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81141120] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81141120] Send loopdetect frame for vid 32769
[=A0 81141120] batadv_bla_send_claim(): LOOPDETECT of ba:be:e5:06:19:6e to =

ff:ff:ff:ff:ff:ff on vid 1
[=A0 81150100] batadv_bla_rx(): Unclaimed MAC 5c:1d:d9:54:09:8f found.=20
Claim it. Local: no
[=A0 81150100] batadv_bla_add_claim(): adding new entry 5c:1d:d9:54:09:8f, =

vid 1 to hash ...
[=A0 81150100] batadv_bla_send_claim(): CLAIM 5c:1d:d9:54:09:8f on vid 1
[=A0 81150570] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81151360] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81160810] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81161600] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81171050] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81171840] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81181290] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81182080] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81191530] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81192320] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81201770] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81202560] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81202560] Send loopdetect frame for vid 32769
[=A0 81202560] batadv_bla_send_claim(): LOOPDETECT of ba:be:bb:25:c7:93 to =

ff:ff:ff:ff:ff:ff on vid 1
[=A0 81212010] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81212800] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81222250] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81223040] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81232490] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81233280] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1
[=A0 81242730] batadv_bla_process_claim(): received a claim frame from=20
another group. From: 0c:80:63:e1:59:40 on vid 1 ...(hw_src=20
43:05:43:05:00:00, hw_dst ff:43:05:02:c0:74)
[=A0 81243520] batadv_bla_send_claim(): ANNOUNCE of 50:c7:bf:69:bb:17 on vi=
d 1

-------------------------------------------------------------------------

...so if I were you I wouldn't hurry to remove=20
/sys/kernel/debug/batman_adv/bat0/log.=A0 The trace-cmd stuff doesn't=20
appear to work quite correctly yet.

-----------------------------------------------------------------------

Now my first question is: what does it mean to have a

"LOOPDETECT of ba:be:aa:c0:d6:bf to ff:ff:ff:ff:ff:ff"

?

-----------------------------------------------------------------------

When nodes become unreachable, they do so only partially.=A0 Consider this =

weirdness I encountered two days ago:=A0 Given nodes a, b, c, d, from the=20
perspective of a, d has disappeared; in other words, "a# batctl ping d"=20
doesn't work.=A0 But I ssh'd from a to b, then from b to c, then from c to =

d, all successfully.=A0 And "a# batctl ping d" still wasn't working, even=20
though I was talking to d through that chain of ssh pipes.=A0 Any ideas on =

what that might mean?=A0 (When I reboot a -- the gateway -- everything=20
always works again, usually for many hours, but never as long as a whole=20
day.)

Assuming some mischief is being done in bridge-loop-avoidance-land, and=20
bearing in mind that both meshes are physically laid out as simple=20
linear daisy-chains, is there a way to force each node to ignore all=20
nodes other than its immediate lefthand and righthand nodes?=A0 If that's=20
possible, it might allow an interesting experiment.

----------------------------------------------------------------------

Do I have a problem because the two meshes, and everything connected to=20
them, all share the same LAN?=A0 I note "received a claim frame from=20
another group" in the above log excerpt.=A0 (I don't know what that means, =

but I'm guessing that the two meshes are getting each other's=20
maintenance traffic.)=A0 Should the two meshes be separate subnets?

In a similar vein: Should each node be running its own subnet?

----------------------------------------------------------------------

Should I try changing all nodes over to BATMAN_V, rebooting them all,=20
and hoping they re-establish contact?=A0 (It would be massively=20
inconvenient to have to reset them all physically.)

----------------------------------------------------------------------

Should I try turning off bridge loop avoidance?

---------------------------------------------------------------------

Should I try turning on ap_isolation?

---------------------------------------------------------------------

Any other ideas?


On 2/7/20 12:07 PM, Simon Wunderlich wrote:
> On Friday, February 7, 2020 5:59:27 PM CET Steve Newcomb wrote:
>> On 2/7/20 10:52 AM, Simon Wunderlich wrote:
>>> Oops, you are right, we have actually removed that command in 2019.2. Y=
ou
>>> can use one of the two following commands:
>>>
>>> cat /sys/kernel/debug/batman_adv/bat0/log
>> The cat method works.  Thanks.  Wow, with all the debug info selected,
>> it's a torrent of stuff.  (Which I expected.)
>>
> Awesome
>
>>> (will be removed in the future when debugfs support is dropped
>>>
>>>    trace-cmd stream -e batadv:batadv_dbg
>> Uh, *which* of the two above commands will be dropped?  Should I add
>> trace-cmd to my menuconfig to retain access to the logs?  I haven't
>> added it yet.
> the /sys/kernel/debug/batman_adv/bat0/log file will be removed in the fut=
ure.
> So yes, add the trace-cmd
>>   > By "works" you mean you get useful outputs where the timeout is not
>>
>> increasing or similar? can you still "batctl ping" to one of your neighb=
ors?
>>
>> You are far ahead of where I am.  I meant only that I was getting what
>> appears to be useful information, not that I have interpreted it.  It
>> will take me a while to figure out how to read it.  I would be grateful
>> for any hints on that, and I'm already very grateful for the help you
>> have provided.
>>
>> I haven't been using "batctl ping" to cue a reboot; I've been using
>> "ping".  I'm not sure what difference it might make to use "batctl
>> ping"; it seems to me that if I can't "ping" a node, after 3 or 4 trials
>> over a period of 15-20 seconds, I'm no longer in touch with it in any
>> usable way.  When that happens, as long as I don't reboot the gateway,
>> everything just stays offline.  So it's better to reboot.
>>
>> By the way, at least one user is using the mesh for landline telephone
>> (Google Voice) service, so I'd really like to stabilize it if I can.
> So in iw station dump and and batctl neighbor table, there is a "last see=
n"
> field or "inactive time". Usually those fields should be < 5 seconds or s=
o, if
> they rise then it means this station has been lost somehow.
>
> The difference between batctl ping and a regular ping is that the batctl =
ping
> is actually implemented INSIDE of batman-adv, so it will be used to ping a
> certain mesh participant. Therefore batctl ping relies on less "moving pa=
rts"
> such as correctly configured IPs, MAC address translation, etc. If batctl=
 ping
> works but regular ping doesn't then we know something on the Ethernet
> transport part is off. The other way around (batctl ping doesn't work but
> regular ping does) is pretty much impossible unless the user does somethi=
ng
> wrong. If batctl ping to a neighbor doesn't work, it's likelythe Wifi lay=
er or
> something else is exhibiting problems or batman-adv is not set up correct=
ly.
>
> Cheers,
>         Simon

