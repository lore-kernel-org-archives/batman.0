Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <5078131D.9070508@altermundi.net>
Date: Fri, 12 Oct 2012 09:54:53 -0300
From: =?UTF-8?B?Tmljb0VjaMOhbml6?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <507798EE.80305@codigosur.org> <50779CA3.9070208@yahoo.de>
 <5077A77B.3040803@altermundi.net> <20121012071559.GB2564@ritirata.org>
In-Reply-To: <20121012071559.GB2564@ritirata.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: ap mode with isolation enabled
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

On 10/12/12 04:15, Antonio Quartulli wrote:
> On Fri, Oct 12, 2012 at 02:15:39 -0300, NicoEchániz wrote:
>>
>> Is the setup clear enough now? or am I missing the point as to what is
>> unclear? Please ask whatever needs to be clarified.
>>
> 
> Hello Nicolás,
> 
> I think I got your point. First, you are talking about the "normal" AP isolation
> feature that you can enable in hostapd, right? Because in batman-adv we have our
> own (Distributed) AP-isolation but it has different effects and behaviours.

exactly, it is the "normal" AP isolation feature.


> The behaviour is correct: OGMs are broadcast packets. In infrastructure mode,
> whatever broadcast packet a station sends gets to the AP which will re-broadcast
> it again. In this way every station gets it and from the batman-adv point of
> view it is like the packet was received directly from the other sta (the MAC
> addresses in the packet say so). Therefore you must enable ap-isolation in
> hostapd if you want batman-adv to behave as you expect.

Does this mean that with isolation turned off stations will try to
communincate directly if they can? Say, if we have two stations that are
far from the AP but very near each other, will they actually send
(unicast) packets to each other without going through the AP at all? If
so, activating isolation might be eliminating real possible paths, all
for the sake of sane originator tables.


I believe our mixed setup is not standard practice, that's why I wanted
to share this real-world results.


cheers,
NicoEchániz


