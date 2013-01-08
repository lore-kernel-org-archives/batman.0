Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <50EC4A67.2000107@altermundi.net>
Date: Tue, 08 Jan 2013 13:33:43 -0300
From: =?UTF-8?B?Tmljb0VjaMOhbml6?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <CAHQ_bgg4rRDVAhNce9SdONkFbF946EYrMgvT79kyp_bxk8T8NQ@mail.gmail.com>
 <201301081906.33146.lindner_marek@yahoo.de>
 <CAHQ_bgiL+tEz+3Lz+CFWH3Q-n7JhcDqSxRCQRxx-gcd=nYwjEw@mail.gmail.com>
 <201301082052.12517.lindner_marek@yahoo.de>
In-Reply-To: <201301082052.12517.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Latency Related Problem
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

On 01/08/2013 09:52 AM, Marek Lindner wrote:
> 
> Hi,
> 
> you don't like the mailing list ? Why do you keep mailing me privately ? this 
> is the last time I respond to mails you send to me privately concerning 
> batman-adv. Use the mailing list!
> 
> On Tuesday, January 08, 2013 19:36:45 you wrote:
>> I am not comparing the ping between two nodes.
>>
>> I am just concerned about the ping latency between nodes.
>>
>> As per my experiment, I am getting 100ms delay between one hop(SPK3
>> –to-SPK2) and 200 ms delay between two hops (SPK3-to-SPK1) and so on.
>>
>> Even 100ms delay seems a lot, some applications may not work properly.
>>
>> Is there any delay (buffer) involved in local packet delivery from  bat0 to
>> local mesh interfaces (wlan0)?
> 
> yes, there is standard wifi buffering. Consider this:
> 
> ping time from node1 to node2: ~100ms
> ping time from node2 to node3: ~100ms
> 
> => ping time from node1 to node3: ~200ms
> 
> The delays simply add up because wifi is a shared medium. The node in the 
> middle can only forward the packet while it does not receive. That is due to 
> how wifi works and has nothing to do with batman-adv.
> 
> If you wish to mitigate the delay you should not use a shared medium. For 
> example using multiple wifi cards on different channels is a solution.


There must be some other problem involved here. We have very good ping
times with batman advanced in working networks as well as test setups.
See this article for example:

http://blog.altermundi.net/article/multiple-hop-mesh-performance-with-multi-band-dual/



