Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <50781309.3020608@altermundi.net>
Date: Fri, 12 Oct 2012 09:54:33 -0300
From: =?UTF-8?B?Tmljb0VjaMOhbml6?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <507798EE.80305@codigosur.org> <50779CA3.9070208@yahoo.de>
 <5077A77B.3040803@altermundi.net> <20121012071559.GB2564@ritirata.org>
 <5077EE5F.8030601@yahoo.de>
In-Reply-To: <5077EE5F.8030601@yahoo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

On 10/12/12 07:18, Marek Lindner wrote:
> On 10/12/2012 03:15 PM, Antonio Quartulli wrote:
>> The behaviour is correct: OGMs are broadcast packets. In
>> infrastructure mode,
>> whatever broadcast packet a station sends gets to the AP which will
>> re-broadcast
>> it again. In this way every station gets it and from the batman-adv
>> point of
>> view it is like the packet was received directly from the other sta
>> (the MAC
>> addresses in the packet say so). Therefore you must enable
>> ap-isolation in
>> hostapd if you want batman-adv to behave as you expect.

> I'd like to stress the point that batman-adv is not "confused" as you
> describe it in your blog post. Antonio explained it already: In
> infrastructure mode all station _are_ neighbors.

Yes, I understand that, thus the use of quotes, but i'll try to find
more appropriate wording; it's the human administrator watching
originator tables that actually gets confused ;)







