Return-Path: <gtolon@inti.gob.ar>
Message-ID: <51B22D19.7080807@inti.gob.ar>
Date: Fri, 07 Jun 2013 15:57:29 -0300
From: =?UTF-8?B?R2FicmllbCBUb2zDs24=?= <gtolon@inti.gob.ar>
MIME-Version: 1.0
References: <20130606055102.GH1789@ritirata.org>
 <51B0D294.4070809@inti.gob.ar> <20130606182954.GI1789@ritirata.org>
 <51B0DD43.6090500@inti.gob.ar> <20130606191823.GJ1789@ritirata.org>
 <51B1E4D6.5000900@inti.gob.ar> <20130607135713.GL1789@ritirata.org>
 <51B1F062.3060101@inti.gob.ar> <20130607144019.GM1789@ritirata.org>
 <51B214AE.2090603@inti.gob.ar> <20130607172734.GO1789@ritirata.org>
In-Reply-To: <20130607172734.GO1789@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
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


El 07/06/13 14:27, Antonio Quartulli escribió:
> Hello Gabriel,
>
> On Fri, Jun 07, 2013 at 02:13:18PM -0300, Gabriel Tolón wrote:
>>
>> This time, I logged just from Equipo 1, to generate less traffic.
>>
>> I noticed something weird. When I run batctl bw I get this time
>> something like 12 Mbps. If I wait for about 10 seconds and repeat the
>> command, I get something similar, but, if I run the command inmediatly
>> after the bw test finishes, the result improves a lot, here you can see
>> the commands with the seconds between them:
>>
>>
>> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
>> Fri Jun  7 16:40:09 UTC 2013
>> Bandwidth meter called towards 64:70:02:4e:d9:d7
>> Test over in 2000ms.
>> Sent 3064500 Bytes.
>> Throughput: 1.46 MB/s (12.26 Mbps)
>> root@Equipo 1:~#
>> root@Equipo 1:~#
>> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
>> Fri Jun  7 16:40:15 UTC 2013
>> Bandwidth meter called towards 64:70:02:4e:d9:d7
>> Test over in 2000ms.
>> Sent 3201000 Bytes.
>> Throughput: 1.53 MB/s (12.80 Mbps)
>> root@Equipo 1:~#
>> root@Equipo 1:~#
>> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
>> Fri Jun  7 16:40:18 UTC 2013
>> Bandwidth meter called towards 64:70:02:4e:d9:d7
>> Test over in 2000ms.
>> Sent 14545500 Bytes.
>> Throughput: 6.94 MB/s (58.18 Mbps)
>> root@Equipo 1:~#
>> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
>> Fri Jun  7 16:40:20 UTC 2013
>> Bandwidth meter called towards 64:70:02:4e:d9:d7
>> Test over in 2000ms.
>> Sent 18729000 Bytes.
>> Throughput: 8.93 MB/s (74.91 Mbps)
>> root@Equipo 1:~#
>> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
>> Fri Jun  7 16:40:23 UTC 2013
>> Bandwidth meter called towards 64:70:02:4e:d9:d7
>> Test over in 2000ms.
>> Sent 21067500 Bytes.
>> Throughput: 10.05 MB/s (84.26 Mbps)
>> root@Equipo 1:~#
>> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
>> Fri Jun  7 16:40:26 UTC 2013
>> Bandwidth meter called towards 64:70:02:4e:d9:d7
>> Test over in 2000ms.
>> Sent 22351500 Bytes.
>> Throughput: 10.66 MB/s (89.40 Mbps)
>> root@Equipo 1:~#
>> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
>> Fri Jun  7 16:40:37 UTC 2013
>> Bandwidth meter called towards 64:70:02:4e:d9:d7
>> Test over in 2000ms.
>> Sent 13281000 Bytes.
>> Throughput: 6.33 MB/s (53.12 Mbps)
>> root@Equipo 1:~#
>> root@Equipo 1:~#
>> root@Equipo 1:~#
>> root@Equipo 1:~# date; batctl bw -t 2000 E3-5GHz
>> Fri Jun  7 16:40:49 UTC 2013
>> Bandwidth meter called towards 64:70:02:4e:d9:d7
>> Test over in 2000ms.
>> Sent 3204000 Bytes.
>> Throughput: 1.53 MB/s (12.82 Mbps)
>> root@Equipo 1:~#
>>
>>
>> Maybe something in the time calculation is wrong?
>>
>
> This strange. The point is that the receiver takes at least 1 second to shutdown
> the session. Theoretically (and this is what happened during my tests) the
> receiver should refuse any "second new" connection and the sender should then
> get 0 throughput. Can I ask you what wifi driver is your device using?

