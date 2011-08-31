Return-Path: <tracer@robotech.de>
Message-ID: <4E5E64EF.2010706@robotech.de>
Date: Wed, 31 Aug 2011 18:44:31 +0200
From: Tobias <tracer@robotech.de>
MIME-Version: 1.0
References: <4E5D69E3.30403@robotech.de>
	<201108311155.27490.lindner_marek@yahoo.de>
	<CAKeC-QGag_c+g93MbiJWL9HB3iOczbfbatYUAA1wEEFSyvyd2g@mail.gmail.com>
In-Reply-To: <CAKeC-QGag_c+g93MbiJWL9HB3iOczbfbatYUAA1wEEFSyvyd2g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Am 31.08.2011 17:57, schrieb wayne abroue:
> On Wed, Aug 31, 2011 at 11:55 AM, Marek Lindner<lindner_marek@yahoo.de>  wrote:
>> Hi,
>>
>>> At first everything seemed to work. A node on the one end could ping a
>>> node on the other end over the mesh-network. The ping was hopping from
>>> node to node as expected.
>>>
>>> But sometimes some paths do not work anymore.
>>>
>>> Some nodes can only reach their direct neighbors via a "normal ping". A
>>> ping to a node via one hop does not work. A "batctl ping" does work!
>>>
>>> This only happens to parts of the network and is not permanent. If i
>>> wait it will recover, but then the problem appears at another node.
>> since "batctl ping" works I'd say your mesh works fine - you have a problem in
>> your higher layers. Maybe a mac address collision or an ARP timeout ?
>>
>> Can you provide specific examples we can go through ? For instance, provide
>> the batctl ping output to the neighbor in question, the ping error message
>> (does it say timeout / host could not be found / etc), a batctl traceroute to
>> the neighbor in question and the output of the global translation table.
>>
>> Are you trying to ping a 'fixed' node or a node that is roaming ?
>>
>> Regards,
>> Marek
>>
>>
> I'd also check signal strength,, have experienced this  when levels
> are fluctuating, ie: batctl ping works, ip not. then comes back.
>
> Wayne A
Hi Wayne,

the signal level is not very good - but it should be sufficient. (around 
40-60%)

Even when i keep both pings running at the same time, only the "batctl 
p" works.

Tobias