It's using ath9k.


> Anyway, there must be something wrong in the bw meter given that you see this
> behaviour only with it and not with iperf.

Yes, with iperf I didn't notice anything strange.

>
> Did you try a short run over Ethernet? I'm curious to see if the behaviour will
> be the same.
>
>> The logs aretoo heavy for pastebin, so here it's just the part
>> corresponding to the first batctl bw in Equipo1:
>>
>> http://pastebin.com/THEr2Cq3
>>
>
> Thanks for the log.
>
> I saw something strange:
>
> 16:40:09.533172 BAT 64:70:02:4e:d9:43 > E3-5GHz: ICMP BW type MSG (0), id 0, seq
> 2018499, ttl 50, v 15, length 1510
> 16:40:09.533392 BAT 64:70:02:4e:d9:43 > E3-5GHz: ICMP BW type MSG (0), id 0, seq
> 2049999, ttl 50, v 15, length 1510
>
> These are two packets sent one after the other but the second sequence number is
> not equal to the first + 1500 (payload size)
>
>> If you want to watch the whole log I can send you, or paste it in parts.
>>
>
> This gave me already some hints. I'll dig into the code to try to spot what's
> wrong. But strange that I did not see any problem during my tests..maybe
> something introduced later by accident.

Yes, that's strange, that's why I asked if you had tested the same. It 
couldn't be due to hardware differences? Just in case WDR3500 have 
AR9344 SoC.

>
>
> Thank you so far. I'm still curious about the Ethernet test, then I'll try to
> upload some more code to test :)

Now I've made some tests with ethernet, with similar results:

root@Equipo 1:~#
root@Equipo 1:~#
root@Equipo 1:~# date; batctl bw -t 2000 E3-eth0
Fri Jun  7 18:36:10 UTC 2013
Bandwidth meter called towards 64:70:02:4e:d9:d5
Test over in 2000ms.
Sent 1354500 Bytes.
Throughput: 661.13 KB/s (5416.00 Kbps)
root@Equipo 1:~# date; batctl bw -t 2000 E3-eth0
Fri Jun  7 18:36:14 UTC 2013
Bandwidth meter called towards 64:70:02:4e:d9:d5
Test over in 2000ms.
Sent 1393500 Bytes.
Throughput: 679.69 KB/s (5568.00 Kbps)
root@Equipo 1:~# date; batctl bw -t 2000 E3-eth0
Fri Jun  7 18:36:17 UTC 2013
Bandwidth meter called towards 64:70:02:4e:d9:d5
Test over in 2000ms.
Sent 5550000 Bytes.
Throughput: 2.65 MB/s (22.20 Mbps)
root@Equipo 1:~# date; batctl bw -t 2000 E3-eth0
Fri Jun  7 18:36:19 UTC 2013
Bandwidth meter called towards 64:70:02:4e:d9:d5
Test over in 2000ms.
Sent 9412500 Bytes.
Throughput: 4.49 MB/s (37.65 Mbps)
root@Equipo 1:~# date; batctl bw -t 2000 E3-eth0
Fri Jun  7 18:36:26 UTC 2013
Bandwidth meter called towards 64:70:02:4e:d9:d5
Test over in 2000ms.
Sent 1389000 Bytes.
Throughput: 677.73 KB/s (5552.00 Kbps)
root@Equipo 1:~#


Here the batctl td on Equipo1, like before, cut because of size:

http://pastebin.com/xXyypzzw

This time there's a warning about an unknown batman packet type.


Regards

Gabriel

